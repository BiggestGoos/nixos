{ szy, lib, config, ... }:
{

	imports =
	[
		./templates
		./applications
		./test.nix
	];

	"${szy}".test.nested =
	{

		/*foo =
		{

			x.y.data.x = 5;

			#data.y = 2;

			str = "hello";

		};*/

		foo =
		{
			
			meta.modules = [ "testModule" "test2Module" ];

			str = "bar";	

			data.x = 2;

			#test.xy = 5;

			#int = config."${szy}".test.nested.foo.data.y * 4 + config."${szy}".test.nested.foo.tree.bar.data.x;
			#data = { y = lib.mkIf (config."${szy}".test.nested.foo.tree.bar.data.x >= 2) 11; x = 3; };
			/*tree =
			{

				bar =
				{

					modules = [ "testModule" ];

					str = "footwo";
					data = 
					{
						x = 3;
					};
				};

			};*/
		};

		bar =
		{
			str = "barbar";
			#data = { x = config."${szy}".test.nested.foo.data.y; };

		};

	};

}
