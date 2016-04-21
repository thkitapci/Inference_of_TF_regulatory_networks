#!/usr/bin/perl -w

use strict;

use warnings;

open ("IN","");

 my @header;

foreach(<IN>){chomp;


   @header=split(/\s+/,$_);


      if($header[2]<=){


     print "$header[0]\t$header[1]\t$header[2]\n";


               }

                }
