{ identifier, lib, utils, meta, ... }:
let

	prefixes = {

		objects = "objects";
		templates = "templates";
		definitions = "definitions";

	};

	keys = {

		template = with prefixes; [ identifier objects templates ];
		definition = with prefixes; [ identifier objects definitions ];

	};

in
{

	inherit prefixes keys;

	getTemplate =
	{
		callerData,
		id,
	}:
	let
		
		fullKeys = keys.template ++ lib.lists.toList id;

	in
	if !(meta.callerData { data = callerData; requiredFields = [ "config" ]; }) then null else
		utils.options.getFromKeys { keys = fullKeys; object = callerData.config; };
		

}
