#!/usr/bin/perl -w

use strict;

use warnings;

my %count;

open("IN","genes_have_p_value_less_than_6");

foreach(<IN>){chomp;

  my @array=split(/\s+/,$_);
  
   foreach my$genes($array[0]){chomp;

   $count{$genes}++;

  }
 }
 
while(my($genes,$c)=each(%count)){

     print "$genes\t$c\n";

  }    
        
