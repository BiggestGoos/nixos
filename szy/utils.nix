{ root, hostname }:
{

	inherit root hostname;

	fromRoot = path: "${root}/${path}";
	
	fromShared = path: "${root}/shared/${path}";

}
