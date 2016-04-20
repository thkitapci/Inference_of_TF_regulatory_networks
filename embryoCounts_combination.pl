#!/usr/bin/perl -w
use strict;

open "IN", "embryoCounts.tab";

$_=<IN>;
chomp;
my %Hashsample;
my @header=split(/\t/, $_);
      print "Genes\t";
for(my $i=1; $i<= $#header; $i++){
	$header[$i]=~s/_\d$//;	
	
       $Hashsample{$header[$i]}=1;

            } 
my %Hash;
  while(<IN>) {chomp;

    my @line=split(/\t/,$_);
   
  for(my $i=1;$i<$#line;$i++){
  
 $Hash{$line[0]}{$header[$i]}+=$line[$i];

  }
  }
for my $sample(sort keys %Hashsample){

   print "$sample\t";

  }
  print "\n";
for my $genes(sort keys %Hash){
        print "$genes\t";
for my $sample(sort keys %Hashsample){
         if($Hash{$genes}{$sample}){
          print "$Hash{$genes}{$sample}\t";
     }else{
     
     print"0\t";
     }
   }
  print"\n";
 }


   
 


   
   
 
 

  
  
 

 

  






 

  

   

