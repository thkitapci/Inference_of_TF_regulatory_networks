#!/usr/bin/perl -w

use strict;

use warnings;

my %count;

open("IN","TF_results_patser_scores_5_10.txt");

foreach(<IN>){chomp;

  my @array=split(/\s+/,$_);
  
   foreach my$genes($array[0]){chomp;

   $count{$genes}++;

  }
 }
 
while(my($genes,$c)=each(%count)){

     print "$genes\t$c\n";

  }    
        
