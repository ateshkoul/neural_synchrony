analysis_type = {'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
analysis_type = {'no_aggressive_CAR_ASR_10_ICA_appended_trials'};
analysis = 'Power_correlation_analysis';
varargin_table = table();
varargin_table.measure = 'corr';
cor_fun = @IBS_tf_correlations;

cellfun(@(x) IBS_power_t_stats_freqwise(x,analysis,cor_fun,varargin_table),analysis_type,'UniformOutput',false)


%% power point save
presentation_save_dir = 'Y:\\Inter-brain synchrony\\Results\\EEG\\IBS_EEG_presentations\\';
import mlreportgen.ppt.*

ppt = Presentation([presentation_save_dir 'results_cluster_power_correlation_t_stats.pptx']);
analysis_type = {'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
cor_fun = @IBS_tf_correlations;
select_string = {'cluster_plot_' func2str(cor_fun) '_detrend_freqwise'};

analysis = 'Power_correlation_analysis';




IBS_save_powerpoint_t_stats(analysis_type,ppt,select_string,analysis);
close(ppt);

%% F-images
clear
analysis_type = {'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
analysis_type = {'no_aggressive_CAR_ASR_10_ICA_appended_trials'};

analysis = 'Power_correlation_analysis';
varargin_table = table();
varargin_table.measure = 'corr';
varargin_table.plot_type = 'images';
cor_fun = @IBS_tf_correlations;


cellfun(@(x) IBS_power_t_stats_freqwise(x,analysis,cor_fun,varargin_table),analysis_type,'UniformOutput',false)
%%




