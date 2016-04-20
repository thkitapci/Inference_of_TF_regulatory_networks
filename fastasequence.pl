#!/usr/bin/perl -w

use strict;

use warnings;

open ("IN","Drosophila_melanogaster.BDGP5.75.dna.toplevel.fa");

open("aa","position_accessible_regions_genes_TF.txt");

open(RES,">results.txt");

my %hash;
my @header;
my $seq;

foreach(<IN>){chomp;

     if($_=~/>/){
       s/\>//;
       @header=split(/\s+/,$_);
}
     else{
	$hash{$header[0]}.=$_;
         }
} 
 
foreach(<aa>){
		chomp;
               my @array=split(/\t/,$_);

               my $start=$array[2];

               my $end=$array[3]; 

               $seq=$hash{$array[1]};
               
              my @line=split(//,$seq);    
               
                print RES "$array[0] \\"; 

 for(my $i=$start;$i<=$end;$i++){

         print RES $line[$i];

                              }


            print RES "\\\n";
               }



      




                 

       


                                   
                                             
                                        

                              
