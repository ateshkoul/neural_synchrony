%%
% If you believe that comparing AICs is a good way to choose a model then it
% would still be the case that the (algebraically) lower AIC is preferred not
% the one with the lowest absolute AIC value. To reiterate you want the most 
% negative number in your example.

analysis = 'Brain_behavior_glm_power_freqwise';
conditions = {{'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'}};

%%
analysis_sub_type = {'_insta_abs_detrend'};% 
% analysis_sub_type = {'_insta_abs_detrend_corr_avg_freqwise'};
 

results_all_cond = cellfun(@(x) cellfun(@(y) IBS_brain_behavior_glm('no_aggressive_CAR_ASR_10_ICA_appended_trials',analysis,y,x),conditions,...
    'UniformOutput',false),analysis_sub_type,'UniformOutput',false);

%%
analysis_sub_type = {'_insta_abs_detrend_mov_1s'};% 
results_all_cond_mov = cellfun(@(x) cellfun(@(y) IBS_brain_behavior_glm('no_aggressive_CAR_ASR_10_ICA_appended_trials',analysis,y,x),conditions,...
    'UniformOutput',false),analysis_sub_type,'UniformOutput',false);

%%
analysis_sub_type = {'_insta_abs_detrend_gamma_200avg'};% 
results_all_cond_mov = cellfun(@(x) cellfun(@(y) IBS_brain_behavior_glm('no_aggressive_CAR_ASR_10_ICA_appended_trials',analysis,y,x),conditions,...
    'UniformOutput',false),analysis_sub_type,'UniformOutput',false);

%%
analysis_sub_type = {'_insta_abs_detrend_gamma_200avg_lowess'};% 
results_all_cond_mov = cellfun(@(x) cellfun(@(y) IBS_brain_behavior_glm('no_aggressive_CAR_ASR_10_ICA_appended_trials',analysis,y,x),conditions,...
    'UniformOutput',false),analysis_sub_type,'UniformOutput',false);


%%
analysis_sub_type = {'_insta_abs_detrend_gamma_200avg'};% 
results_all_cond_mov = cellfun(@(x) cellfun(@(y) IBS_brain_behavior_glm('no_aggressive_CAR_ASR_10_ICA_appended_trials',analysis,y,x),conditions,...
    'UniformOutput',false),analysis_sub_type,'UniformOutput',false);
%%
analysis_sub_type = {'_insta_abs_detrend'};% 
results_all_cond_mov = cellfun(@(x) cellfun(@(y) IBS_brain_behavior_glm('no_aggressive_CAR_ASR_10_ICA_appended_trials',analysis,y,x),conditions,...
    'UniformOutput',false),analysis_sub_type,'UniformOutput',false);

%%
analysis_sub_type = {'_insta_abs_detrend_lowess_variable'};% 
results_all_cond_mov = cellfun(@(x) cellfun(@(y) IBS_brain_behavior_glm('no_aggressive_CAR_ASR_10_ICA_appended_trials',analysis,y,x),conditions,...
    'UniformOutput',false),analysis_sub_type,'UniformOutput',false);
%%
%%
analysis_sub_type = {'_insta_abs_detrend_movmean_variable'};% 
results_all_cond_mov = cellfun(@(x) cellfun(@(y) IBS_brain_behavior_glm('no_aggressive_CAR_ASR_10_ICA_appended_trials',analysis,y,x),conditions,...
    'UniformOutput',false),analysis_sub_type,'UniformOutput',false);
%%
analysis_sub_type = {'_insta_abs_detrend_movmean_causal'};% 
results_all_cond_mov = cellfun(@(x) cellfun(@(y) IBS_brain_behavior_glm('no_aggressive_CAR_ASR_10_ICA_appended_trials',analysis,y,x),conditions,...
    'UniformOutput',false),analysis_sub_type,'UniformOutput',false);


%%
analysis_sub_type = {'_insta_abs_detrend_movmean_acausal'};% 
results_all_cond_mov = cellfun(@(x) cellfun(@(y) IBS_brain_behavior_glm('no_aggressive_CAR_ASR_10_ICA_appended_trials',analysis,y,x),conditions,...
    'UniformOutput',false),analysis_sub_type,'UniformOutput',false);

%%
analysis_sub_type = {'_insta_abs_detrend_movmean_acausal_brain'};% 
results_all_cond_mov = cellfun(@(x) cellfun(@(y) IBS_brain_behavior_glm('no_aggressive_CAR_ASR_10_ICA_appended_trials',analysis,y,x),conditions,...
    'UniformOutput',false),analysis_sub_type,'UniformOutput',false);
