#!/bin/bash
#SBATCH --job-name=asl
#SBATCH --time=24:00:00
#SBATCH -n 1
#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=4G

module load fsl/6.0.6.2

STUDY=/work/cnelab/TECHS/MRI/preprocessed_data/asl
BIDS=/work/cnelab/TECHS/MRI/BIDS
T1=/work/cnelab/TECHS/MRI/preprocessed_data/anat

unset LD_LIBRARY_PATH
subj=03
#ANAT=/work/cnelab/TECHS/MRI/preprocessed_data/anat/sub-${subj}/sub-${subj}_post/fsl.anat
#MASK=${T1}/sub-${subj}/sub-${subj}_post/fsl.anat.anat/first_results
#while read subj
#make some directories
    mkdir ${STUDY}/sub-${subj}/sub-${subj}_post
#copy files from bids
    cp -rf ${BIDS}/sub-${subj}/ses-post/perf/* ${STUDY}/sub-${subj}/sub-${subj}_post
#do 
#first preprocess T1 using fsl_anat
  #  fsl_anat -i ${BIDS}/sub-${subj}/ses-post/anat/*.nii.gz -o ${T1}/sub-${subj}_post/
#copy files from bids to preprocessing dir
    cp ${BIDS}/sub-${subj}/ses-post/perf/sub-${subj}_ses-post_pcasl_multidelay_perf.nii.gz ${STUDY}/sub-${subj}/sub-${subj}_post
 fslsplit ${STUDY}/sub-${subj}/sub-${subj}_post/sub-${subj}_ses-post_pcasl_multidelay_perf.nii.gz ${STUDY}/sub-${subj}/sub-${subj}_post/sub-${subj}
  fslmerge -a ${STUDY}/sub-${subj}/sub-${subj}_post/sub-${subj}_pcasl_multidelay_perf.nii.gz ${STUDY}/sub-${subj}/sub-${subj}_post/sub-${subj}0002.nii.gz ${STUDY}/sub-${subj}/sub-${subj}_post/sub-${subj}0003.nii.gz ${STUDY}/sub-${subj}/sub-${subj}_post/sub-${subj}0004.nii.gz ${STUDY}/sub-${subj}/sub-${subj}_post/sub-${subj}0005.nii.gz ${STUDY}/sub-${subj}/sub-${subj}_post/sub-${subj}0006.nii.gz ${STUDY}/sub-${subj}/sub-${subj}_post/sub-${subj}0007.nii.gz ${STUDY}/sub-${subj}/sub-${subj}_post/sub-${subj}0008.nii.gz ${STUDY}/sub-${subj}/sub-${subj}_post/sub-${subj}0009.nii.gz ${STUDY}/sub-${subj}/sub-${subj}_post/sub-${subj}001* ${STUDY}/sub-${subj}/sub-${subj}_post/sub-${subj}002*
    mv ${STUDY}/sub-${subj}/sub-${subj}_post/sub-${subj}0000.nii.gz ${STUDY}/sub-${subj}/sub-${subj}_post/m0.nii.gz
    oxford_asl -i ${STUDY}/sub-${subj}/sub-${subj}_post/sub-${subj}_pcasl_multidelay_perf.nii.gz --iaf tc --ibf tis --casl --bolus 1.5 --rpts 2,2,2,3,3 --tis 2.0,2.5,3.0,3.5,4.0 --fslanat ${T1}/sub-${subj}/sub-${subj}_post/fsl.anat.anat -c ${STUDY}/sub-${subj}/sub-${subj}_post/m0.nii.gz --cmethod single --tr 4.1 --cgain 1 --tissref csf --t1csf 4.3 --t2csf 750 --t2bl 150 --te 36.48 -o ${STUDY}/sub-${subj}/sub-${subj}_post/basil_basic --bat 1.3 --t1 1.3 --t1b 1.65 --alpha 0.85 --spatial --fixbolus --mc --region-analysis --senscorr
#    echo ${subj}
#done < ${STUDY}/subj.txt

#${MASK}/T1_first-L_Accu_corr.nii.gz, ${MASK}/T1_first-L_Amyg_corr.nii.gz, ${MASK}/T1_first-L_Caud_corr.nii.gz, ${MASK}/T1_first-L_Hipp_corr.nii.gz, ${MASK}/T1_first-L_Pall_corr.nii.gz, ${MASK}/T1_first-L_Puta_corr.nii.gz, ${MASK}/T1_first-L_Thal_corr.nii.gz, ${MASK}/T1_first-R_Accu_corr.nii.gz, ${MASK}/T1_first-R_Amyg_corr.nii.gz, ${MASK}/T1_first-R_Caud_corr.nii.gz, ${MASK}/T1_first-R_Hipp_corr.nii.gz, ${MASK}/T1_first-R_Pall_corr.nii.gz, ${MASK}/T1_first-R_Puta_corr.nii.gz, ${MASK}/T1_first-R_Thal_corr.nii.gz
