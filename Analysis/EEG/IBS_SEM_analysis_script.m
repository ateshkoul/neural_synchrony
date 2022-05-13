analysis = 'Brain_behav_physio_SEM_freqwise';

analysis_sub_type = '_insta_abs_detrend';% 
% analysis_sub_type = {'_insta_abs_detrend_corr_avg_freqwise'};
 
conditions = {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'};
data_analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
results_all_cond = IBS_SEM_analysis(data_analysis_type,analysis,conditions,analysis_sub_type);
