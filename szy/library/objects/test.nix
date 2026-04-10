{ identifier, config, lib, meta, ... }@mInputs:
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
		callerData
	}:
	if (meta.callerDataAssert callerData) then null else
	{

		

	};

}
