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
	$primes{$title} = '"'.join('", "', @sentences).'"';
}

foreach (@titles) {
	if (! -e "webpages/".$_) {
		print ("wget64  --output-document=\"webpages/".$_."\" \"https://www.signingsavvy.com/sign/".$_."\"\n");
	}
	print ("perl pdeaf.pl '".$_."'\n");
}
