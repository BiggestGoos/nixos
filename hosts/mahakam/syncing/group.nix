{ szy, config, ... }:
{

  "${szy}".users.types.normal.groups = [
    config.sync.user
  ];

}
