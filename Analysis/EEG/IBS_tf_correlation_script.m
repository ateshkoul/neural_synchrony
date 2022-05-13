
%% Detrended analysis
analysis_type = {'no_aggressive_CAR_ASR_10_ICA_appended_trials'};
% analysis_type = {'aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};

cor_fun = @IBS_tf_correlations;
% cor_fun = @IBS_tf_correlations_no_five_sec;
% cor_fun = @IBS_test_correlation_dyad_specific;

% cor_fun = @IBS_tf_mutual_info;
varargin_table = table();
varargin_table.cor_fun_args = table();
varargin_table.cor_fun_args.Dyads = 1:23;
% cellfun(@(x) IBS_tf_correlations(x),analysis_type,'UniformOutput',false)
cellfun(@(x) IBS_tf_correlation_analysis_freqwise(x,cor_fun,varargin_table),analysis_type,'UniformOutput',false)

%%
analysis_type = {'no_aggressive_CAR_ASR_10_ICA_appended_trials'};
% analysis_type = {'aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};


cellfun(@(x) IBS_tf_correlations(x),analysis_type,'UniformOutput',false)
% cellfun(@(x) IBS_tf_correlation_analysis_freqwise(x,cor_fun,varargin_table),analysis_type,'UniformOutput',false)


%% windowed analysis

% analysis_type = {'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
% 
% cor_fun = @IBS_tf_correlations_avg_window;
% varargin_table.cor_fun_args = table();
% varargin_table.cor_fun_args.Dyads = 1:23;


%%
% varargin_table.cor_fun_args.windowSize = 2;
% % cellfun(@(x) IBS_tf_correlations(x),analysis_type,'UniformOutput',false)
% cellfun(@(x) IBS_tf_correlation_analysis(x,cor_fun,varargin_table),analysis_type,'UniformOutput',false)
% cellfun(@(x) IBS_tf_correlation_analysis_freqwise(x,cor_fun,varargin_table),analysis_type,'UniformOutput',false)


%%
% varargin_table.cor_fun_args.windowSize = 5;
% % cellfun(@(x) IBS_tf_correlations(x),analysis_type,'UniformOutput',false)
% cellfun(@(x) IBS_tf_correlation_analysis_freqwise(x,cor_fun,varargin_table),analysis_type,'UniformOutput',false)
% cellfun(@(x) IBS_tf_correlation_analysis(x,cor_fun,varargin_table),analysis_type,'UniformOutput',false)
% 

%%
% varargin_table.cor_fun_args.windowSize = 10;
% % cellfun(@(x) IBS_tf_correlations(x),analysis_type,'UniformOutput',false)
% cellfun(@(x) IBS_tf_correlation_analysis(x,cor_fun,varargin_table),analysis_type,'UniformOutput',false)
% cellfun(@(x) IBS_tf_correlation_analysis_freqwise(x,cor_fun,varargin_table),analysis_type,'UniformOutput',false)



% trial_nos = 3;
% analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
% cellfun(@(x) arrayfun(@(y) IBS_tf_correlations_trialwise(y,x),1:trial_nos,'UniformOutput',false),analysis_type,'UniformOutput',false)

%%




%% power point save

analysis = 'Power_correlation_analysis';
IBS_save_powerpoint_results(analysis)

%% connectivity analyses
analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
cellfun(@(x) IBS_tf_coherence_correlations(x),analysis_type,'UniformOutput',false)


analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
analysis_type = {'no_aggressive_CAR_ASR_10_ICA_appended_trials'};%'no_aggressive_trialwise_CAR'};
measure = 'coh';
cellfun(@(x) IBS_tf_correlation_analysis(x,@IBS_process_tf_connectivity,measure),analysis_type,'UniformOutput',false)


%% power point save
analysis = 'Connectivity_analysis';
file_precursur = 'coherence_analysis_';
IBS_save_powerpoint_results(analysis,file_precursur);



%% connectivity plv
% analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
measure = 'plv';
con_fun = @IBS_tf_coherence_compute_correlations;
analysis_type = {'no_aggressive_trialwise_CAR'};
cellfun(@(x) IBS_tf_correlation_analysis(x,@IBS_process_tf_connectivity,measure,con_fun),analysis_type,'UniformOutput',false)

%%
analysis = 'Connectivity_analysis';
file_precursur = 'plv_analysis_';
IBS_save_powerpoint_results(analysis,file_precursur);


%% connectivity manual
% analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
analysis_type = {'no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
varargin_table.limit_args = table();
varargin_table.limit_args.measure = 'coh';
cellfun(@(x) IBS_tf_correlation_analysis(x,@IBS_tf_coherence_correlations_manual,varargin_table),analysis_type,'UniformOutput',false)

%% still to do
% analysis = 'Connectivity_analysis';
% file_precursur = 'coh_analysis_';
% IBS_save_powerpoint_results(analysis,file_precursur);


