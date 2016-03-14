#!/bin/sh
#PBS -l mem=1000MB
#PBS -l vmem=1000MB
#PBS -l pmem=1000MB
#PBS -l nodes=1:ppn=1
#PBS -l walltime=5:00:00
#PBS -q cmb

#Script written to be run on the hpc cluster directory names and paths should be adjusted to run on a different system

cd ~/cmb/data/embryo

BAM="$(find bam/ -name '*.bam')"


for file in $BAM
do
   echo $file
   id=`echo $file | cut -d "/" -f2`
   echo $id
   ~/panfs/tools/samtools-1.2/bin/samtools view -h -o tmp.sam $file
   perl -pe 's/jM.+//g' tmp.sam > tmp2.sam
   ~/panfs/tools/HTSeq-0.6.1/scripts/htseq-count -q -s no -r pos tmp2.sam ~/cmb/data/genomes/dm3/Drosophila_melanogaster.BDGP5.75.gtf > counts/$id.counts
   rm *.sam
done
