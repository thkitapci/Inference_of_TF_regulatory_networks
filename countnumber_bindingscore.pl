#!/usr/bin/perl -w

use strict;

use warnings;

open("IN","number_binding_sites_TF.txt");

open("aa","TF.avg.txt");

my@in=(<IN>);

my@aa=(<aa>);

 foreach(@in){chomp;

      my @array=split(/\s+/,$_);
           
foreach(@aa){chomp;

        my @line=split(/\s+/,$_);

if($array[0]eq $line[0]){

   print "$array[0]\t$array[1]\t$line[1]\n";

                     } 

  } 

  
   }
  

    

      
        
