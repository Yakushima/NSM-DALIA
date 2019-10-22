open(FILE, "<".@ARGV[0]);
open(VIDEOS, ">>videos.txt");
while (<FILE>) {
	my @matches = ($_ =~ m/[^"]*\.mp4/g);
	$files = join(",", @matches);
	if ($files) {
		print ("wget64 --output-document='mp4s/$files' 'https://www.signingsavvy.com/$files'\n");
		print VIDEOS @ARGV[0]." ".$files."\n";
	}
}
close(FILE);
close(VIDEOS);
