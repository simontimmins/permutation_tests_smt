#housekeeping FP PT
#!/bin/bash

# Grid Engine options go here, e.g.:
#$ -cwd
#$ -l h_rt=48:00:00
#$ -l h_vmem=64G
#$ -l rl9=true
#$ -m ae
#$ -t 1-5


source /etc/profile.d/modules.sh
module load R/4.3
fp_list=(zero
/exports/igmm/eddie/semple-lab/stimmins/chipseeker/chipseeker_nbl_footprints/specificity/germline_specific_distal.bed
/exports/igmm/eddie/semple-lab/stimmins/chipseeker/chipseeker_nbl_footprints/specificity/germline_specific_promoter_prox.bed
/exports/igmm/eddie/semple-lab/stimmins/chipseeker/chipseeker_nbl_footprints/specificity/somatic_specific_distal.bed
/exports/igmm/eddie/semple-lab/stimmins/chipseeker/chipseeker_nbl_footprints/specificity/somatic_specific_promoter_prox.bed
)

peaks_names=(zero
germline_specific_distal
germline_specific_promoter_prox
somatic_specific_distal
somatic_specific_promoter_prox)
atac=${fp_list[${SGE_TASK_ID}]};
peak_name=${peaks_names[${SGE_TASK_ID}]};
echo $peaks
echo $peak_name
vcf=/exports/igmm/eddie/semple-lab/stimmins/gnomad_v4/1811/gnomAD_v4_5_20_ins1811.vcf
name=${peak_name}_fps_5-20_ins
atac=/exports/igmm/eddie/semple-lab/stimmins/peak_specificity/nbl/germline_specific_fps.ms.bed
output=$name'.pdf'
echo $vcf
echo $name
echo $atac
echo $output
echo 'now running rscript'
Rscript /exports/igmm/eddie/semple-lab/stimmins/perms/xia_oocyte/indels/generic_pt_masked.R $vcf $name $atac $output
