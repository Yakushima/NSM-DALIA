rm -r frames mp4s primes videos.txt
mkdir -p frames mp4s primes
perl deaf.pl < EnglishNSM.txt | sh | sort -u | sh
perl nsm.pl < EnglishNSM.txt > interface.html
perl deaf2.pl < Eng2.txt | sh | sort -u | sh
perl nsm2.pl < Eng2.txt > index.html
