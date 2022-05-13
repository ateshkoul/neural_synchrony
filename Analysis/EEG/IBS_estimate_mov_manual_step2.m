data_analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
analysis = 'Brain_behavior_glm_power_freqwise';
% analysis_sub_type = '_insta_corr_avg_freqwise';
% analysis_sub_type ='_insta_abs_detrend';
conditions = {{'FaNoOcc_1'},{'FaNoOcc_2'},{'FaNoOcc_3'},{'NeNoOcc_1'},{'NeNoOcc_2'},{'NeNoOcc_3'},{'Task_1'},{'Task_2'},{'Task_3'}};
% conditions = {{'FaNoOcc_1'},{'FaNoOcc_2'},{'FaNoOcc_3'},{'NeNoOcc_1'},{'NeNoOcc_2'},{'NeNoOcc_3'}};
% step 2 manual check estimation
behav_analysis = 'joint';
output_data = 'no_joint';
behavior_data_AND = cellfun(@(cond) IBS_load_behavior_data(behavior,data_analysis_type,1:23,cond,...
    behav_analysis,analysis_sub_type,output_data),conditions,'UniformOutput',0);

cur_behav_fraction_AND = cellfun(@(cond) cellfun(@(x) cell2mat(cellfun(@(sub) nansum(isnan(table2array(sub(:,1))))/1201,...
    x,'UniformOutput',0)),cond,'UniformOutput',0),behavior_data_AND,'UniformOutput',0);

cur_behav_fraction_AND_nan = cellfun(@(cond) cellfun(@(x) sum(eq(x,1)),cond,'UniformOutput',0),cur_behav_fraction_AND,'UniformOutput',0);
