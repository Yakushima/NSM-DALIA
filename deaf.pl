%primes = {};
@titles = ();
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
	if (! -e "webpages/".$title) {
		print ("wget64  --output-document=\"webpages/".$title."\" \"https://www.signingsavvy.com/sign/".$title."\"\n");
	}
	print ("perl pdeaf.pl '".$title."'\n");


	@sentences = @$primes{$title};
	foreach (@sentences) {
		$sentence = $_;
		$sentence =~ s/\//;/g;
		if (! -e "frames/$sentence") {
			print ("wget64  --output-document=\"frames/".$sentence."\" \"https://www.signingsavvy.com/sign/".$sentence."\"\n");
		}
		print ("perl pdeaf.pl '".$sentence."'\n");
	}
}
