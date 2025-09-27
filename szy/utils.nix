{ root, lib, hostname }:
{

	inherit root hostname;

	fromRoot = path: "${root}/${path}";
	
	fromShared = path: "${root}/shared/${path}";

	mergeAll = sets:
    let
	    f = a: b:
        	if builtins.isAttrs a && builtins.isAttrs b then
          		builtins.mapAttrs (k: v:
            		if b ? ${k} then f v b.${k} else v
          		) a // builtins.removeAttrs b (builtins.attrNames a)
        	else
        		b;
    in builtins.foldl' f {} sets;

}
