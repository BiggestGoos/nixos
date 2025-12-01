{ root, rawRoot, lib, hostname }:
{

	inherit root rawRoot hostname;

	fromRoot = path: "${root}/${path}";
	
	fromShared = path: "${root}/shared/${path}";

	import = import ./import.nix { inherit root lib; };

	mergeAll = sets:
    let
	   /* f = a: b:
        	if builtins.isAttrs a && builtins.isAttrs b then
          		builtins.mapAttrs (k: v:
            		if b ? ${k} then f v b.${k} else v
          		) a // builtins.removeAttrs b (builtins.attrNames a)
        	else
        		b;*/
		deepMerge =
        	lhs: rhs:
	        lhs
    	    // rhs
        	// (builtins.mapAttrs (
	          rName: rValue:
    	      let
        	    lValue = lhs.${rName} or null;
	          in
    	      if builtins.isAttrs lValue && builtins.isAttrs rValue then
        	    deepMerge lValue rValue
	          else if builtins.isList lValue && builtins.isList rValue then
    	        lValue ++ rValue
        	  else
	            rValue
    	    ) rhs);
    in 
		builtins.foldl' deepMerge {} sets;

	mergeAllConflict = sets:
    let
	    f = a: b:
        	if builtins.isAttrs a && builtins.isAttrs b then
			let
				overlaps = builtins.intersectAttrs a b;
			in
				if (overlaps != {}) then
					throw "mergeAll: these values overlap ${builtins.toJSON overlaps}"
				else
	          		builtins.mapAttrs (k: v:
    	        		if b ? ${k} then f v b.${k} else v
        	  		) a // builtins.removeAttrs b (builtins.attrNames a)
        	else
        		b;
    in builtins.foldl' f {} sets;

}
