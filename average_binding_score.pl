#!/usr/bin/perl -w
 
use strict; use warnings;

my %hash;
my %id2c;

die "usage: <average_score.pl> <TF_results_patser_scores_5_10.txt>\n" unless @ARGV == 1;

open("IN", $ARGV[0]);

foreach(<IN>){
	#chomp;
	$_ =~ s/[\r\n]//g;#similar to chomp but more robust

	my @line=split(/\t/,$_);
	if(exists $hash{$line[0]}){
		$hash{$line[0]} += $line[1];
		$id2c{$line[0]} ++;
	}else{
		$hash{$line[0]} = $line[1];
		$id2c{$line[0]} = 1;
	}
}
close IN;

open(AVG,">$ARGV[0].avg") or die "err out2\n";

for my$key(sort keys %hash){

	print AVG "$key\t",$hash{$key}/$id2c{$key},"\n";
}