%%
analysis_sub_type = {'_insta_abs_detrend_movmean_causal_brain'};% 
results_all_cond_mov = cellfun(@(x) cellfun(@(y) IBS_brain_behavior_glm('no_aggressive_CAR_ASR_10_ICA_appended_trials',analysis,y,x),conditions,...
    'UniformOutput',false),analysis_sub_type,'UniformOutput',false);

%%
analysis = 'Brain_behavior_glm_power_freqwise';
% analysis_sub_type = {'_insta_abs_detrend_corr_avg_freqwise'};
analysis_sub_type = {'_insta_abs_detrend'};% analysis_sub_type = {'_insta_abs'};% analysis_sub_type = {'_insta_abs_corr_avg_freqwise','_insta_abs_detrend','_insta_abs_no_detrend'};
conditions = {{'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'}};

results_all_cond = cellfun(@(x) cellfun(@(y) IBS_brain_behavior_glm_modulation('no_aggressive_CAR_ASR_10_ICA_appended_trials',analysis,y,x),conditions,...
    'UniformOutput',false),analysis_sub_type,'UniformOutput',false);


%%
% analysis_sub_type = {'_insta_corr_avg_freqwise'};
analysis_sub_type = {'_insta_abs_detrend'};

conditions = {{'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'}};
analysis = 'Brain_behavior_glm_power_freqwise';

results = cellfun(@(x) cellfun(@(y) IBS_brain_behavior_glm_binary('no_aggressive_CAR_ASR_10_ICA_appended_trials',analysis,y,x),conditions,...
    'UniformOutput',false),analysis_sub_type,'UniformOutput',false);

%%

% analysis_sub_type = {'_insta_corr_avg_freqwise'};
% analysis_sub_type = {'_insta_abs_detrend_corr_avg_freqwise','_insta_abs_no_detrend'};
analysis_sub_type = {'_insta_abs_detrend'};

conditions = {{'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'}};
analysis = 'Brain_behavior_glm_power_freqwise';

results = cellfun(@(x) cellfun(@(y) IBS_brain_behavior_glm_modulation_binary('no_aggressive_CAR_ASR_10_ICA_appended_trials',analysis,y,x),conditions,...
    'UniformOutput',false),analysis_sub_type,'UniformOutput',false);

%%
analysis = 'Brain_behavior_glm_power_freqwise';

analysis_sub_type = {'_insta_abs_detrend'};% 
% analysis_sub_type = {'_insta_abs_detrend_corr_avg_freqwise'};
 
conditions = {{'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'}};

results_all_cond = cellfun(@(x) cellfun(@(y) IBS_brain_behavior_glm_physiology('no_aggressive_CAR_ASR_10_ICA_appended_trials',analysis,y,x),conditions,...
    'UniformOutput',false),analysis_sub_type,'UniformOutput',false);

%%

analysis_type = {'no_aggressive_CAR_ASR_10_ICA_appended_trials'};
analysis = 'Brain_behavior_glm_power_freqwise';
analysis_sub_type = {'_insta_abs_detrend'};
conditions = {{'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'}};
results_all_cond = cellfun(@(x) cellfun(@(y) IBS_brain_behavior_glm('no_aggressive_CAR_ASR_10_ICA_appended_trials',analysis,y,x),conditions,...
    'UniformOutput',false),analysis_sub_type,'UniformOutput',false);

%%

analysis = 'Brain_behavior_glm_power_freqwise';

analysis_sub_type = {'_insta_abs_detrend'};% 
% analysis_sub_type = {'_insta_abs_detrend_corr_avg_freqwise'};
 
conditions = {{'Task_1','Task_2','Task_3'}};

results_all_cond = cellfun(@(x) cellfun(@(y) IBS_brain_behavior_glm('no_aggressive_CAR_ASR_10_ICA_appended_trials',analysis,y,x),conditions,...
    'UniformOutput',false),analysis_sub_type,'UniformOutput',false);


%%
analysis_sub_type = {'_insta_corr_avg_freqwise'};
conditions = {{'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'}};
analysis = 'Brain_behavior_glm_power_freqwise';

results = cellfun(@(x) cellfun(@(y) IBS_brain_behavior_glm_pos_neg('no_aggressive_CAR_ASR_10_ICA_appended_trials',analysis,y,x),conditions,...
    'UniformOutput',false),analysis_sub_type,'UniformOutput',false);

