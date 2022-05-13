% analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
analysis = 'Power_correlation_analysis';
analysis_type = {'no_aggressive_CAR_ASR_10_ICA_appended_trials'};
% analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR'}
varargin_table = table();
varargin_table.measure = 'corr';
% cor_fun = @IBS_tf_correlations;
% cor_fun = @IBS_tf_correlations_no_five_sec;

% cor_fun = @IBS_tf_mutual_info;
% cor_fun = @IBS_tf_correlations_avg_window;
% cor_fun = @IBS_test_correlation_dyad_specific;
cor_fun = @IBS_test_correlation_dyad_specific_difference;
% cellfun(@(x) IBS_power_stats(x,analysis,cor_fun,varargin_table),analysis_type,'UniformOutput',false)


cellfun(@(x) IBS_power_stats_freqwise(x,analysis,cor_fun,varargin_table),analysis_type,'UniformOutput',false)



%% power point save
presentation_save_dir = 'Y:\\Inter-brain synchrony\\Results\\EEG\\IBS_EEG_presentations\\';
import mlreportgen.ppt.*

ppt = Presentation([presentation_save_dir 'results_cluster_power_correlation_anova_stats.pptx']);
analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};

% select_string = {'cluster_plot_IBS_tf_correlations_detrend_all_freq_anova' 'cluster_plot_IBS_tf_correlations_detrend_freqwise_anova'};
% select_string = {'cluster_plot_IBS_tf_correlations_detrend_freqwise_anova'};

analysis = 'Power_correlation_analysis';

IBS_save_powerpoint_stats(analysis_type,ppt,select_string,analysis);
close(ppt);

%% F-images

% clear
% analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
% 
% % analysis_type = {'no_aggressive_trialwise_CAR'};%,'aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
% cor_fun = @IBS_process_tf_connectivity;
% varargin_table = table();
% varargin_table.measure = 'coh';
% analysis = 'Connectivity_analysis';
clear
% analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
analysis_type = {'no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
% analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials'};
% analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR'};
analysis = 'Power_correlation_analysis';
varargin_table = table();
varargin_table.measure = 'corr';
varargin_table.plot_type = 'images';
cor_fun = @IBS_tf_correlations;
% cor_fun = @IBS_test_correlation_dyad_specific;
% cor_fun = @IBS_test_correlation_dyad_specific_difference;

% cellfun(@(x) IBS_power_stats(x,analysis,cor_fun,varargin_table),analysis_type,'UniformOutput',false)


cellfun(@(x) IBS_power_stats_freqwise(x,analysis,cor_fun,varargin_table),analysis_type,'UniformOutput',false)


%% Connectivity_analysis
analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};

% analysis_type = {'no_aggressive_trialwise_CAR'};%,'aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
cor_fun = @IBS_process_tf_connectivity;
varargin_table = table();
varargin_table.measure = 'coh';
analysis = 'Connectivity_analysis';
cellfun(@(x) IBS_power_stats(x,analysis,cor_fun,varargin_table),analysis_type,'UniformOutput',false)

cellfun(@(x) IBS_power_stats_freqwise(x,analysis,cor_fun,varargin_table),analysis_type,'UniformOutput',false)



%% power point save
clear
presentation_save_dir = 'Y:\\Inter-brain synchrony\\Results\\EEG\\IBS_EEG_presentations\\';
import mlreportgen.ppt.*

ppt = Presentation([presentation_save_dir 'results_cluster_coh_stats.pptx']);
analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};

% analysis_type = {'no_aggressive_trialwise_CAR'};%,'aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
cor_fun = @IBS_process_tf_connectivity;
varargin_table = table();
varargin_table.measure = 'coh';
select_string = {['cluster_plot_' func2str(cor_fun) '_' varargin_table.measure] ['cluster_plot_' func2str(cor_fun) '_' varargin_table.measure '_freqwise']};
analysis = 'Connectivity_analysis';
IBS_save_powerpoint_stats(analysis_type,ppt,select_string,analysis);
close(ppt);




%%
analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
% analysis_type = {'no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};
% analysis_type = {'no_aggressive_trialwise_CAR'};%,'aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
cor_fun = @IBS_tf_coherence_correlations_manual;
varargin_table = table();
varargin_table.measure = 'coh';
analysis = 'Connectivity_analysis';
cellfun(@(x) IBS_power_stats(x,analysis,cor_fun,varargin_table),analysis_type,'UniformOutput',false)

cellfun(@(x) IBS_power_stats_freqwise(x,analysis,cor_fun,varargin_table),analysis_type,'UniformOutput',false)

%% power point save
clear
presentation_save_dir = 'Y:\\Inter-brain synchrony\\Results\\EEG\\IBS_EEG_presentations\\';
import mlreportgen.ppt.*

ppt = Presentation([presentation_save_dir 'results_cluster_coh_stats_manual.pptx']);
analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};

% analysis_type = {'no_aggressive_trialwise_CAR'};%,'aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
cor_fun = @IBS_tf_coherence_correlations_manual;
varargin_table = table();
varargin_table.measure = 'coh';
select_string = {['cluster_plot_' func2str(cor_fun) '_' varargin_table.measure] ['cluster_plot_' func2str(cor_fun) '_' varargin_table.measure '_freqwise']};
analysis = 'Connectivity_analysis';
IBS_save_powerpoint_stats(analysis_type,ppt,select_string,analysis);
close(ppt);



%% Moving_window
IBS_power_stats_moving_window_script


%%
presentation_save_dir = 'Y:\\Inter-brain synchrony\\Results\\EEG\\IBS_EEG_presentations\\';
import mlreportgen.ppt.*

ppt = Presentation([presentation_save_dir 'results_cluster_moving_window_stats.pptx']);
analysis_type = {'no_aggressive_trialwise_CAR'};%,'aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
% select_string = {'cluster_plot_correlation' 'cluster_plot_correlation_freqwise'};
select_string = {'cluster_plot'};% 'cluster_plot_correlation_freqwise'};
cor_fun = @IBS_save_dyad_tf_moving_corr;
analysis = 'Moving_window';

IBS_save_powerpoint_stats_moving_window(analysis_type,ppt,select_string,cor_fun);
close(ppt);





