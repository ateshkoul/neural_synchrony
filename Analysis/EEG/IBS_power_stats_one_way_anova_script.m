analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
analysis = 'Dyad_classification_sex';
varargin_table = table();
varargin_table.measure = 'corr';
cor_fun = @IBS_tf_correlations;

cellfun(@(x) IBS_power_stats_one_way_anova(x,analysis,cor_fun,varargin_table),analysis_type,'UniformOutput',false)
cellfun(@(x) IBS_power_stats_freqwise_one_way_anova(x,analysis,cor_fun,varargin_table),analysis_type,'UniformOutput',false)


%%
analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
analysis = 'Dyad_classification_sex';
varargin_table = table();
varargin_table.measure = 'corr';
cor_fun = @IBS_tf_correlations;

varargin_table.plot_type = 'images';


cellfun(@(x) IBS_power_stats_one_way_anova(x,analysis,cor_fun,varargin_table),analysis_type,'UniformOutput',false)
cellfun(@(x) IBS_power_stats_freqwise_one_way_anova(x,analysis,cor_fun,varargin_table),analysis_type,'UniformOutput',false)

%% t-tests

analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
analysis = 'Dyad_classification_smile';
varargin_table = table();
varargin_table.measure = 'corr';
cor_fun = @IBS_tf_correlations;
% cor_fun = @(x,varargin) IBS_tf_correlations_trialwise(1,x,varargin);

cellfun(@(x) IBS_power_stats_one_way_anova(x,analysis,cor_fun,varargin_table),analysis_type,'UniformOutput',false)
cellfun(@(x) IBS_power_stats_freqwise_one_way_anova(x,analysis,cor_fun,varargin_table),analysis_type,'UniformOutput',false)



% cellfun(@(x) IBS_power_stats_freqwise_t_test(x,analysis,cor_fun,varargin_table),analysis_type,'UniformOutput',false)
%%
analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
analysis = 'Dyad_classification_romantic';
varargin_table = table();
varargin_table.measure = 'corr';
cor_fun = @IBS_tf_correlations;
% cor_fun = @(x,varargin) IBS_tf_correlations_trialwise(1,x,varargin);

cellfun(@(x) IBS_power_stats_one_way_anova(x,analysis,cor_fun,varargin_table),analysis_type,'UniformOutput',false)
cellfun(@(x) IBS_power_stats_freqwise_one_way_anova(x,analysis,cor_fun,varargin_table),analysis_type,'UniformOutput',false)

%%

analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
analysis = 'Dyad_classification_eye_on_face';
varargin_table = table();
varargin_table.measure = 'corr';
cor_fun = @IBS_tf_correlations;
% cor_fun = @(x,varargin) IBS_tf_correlations_trialwise(1,x,varargin);

cellfun(@(x) IBS_power_stats_one_way_anova(x,analysis,cor_fun,varargin_table),analysis_type,'UniformOutput',false)
cellfun(@(x) IBS_power_stats_freqwise_one_way_anova(x,analysis,cor_fun,varargin_table),analysis_type,'UniformOutput',false)

