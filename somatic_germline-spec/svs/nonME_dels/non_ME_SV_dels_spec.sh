#housekeeping FP PT
#!/bin/bash

# Grid Engine options go here, e.g.:
#$ -cwd
#$ -l h_rt=48:00:00
#$ -l h_vmem=64G
#$ -l rl9=true
#$ -m ae
#$ -t 1-10


source /etc/profile.d/modules.sh
module load R/4.3
fp_list=(zero
/exports/igmm/eddie/semple-lab/stimmins/chipseeker/chipseeker_nbl_footprints/specificity/germline_specific_distal.bed
/exports/igmm/eddie/semple-lab/stimmins/chipseeker/chipseeker_nbl_footprints/specificity/germline_specific_promoter_prox.bed
/exports/igmm/eddie/semple-lab/stimmins/chipseeker/chipseeker_nbl_footprints/specificity/somatic_specific_distal.bed
/exports/igmm/eddie/semple-lab/stimmins/chipseeker/chipseeker_nbl_footprints/specificity/somatic_specific_promoter_prox.bed
/exports/igmm/eddie/semple-lab/stimmins/chipseeker/chipseeker_nbl_footprints/specificity/somatic_specific_intronic.bed
/exports/igmm/eddie/semple-lab/stimmins/chipseeker/chipseeker_nbl_footprints/specificity/germline_specific_intronic.bed
/exports/igmm/eddie/semple-lab/stimmins/chipseeker/chipseeker_nbl_footprints/housekeeping/housekeeping_promoter_prox.bed
/exports/igmm/eddie/semple-lab/stimmins/chipseeker/chipseeker_nbl_footprints/housekeeping/housekeeping_distal.bed
/exports/igmm/eddie/semple-lab/stimmins/chipseeker/chipseeker_nbl_footprints/housekeeping/housekeeping_intronic.bed
)

peaks_names=(zero
germline_specific_distal
germline_specific_promoter_prox
somatic_specific_distal
somatic_specific_promoter_prox
germline_specific_intronic
somatic_specific_intronic
housekeeping_promoter_prox
housekeeping_distal
housekeeping_intronic)
atac=${fp_list[${SGE_TASK_ID}]};
peak_name=${peaks_names[${SGE_TASK_ID}]};
echo $peaks
echo $peak_name
vcf=/exports/igmm/eddie/semple-lab/stimmins/gnomad_v4/svs/svs2/gnomad.v4.1.sv.non_ME_dels.singleton.af.bed
name=${peak_name}_fps_nonME_SV_dels
output=$name'.pdf'
echo $vcf
echo $name
echo $atac
echo $output
echo 'now running rscript'
Rscript /exports/igmm/eddie/semple-lab/stimmins/perms/xia_oocyte/indels/generic_pt_masked.R $vcf $name $atac $output
