#!/usr/bin/perl -w
use strict; use warnings;

open ("IN","genes_count_average_expression_bicoid");
open (OUT,">positive.txt") or die;
open (OUT2,">negative.txt") or die;

my @header;

foreach(<IN>){chomp;
	@header=split(/\s+/,$_);
	if ($header[1]>2){
		if($header[3] > 0) {
			print OUT "$header[0]\t$header[1]\t$header[2]\t$header[3]\n";
		}elsif($header[3] < 0) {
			print OUT2 "$header[0]\t$header[1]\t$header[2]\t$header[3]\n";
		}else{
			warn  "format err in column 4\n";
		}
	}
}  

