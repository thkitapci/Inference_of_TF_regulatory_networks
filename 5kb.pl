
#!/usr/bin/perl -w

use strict;

open("IN","engrailed_genes");

foreach(<IN>){

   	chomp;

	my @line=split(/\t/,$_);
	
	my $start=0;
     my $pre=0;
     my $count =1;
	my $end=0;
         
       	my $strand=$line[4];
        
        my $start_position=$line[2];
        
        my $end_position=$line[3];

        if($strand eq "+")
	{

        	$start=$start_position-5000;

        	$end=$start_position;
	}

        elsif($strand eq "-")
	{

        	$start=$end_position;

         	$end=$end_position+5000; 
	}
	open("aa","correlatedaccessibleregions");		
	foreach(<aa>){

		chomp;
                                
		my @array=split(/\t/,$_);
                  
                my $chromosome=$array[0];
               
		if($chromosome eq $line[1]){  #checking match chromosome 

			if($array[1] gt $start && $array[2] lt $end){
      
if($line[0] eq $pre)                                                    
	{
$count++;
print "$line[0]_$count\t$line[1]\t$array[1]\t$array[2]\n";            

}else
{
$count=0; 
print "$line[0]\t$line[1]\t$array[1]\t$array[2]\n";            
}


     $pre=$line[0]
			} 	
		}                        	 
	}

						 
			
} 

