#!/usr/bin/perl -w

use strict;

use warnings;

open("IN","genes_names_count_average_tf.txt");

open("aa","expression_covariation_tf_14.txt");

my@in=(<IN>);

my@aa=(<aa>);

 foreach(@in){chomp;

      my @array=split(/\s+/,$_);

foreach(@aa){chomp;

        my @line=split(/\s+/,$_);

if($array[0]eq $line[0]){

   print "$array[0]\t$array[1]\t$array[2]\t$line[1]\n";

                     }

  }


   }
