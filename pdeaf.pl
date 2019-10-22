open(FILE, "<webpages/".@ARGV[0]);
open(VIDEOS, ">>videos.txt");
while (<FILE>) {
	my @matches = ($_ =~ m/[^"]*\.mp4/g);
	$files = join(",", @matches);
	print $files
	$localfiles = $files;
	$localfiles =~ s/.*\/(.*)/mp4s\/$1/;
	if ($localfiles) {
		print ("wget64 --output-document='$localfiles' 'https://www.signingsavvy.com/$files'\n");
		print VIDEOS @ARGV[0]." ".$files."\n";
	}
}
close(FILE);
close(VIDEOS);
