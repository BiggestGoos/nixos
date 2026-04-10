{ lib, ... }:
let

	# Can identify lists and sets containing just one "flat" type as, e.g. "list, string".
	typeOf = input: 
	let
		baseType = builtins.typeOf input;
		resolvedType = if (builtins.elem baseType [ "set" "list" ]) then
			baseType + innerSuffix
		else
			baseType;

		innerSuffix = 
		let
		
			list = if (baseType == "list") then input else (lib.attrsets.attrValues input);

			headType = (builtins.typeOf (builtins.head list));

			allSame = lib.lists.all (value: (builtins.typeOf value) == headType) list;

		in
			if (list == [] || !allSame) then "" else ", ${headType}";
	in
		resolvedType;

	# Naive
	compareTypes = lType: rType:
	let
		nestRemover = type: builtins.head (lib.strings.splitString "," type);
	in
		if (lType == rType) then true else (if ((nestRemover lType) == (nestRemover rType)) then true else false);

	_callerData = {

		dataValues = {
			config = typeOf {};
			path = typeOf ./.;
			optionNamespace = typeOf [ "string" ];
		};

	};

in
rec {

# Maybe create an assert function and move all "callerData" things into one set called "callerData", call the "callerData" function "typeCheck" or something like that.

	# Metadata about the "caller", e.g. data about the calling location or the "optionNamespace" of the caller.
	callerData = 
	let

		inherit (_callerData) dataValues;

	in
	data:
		lib.attrsets.filterAttrs 
		(name: value: 
		let
			result =
				(lib.asserts.assertMsg 
					(builtins.hasAttr name dataValues)
					"callerData value \"${name}\" does not exist."
				) && 
				(lib.asserts.assertMsg 
					(compareTypes dataValues."${name}" (typeOf value))
					"callerData value of \"${name}\" { ${builtins.toJSON value} } is the wrong type. Correct type: \"${dataValues."${name}"}\", Used type: \"${typeOf value}\"."
				);
		in
			result
		) data;

	callerDataTest = 
	{
		data,
		requiredValues ? []
	}:
	let
		resolvedData = callerData data;
	in
		if (lib.lists.all 
		(value: 
			lib.asserts.assertMsg 
			(builtins.elem value (builtins.attrNames _callerData.dataValues)) 
			"The required value \"${value}\" is not a real value."
		) requiredValues) 
		then 
			(lib.lists.naturalSort (lib.lists.intersectLists (requiredValues) (builtins.attrNames resolvedData))) == (lib.lists.naturalSort (requiredValues))
		else false;

}
