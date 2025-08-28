#housekeeping FP PT
#!/bin/bash

# Grid Engine options go here, e.g.:
#$ -cwd
#$ -l h_rt=24:00:00
#$ -l h_vmem=64G
#$ -l rl9=true
#$ -m ae

source /etc/profile.d/modules.sh
module load R/4.3

vcf=/exports/igmm/eddie/semple-lab/stimmins/gnomad_v4/gnomAD_v4_5_20_insertions.sorted.bed
name=housekeeping_fps_5-20bp_ins
atac=/gpfs/igmmfs01/eddie/semple-lab/stimmins/peak_specificity/nbl/housekeeping.ms.bed
output=$name'.pdf'
echo $vcf
echo $name
echo $atac
echo $output
echo 'now running rscript'
Rscript /exports/igmm/eddie/semple-lab/stimmins/perms/xia_oocyte/indels/generic_pt_masked.R $vcf $name $atac $output
