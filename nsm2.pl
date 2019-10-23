$primes = {};
@titles = ();
@allterminals = ();
while (<STDIN>) {
	chomp;
	$title = $_;
	@rule = ($_ =~ m/([~A-Z\' \(\)\/]+[^Ia-z])([^Ia-z])((.|[^\n])*)/g);
	$title = $rule[0];
	$title =~ s/[ \t]*$//;
	$title =~ s/\//;/g;
	$r = $rule[1].$rule[2];
	$r =~ s/^ *//;
	if ($r) {
		@sentences = split(',', $r);
		# @terminals = ($r =~ m/([\w|']+)/g);
		@terminals = ($r =~ m/(\S+)/g);
		push (@allterminals, @terminals);
	}
	if ($title) {
		push (@titles, $title);
		$primes{$title} = '"'.join('", "', @sentences).'"';
	}
}
@allterminals = do { my %seen; grep { !$seen{$_}++ } @allterminals };
@allterminals = sort(@allterminals);

print ("<html>\n");
print ("	<head>\n");
print ("		<title>American Sign Language Natural Semantic Metalanguage</title>\n");
print ("	</head>\n");
print ("<body>\n");
print ("<script>\n");
print ("var oldprime = null;\n");
print ("function addTerminal(terminal) {\n");
print ("	var sentence = document.getElementById('newSentence');\n");
print ("	var textNode = document.createTextNode(terminal);\n");
print ("	sentence.appendChild(textNode);\n");
print ("	var space = document.createTextNode(' ');\n");
print ("	sentence.appendChild(space);\n");
print ("}\n");
print ("function editSentences(newprime) {\n");
print ("	var newSentence = document.getElementById('newSentence');\n");
print ("	if (newSentence !== null && newSentence.childNodes !== null && newSentence.childNodes.length > 0 && oldprime !== null) {\n");
print ("		var title = document.getElementById(oldprime);\n");
print ("		var click = title.getAttribute('onclick');\n");
			# save the sentence in the onclick event
print ("		title.setAttribute('onclick', click.substring(0, click.length-16)+', \"'+newSentence.innerHTML+'\"); return false;');\n");
print ("	}\n");
print ("	var sentences = document.getElementById('sentences');\n");
print ("	while (sentences.firstChild) {\n");
print ("		sentences.removeChild(sentences.firstChild);\n");
print ("	}\n");
print ("	var div = document.createElement('div');\n");
print ("	for (var s = 1; s < arguments.length; s++) {\n");
print ("		var span = document.createElement('span');\n");
print ("		div.appendChild(span);\n");
print ("		var a = document.createElement('a');\n");
print ("	        a.setAttribute('href', 'https://www.signingsavvy.com/sign/'+arguments[s]);\n");
print ("		span.appendChild(a);\n");
print ("		var textNode = document.createTextNode(arguments[s]);\n");
print ("		a.appendChild(textNode);\n");
print ("		var br = document.createElement('br');\n");
print ("		div.appendChild(br);\n");
print ("	}\n");
print ("	var sentence = document.createElement('span');\n");
print ("	sentence.setAttribute('id', 'newSentence');\n");
print ("	div.appendChild(sentence);\n");
print ("	var nbr = document.createElement('br');\n");
print ("	div.appendChild(nbr);\n");
print ("	oldprime = newprime;\n");
print ("	sentences.appendChild(div);\n");
print ("}\n");
print ("</script>\n");
print ("<script src='https://code.jquery.com/jquery-3.4.1.min.js' integrity='sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=' crossorigin='anonymous'></script>\n");
print ("<h1>Semantic Primes (click to add, edit sentence examples of this prime)</h1>\n");
print ("<div>\n");
open (VIDEOS, "<videos.txt");
@videos = <VIDEOS>;
close (VIDEOS);
foreach (sort(@titles)) {
	$title = $_;
	$video = $_;
	@video = grep /\b$video\b/, @videos;
	$video = @video[0];
	$video =~ s/.*\/(.*)"\n/mp4s\/$1/;
	print ("<button onclick='editSentences(\"".$title."\", ".$primes{$title}."); return false;' id='".$title."'><video loop height='64' width='64' src='$video' ></video><a href=\"https://www.signingsavvy.com/sign/".$title."\">".$title."</a></button>\n");
}
print ("</div>\n");

print "\n";

print ("<div id='sentences'>\n");
print ("</div>\n");

print "\n";

print ("<h1>Syntactic Frame Elements (click to add to current sentence)</h1>\n");
print ("<div>\n");
foreach (sort(@allterminals)) {
	$terminal = lc($_);
	$prime = uc($_);
	$video = $prime;
	# TODO figure out how to make these non-terminals
	$video =~ s/[()=\[\]]//g;
	@video = grep /\b($video|can't|don't|doesn't)\b/, @videos;
	$video = @video[0];
	$video =~ s/.*\/(.*)"\n/mp4s\/$1/;
	print ("<button onclick='addTerminal(\"".$terminal."\"); return false;'><video loop height='64' width='64' src='$video'></video><a href=\"https://www.signingsavvy.com/sign/".$prime."\">".$terminal."</a></button>\n");
}
print ("</div>\n");
print ("</body>\n");
print ("</html>\n");
