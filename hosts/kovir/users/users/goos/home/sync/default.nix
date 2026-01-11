{ szy, lib, ... }:
{

	options = {

		"${szy}".sync = {

			remotes = {

			};



		};

	};

	config = {

		programs.rclone = {

			enable = true;

			remotes = {

				onedrive = {

					config = {

						type = "onedrive";
						token = ''{"access_token":"EwBIBMl6BAAUu4TQbLz/EdYigQnDPtIo76ZZUKsAAfO6pCyaEA/SQzk4FnFMIfP5qR+CEUgzH7eNjmXcrBJyA+rjl/J3CYG+4mAhN5ZjVUas980zjEjy/SEN2W8l7lNNFOdoERkU9kqL4GpbdEY3KGgyUy6fmE0TNS4s1LqMtCI0GbziZ8SGU6MJm7T1mJXZ8Oiz/Z+pA2H6FSa0VSKfTNWOO+5u0OhrLMJqGXeLz0hOKrB/3HdofVnrIrEV5vl+s3hXjl653aV9ipaXRf6w9hpW07eCJsW+Im5XyXygon57Qu0ISiscyyeDUOpcTTpx8aRJq4NeutP0xsEU1k7xFgrLD2fxJ+rkxiQuCVC1Kcg0l0CeSQCI7BsNyMpRn2kQZgAAEFrHdFrii2tLrnoqW0LKsA4QA4NWJsVFYk9VgUclyMq4x1ZF6Ft+zeiNvPIyQrVXbSqzIl5teqrq4RCcmYl4+mFo4V6BAk7awP52XaBjxY3KTi3KdF2GrgBuUFxCMYVTa5h2Z0iSgijuia5eFiyZNsKQK050IiT3X6//czp58gL5WJUeQ6QLwO1jj/WEO5lSSkAu45yt85vV++92lEjW6yoyR5hcg4zwep5j5Bu1XZ8KCmwfEzkC6ETIH6jVr0qGEPcvPGhvELo+J5qX/K0NbTO7IPsYNJkuHdccThcntHrc4pD8Q/E1FB2AuAPkTBH6pRsghRP1aq0dtkkIf0rhUUqfR8klX1rMevo4v98nxZjkViL6Ms1zGi93KKAiya/iSV6OEP2lq2YDfQAfmwLlmwH5w6N8qqHMofKOuLRiJjPGMxthr3pUTMR9BkGFfVuQsHtKbgJ4nxIcM79RviiDhQe+Akexk1tAFtR763r0+YWGmVsnkhTh00yfatBkCNmI13jukfTqr7h6blS9RKnBwD009Lzey4CoEirSU/s+uD7/ubb1lbut1/KqoI3NEAr+z/YO2neu3pzgDj7pATYJ3Eb3OYccMJ6UDCVESHfKXOr5dERp3fRjtrojtt6tI0EVdFII4YlegRJjyXmrYbLNkZKBO9Qweg7PecMMi1yyu1lmFvoOpng3z1ovGn/dGrj3ivvv/KdRlzixH7rHATdEnLHzw7V/eOHK3WMPGILdyDJf9fR3r8tvG8ewQBFikNsWtfN2LKYxAUud8exsJAiLJYgkUdSZOqIMgRzcFBHMbXrGni79YovubFzd6NNoUkps4B7kTRDyWyJYaoi4JZLUYcF8fdePxwtklaw4N85TIxj08BmaxEy7fcoFOZmGXQXaaafXKkI7d3MFuG7J1cY1YqR1lACp9VmcRyAiOb3wXcWm6kCMhKFozSculRSrDUzGgV6YAMuA15T9/Syovdg9nH+0nw8pVXw607V1Lug1+tDkt4tyNvTFskglhiUokJJrqhmP6vg7HJmoscbhfNmbznheaLZHSdcwH43LDgMF0rXIOmxJAw==","token_type":"Bearer","refresh_token":"M.C551_BL2.0.U.-Ch2f1nA9n6KdTWamzjBq0bZJxlC15HgEhc1VBH6pVtpCz!Bo9U2PmQHMtRHxw8!iz6OZkh60O4!rCZdxO850CNwFsWnYjqT0O4A27lkGUS2GhE1Yb2lZ9Bp3ZO*tNx!!w85Z3uGAwWHw*XYTuBHRwYlzbJyORuoNguRxWxRt7HCYZV1pd23VoU8hmYIJcvgJFJLSKBZrcNJSc3IXgivy88E*BA4BvMJPnLYPkui3NrTcgwXMxogdJnq*eRYZCwideh5CZoa3Oduj*Chw4pLSRSmSZHQEwSXNP7YU9!P3Y9gdO7wsS1U1GFOxb3HtyRuKXEqzXGDslDfiqHg6!GWWKm7X18HCqDcojkRJKq3JvN6i","expiry":"2025-12-27T19:25:52.195152194+01:00","expires_in":3599}'';

						drive_type = "personal";
						drive_id = "AFEAEC28925FF1B6";

					};

					/*mounts = {

						"Games/Modding/TheWitcher1" = {

							enable = true;
							mountPoint = "/home/goos/Games/Modding/TheWitcher1";

							options = {
								vfs-cache-mode = "full";
							};

						};

					};*/

				};

			};

		};

		home.activation.testFile = lib.hm.dag.entryAfter ["writeBoundary"] ''touch /home/goos/test.txt'';

	};


	

}
