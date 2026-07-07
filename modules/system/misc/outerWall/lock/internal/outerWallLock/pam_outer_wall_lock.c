#include <stdlib.h>
#include <string.h>
#include <security/pam_appl.h>
#include <security/pam_modules.h>
#include <security/pam_ext.h>
#include <syslog.h>
#include <unistd.h>

PAM_EXTERN int pam_sm_setcred( pam_handle_t *pamh, int flags, int argc, const char **argv ) {
	return PAM_SUCCESS;
}

PAM_EXTERN int pam_sm_acct_mgmt(pam_handle_t *pamh, int flags, int argc, const char **argv) {
	return PAM_SUCCESS;
}

static char *allowed_user = NULL, *lockfile = NULL;

static int lockfile_exists(void)
{
	return access(lockfile, F_OK) == 0;
}

static bool compare_prefix(const char* prefix, const char* arg)
{
	const char* cmp = strstr(arg, prefix);
	return (cmp == arg);
}

// (user)|(lock)= => 4 + 1 = 5
#define PREFIX_LENGTH 5

static char* get_value(const char* arg)
{
    // Length of value part. + 1 for null.
    int len = strlen(arg) - PREFIX_LENGTH + 1;
    char* value = malloc(len * sizeof(char));
    strncpy(value, arg + PREFIX_LENGTH, len);
    return value;
}

// (user)|(lock)=.+ => 4 + 1 + 1 = 6
#define MIN_ARG_LEN 6

// Returns PAM codes
static int parse_args(pam_handle_t *pamh, int argc, const char **argv)
{

	// We need just 2 arguments.
	if (argc != 2)
	{
		pam_syslog(pamh, LOG_ERR, "pam_outer_wall_lock: not right amount of args");
		return PAM_SERVICE_ERR;
	}

	if (strlen(argv[0]) < MIN_ARG_LEN)
	{
		pam_syslog(pamh, LOG_ERR, "pam_outer_wall_lock: arg 1 too short");
		return PAM_SERVICE_ERR;
	}

	if (compare_prefix("user=", argv[0]))
	{
		allowed_user = get_value(argv[0]);
	}
	else if (compare_prefix("lock=", argv[0]))
	{
		lockfile = get_value(argv[0]);
	}

	if (strlen(argv[1]) < MIN_ARG_LEN)
	{
		pam_syslog(pamh, LOG_ERR, "pam_outer_wall_lock: arg 2 too short");
		return PAM_SERVICE_ERR;
	}

	if (allowed_user == NULL && compare_prefix("user=", argv[1]))
	{
		allowed_user = get_value(argv[1]);
	}
	else if (lockfile == NULL && compare_prefix("lock=", argv[1]))
	{
		lockfile = get_value(argv[1]);
	}

	if (allowed_user == NULL || lockfile == NULL)
	{
		pam_syslog(pamh, LOG_ERR, "pam_outer_wall_lock: missing arguments");
		return PAM_SERVICE_ERR;
	}

	return PAM_SUCCESS;
}

static void free_args(void)
{
	if (allowed_user != NULL)
	{
		free(allowed_user);
	}
	if (lockfile != NULL)
	{
		free(lockfile);
	}
	allowed_user = NULL;
	lockfile = NULL;
}

PAM_EXTERN int pam_sm_authenticate(pam_handle_t *pamh, int flags,int argc, const char **argv) 
{
	free_args();

	int retval;

	retval = parse_args(pamh, argc, argv);

	if (retval != PAM_SUCCESS)
	{
		free_args();
		return retval;
	}

	if (lockfile_exists() == 0)
	{
		free_args();
		return PAM_SUCCESS;
	}

	const char* pUsername;
	retval = pam_get_user(pamh, &pUsername, NULL);

	if (retval != PAM_SUCCESS) 
	{
		free_args();
		return retval;
	}

	// Only succeed if the attempted login is with the allowed user
	if (strcmp(pUsername, allowed_user) == 0) 
	{
		free_args();
		return PAM_SUCCESS;
	}

	free_args();
	return PAM_AUTH_ERR;
}
