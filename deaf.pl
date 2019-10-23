%primes = {};
@titles = ();
@videos = ();

sub pdeaf {
	open(FILE, "<".@_[0]);
	@pvideos = ();
	while (<FILE>) {
		my @matches = ($_ =~ m/[^"]*\.mp4/g);
		$files = join(",", @matches);
		$outputfiles = $files;
		$outputfiles =~ s/.*\/(.*)/mp4s\/$1/;
		if (! -e $outputfiles && $outputfiles) {
			print ("wget64 --output-document='$outputfiles' 'https://www.signingsavvy.com/$files'\n");
		}
		if ($files) {
			push(@pvideos,  '"'.@_[0].'":"'.$files.'"');
		}
	}
	close(FILE);
	return @pvideos;
}

while (<STDIN>) {
	chomp;
	$title = $_;
	@sentences = ();
	$line = <STDIN>;
	while ($line =~ /^.+$/) {
		$sentence = $line;
		chomp $sentence;
		push (@sentences, ($sentence));
		$line = <STDIN>;
	}

	push (@titles, $title);
	@$primes{$title} = @sentences;
}

foreach (@titles) {
	$title = $_;
	if (! -e "primes/".$title) {
		print ("wget64  --output-document=\"primes/".$title."\" \"https://www.signingsavvy.com/sign/".$title."\"\n");
	}
	push (@videos,  &pdeaf("primes/$title"));


	@sentences = @$primes{$title};
	foreach (@sentences) {
		$sentence = $_;
		$sentence =~ s/\//;/g;
		if (! -e "frames/$sentence") {
			print ("wget64  --output-document=\"frames/".$sentence."\" \"https://www.signingsavvy.com/sign/".$sentence."\"\n");
		}
		push (@videos, &pdeaf("frames/$sentence"));
	}
}
# create unique videos
my @videos = do { my %seen; grep { !$seen{$_}++ } @videos };
open (VIDEOS, ">videos.txt");
print VIDEOS join("\n", @videos)."\n";
close(VIDEOS);
