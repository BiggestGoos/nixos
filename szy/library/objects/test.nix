{ identifier, config, lib, meta, ... }@gInputs:
let

	inherit
		identifier
		lib
		meta
	;

	

in
{

	declare =
	{
		name,
		onlyTemplate ? false,
	}:
	{

		options."${gInputs.identifier}".

	};

	/*declare = 
	{
		identifier,
		callerData
	}:
	if !(meta.callerData { data = callerData; requiredFields = [ "" ]; }) then null else
	{

		

	};*/

}
