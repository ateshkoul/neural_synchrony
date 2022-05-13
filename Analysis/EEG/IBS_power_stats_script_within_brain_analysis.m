analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
analysis_type = {'no_aggressive_CAR_ASR_10_ICA_appended_trials'};
analysis = 'Within_analysis';
varargin_table = table();
varargin_table.measure = 'within';
% varargin_table.windowSize = 10;
% cor_fun = @IBS_load_within_brain_analysis_data;
% cor_fun = @IBS_tf_moving_pwr_decomp_trialwise;
cor_fun = @IBS_tf_within_pwr_decomp_trialwise;
% cellfun(@(x) IBS_power_stats(x,analysis,cor_fun,varargin_table),analysis_type,'UniformOutput',false)

cellfun(@(x) IBS_power_stats_freqwise(x,analysis,cor_fun,varargin_table),analysis_type,'UniformOutput',false)


%% power point save
presentation_save_dir = 'Y:\\Inter-brain synchrony\\Results\\EEG\\IBS_EEG_presentations\\';
import mlreportgen.ppt.*

ppt = Presentation([presentation_save_dir 'results_cluster_within_analysis_stats.pptx']);
analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
% analysis_type = {'no_aggressive_CAR_ASR_10_ICA_appended_trials'};

% cor_fun = @IBS_load_within_brain_analysis_data;
cor_fun = @IBS_tf_within_pwr_decomp_trialwise;

select_string = {['cluster_plot_' func2str(cor_fun) '_all_freq_anova'] ['cluster_plot_' func2str(cor_fun) '_freqwise_anova']};

analysis = 'Within_analysis';




IBS_save_powerpoint_stats(analysis_type,ppt,select_string,analysis);
close(ppt);

%% F images
clear
analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
analysis_type = {'no_aggressive_CAR_ASR_10_ICA_appended_trials'};

analysis = 'Within_analysis';
varargin_table = table();
varargin_table.measure = 'corr';
varargin_table.plot_type = 'images';
% cor_fun = @IBS_load_within_brain_analysis_data;
cor_fun = @IBS_tf_within_pwr_decomp_trialwise;

% cellfun(@(x) IBS_power_stats(x,analysis,cor_fun,varargin_table),analysis_type,'UniformOutput',false)


cellfun(@(x) IBS_power_stats_freqwise(x,analysis,cor_fun,varargin_table),analysis_type,'UniformOutput',false)



