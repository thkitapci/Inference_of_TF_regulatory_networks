#!/bin/sh
#PBS -l mem=45000MB
#PBS -l vmem=45000MB
#PBS -l pmem=45000MB
#PBS -l nodes=1:ppn=24
#PBS -l walltime=100:00:00
#PBS -q cmb



#Script written to be run on the hpc cluster directory names and paths should be adjusted to run on a different system
#bam files can be downloaded from .................

cd ~/cmb/data/embryo

FASTQ="$(ls /home/cmb-07/sn1/tkitapci/Egg_Project_Data/Plate_2/ALL_Samples_Renamed/ | grep -Po '.+_\d' | sort -u)"


for id in $FASTQ
do
   echo $id
   
   mkdir bam/$id
   gzip -dc /home/cmb-07/sn1/tkitapci/Egg_Project_Data/Plate_2/ALL_Samples_Renamed/$id*R1.fastq.gz > $id.tmp1
   gzip -dc /home/cmb-07/sn1/tkitapci/Egg_Project_Data/Plate_2/ALL_Samples_Renamed/$id*R2.fastq.gz > $id.tmp2
   ~/panfs/tools/STAR-STAR_2.4.0k/source/STAR  --genomeDir ../genomes/dm3/star/ --runThreadN 24 --readFilesIn $id.tmp1 $id.tmp2 --outFileNamePrefix bam/$id/ --outReadsUnmapped Fastx --outSAMtype BAM SortedByCoordinate --outSAMattributes All --outFilterMultimapNmax 1 --outFilterType BySJout
   ~/panfs/tools/samtools-1.2/samtools index bam/$id/Aligned.sortedByCoord.out.bam
   rm $id.tmp1
   rm $id.tmp2
done
