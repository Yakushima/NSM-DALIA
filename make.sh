#!/bin/sh
# rm -r frames mp4s primes videos.txt html_primes html_nsm
mkdir -p frames mp4s primes html_primes html_nsm
perl deaf.pl < EnglishNSM.txt | sh | sort -u | sh
perl nsm.pl < EnglishNSM.txt > interface.html
perl deaf2.pl < Eng2.txt | sh | sort -u | sh
perl nsm2.pl < Eng2.txt > index.html
cat primes.txt | tr ' ' '\0' | xargs -0 python getglyphogram.py
cat primesandphrases.txt | tr '\n' '\0' | xargs -0 python goddard.py
