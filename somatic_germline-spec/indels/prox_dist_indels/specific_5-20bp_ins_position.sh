#germline/somatic specififc indels location cntext pecififc
#!/bin/bash

# Grid Engine options go here, e.g.:
#$ -cwd
#$ -l h_rt=24:00:00
#$ -l h_vmem=64G
#$ -l rl9=true
#$ -m ae
#$ -t 1-7
source /etc/profile.d/modules.sh
module load R/4.3

vcf=/exports/igmm/eddie/semple-lab/stimmins/gnomad_v4/gnomAD_v4_5_20_insertions.sorted.bed
atacs=(zero
/exports/igmm/eddie/semple-lab/stimmins/chipseeker/chipseeker_nbl_footprints/specificity/somatic_specific_promoter_prox.bed
/exports/igmm/eddie/semple-lab/stimmins/chipseeker/chipseeker_nbl_footprints/specificity/somatic_specific_distal.bed
/exports/igmm/eddie/semple-lab/stimmins/chipseeker/chipseeker_nbl_footprints/specificity/germline_specific_intronic.bed
/exports/igmm/eddie/semple-lab/stimmins/chipseeker/chipseeker_nbl_footprints/specificity/germline_specific_distal.bed
/exports/igmm/eddie/semple-lab/stimmins/chipseeker/chipseeker_nbl_footprints/specificity/germline_specific_distal.bed
/exports/igmm/eddie/semple-lab/stimmins/chipseeker/chipseeker_nbl_footprints/specificity/germline_specific_intronic.bed)
names=(zero
somatic_prox
somatic_distal
somatic_intronic
germline_prox
germline_distal
germline_intronic)
atac=${atacs[${SGE_TASK_ID}]}
basename=${names[${SGE_TASK_ID}]}
awk 'BEGIN {OFS="\t"}; {print $1, $2, $3}' $atac > ${atac}.simp
name=${basename}_5-20_ins
output=$name'.pdf'
echo $vcf
echo $name
echo $atac.simp
echo $output
echo 'now running rscript'
Rscript /exports/igmm/eddie/semple-lab/stimmins/perms/vk_21_sperm/generic_pt_masked.R $vcf $name ${atac}.simp $output
