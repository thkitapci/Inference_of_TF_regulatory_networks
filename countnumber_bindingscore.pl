#!/usr/bin/perl -w

use strict;

use warnings;

open("IN","count_bicoid_genes");

open("aa","bicoid_genes_average");

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
  

    

      
        