%%


% analysis_sub_type = {'_insta_avg_freqwise','_insta_20_data_smoothed','_insta','_insta_20','_insta_50','_IBS_moving_win'};
% analysis_sub_type = {'_insta_avg_freqwise_50'};
% analysis_sub_type = {'_insta_corr_avg_freqwise'};
% analysis_sub_type = {'_insta_abs_corr_avg_freqwise'};
% analysis_sub_type = {'_insta_abs_behav_corr_avg_freqwise'};
% analysis_sub_type = {'_insta_abs_no_detrend_behav_corr_avg_freqwise'};
% analysis_sub_type = {'_insta_abs_detrend_behav_corr_avg_freqwise'};
% analysis_sub_type = {'_insta_abs_behav_neg_corr_avg_freqwise'};
% analysis_sub_type = {'_insta_abs_detrend_corr_avg_freqwise'};
% analysis_sub_type = {'_insta_abs_detrend_corr_avg_freqwise'};
% analysis_sub_type = {'_insta_abs_corr_avg_freqwise'};
%  analysis_sub_type = {'_insta_abs_detrend_freqwise'};
% analysis_sub_type = {'_insta_abs_corr_avg_freqwise','_insta_abs_behav_corr_avg_freqwise','_insta_abs_no_detrend_behav_corr_avg_freqwise'};

% analysis_sub_type = {'_insta_abs_anti_corr_avg_freqwise'};
% analysis_sub_type = {'_insta_abs_ind_corr_avg_freqwise'};
% analysis_sub_type = {'_insta_abs_xor_corr_avg_freqwise'};
%% shifts
% AIC_cell = cat(1,glm_result.stats_cell{:});
% 
% s = cell2mat(cellfun(@(x) x.ModelCriterion{1,1},AIC_cell,'UniformOutput',0));
% 
% 
% plot(transpose(s-min(s,[],2)))


%%
% analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
% analysis_type = {'no_aggressive_trialwise_CAR'};
analysis_type = {'no_aggressive_CAR_ASR_10_ICA_appended_trials'};
% analysis_type = {'no_aggressive_CAR_ASR_5_ICA_appended_trials'};

% If you believe that comparing AICs is a good way to choose a model then it
% would still be the case that the (algebraically) lower AIC is preferred not
% the one with the lowest absolute AIC value. To reiterate you want the most 
% negative number in your example.

analysis = 'Brain_behavior_glm_power_freqwise';

%
% conditions = {{'NeNoOcc_1'}};
% analysis_sub_type = '_insta_20_data_smoothed';
analysis_sub_type = '_insta';

% analysis_sub_type = '_IBS_moving_win';
conditions = {{'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'}};

results_all_cond = cellfun(@(x) cellfun(@(y) IBS_brain_behavior_glm_shifts(x,analysis,y,analysis_sub_type),conditions,...
    'UniformOutput',false),analysis_type,'UniformOutput',false);


% conditions = {{'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3'}};
% 
% results_far = cellfun(@(x) cellfun(@(y) IBS_brain_behavior_glm_shifts(x,analysis,y,analysis_sub_type),conditions,...
%     'UniformOutput',false),analysis_type,'UniformOutput',false);
% 
% 
% conditions = {{'NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'}};
% 
% results_near = cellfun(@(x) cellfun(@(y) IBS_brain_behavior_glm_shifts(x,analysis,y,analysis_sub_type),conditions,...
%     'UniformOutput',false),analysis_type,'UniformOutput',false);






%%

load('E:\Projects\IBS\Results\EEG\Brain_behavior_glm_power_freqwise\no_aggressive_CAR_ASR_10_ICA_appended_trials\Brain_behavior_glm_power_freqwiseno_aggressive_CAR_ASR_10_ICA_appended_trials_avg_sig_cluster_interaction_delay_insta_auto_joint_xor_joint_and.mat')
% bar([Null_AIC_dev_OR;AIC_OR;AIC_AND])
load('E:\Projects\IBS\Results\EEG\Brain_behavior_glm_power_freqwise\no_aggressive_CAR_ASR_10_ICA_appended_trials\avg_sig_cluster_interaction_delay_insta_auto_joint_xor_joint_and_merged_cond.mat')

IBS_brain_behav_plot_Model_fit_AND_XOR(data_analysis_type,analysis,glm_result_OR,glm_result_AND)

IBS_brain_behav_plot_glm_coeff(data_analysis_type,analysis,glm_result_OR,'XOR')
