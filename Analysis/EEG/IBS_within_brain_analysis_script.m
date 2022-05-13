% analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%,'aggressive_trialwise_CAR'};
% cellfun(@(x) IBS_within_brain_analysis_lw(x),analysis_type,'UniformOutput',false)

analysis_type = {'no_aggressive_CAR_ASR_10_ICA_appended_trials'};
analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials'};

cellfun(@(x) IBS_tf_within_pwr_decomp_trialwise(x),analysis_type,'UniformOutput',false)



%%
analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%,'aggressive_trialwise_CAR'};
% analysis_type = {'no_aggressive_CAR_ASR_10_ICA_appended_trials'};

windowSize = 2;
cellfun(@(x) IBS_tf_moving_pwr_decomp_trialwise(x,windowSize),analysis_type,'UniformOutput',false)


analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%,'aggressive_trialwise_CAR'};
% analysis_type = {'no_aggressive_CAR_ASR_10_ICA_appended_trials'};%,'aggressive_trialwise_CAR'};

windowSize = 5;
cellfun(@(x) IBS_tf_moving_pwr_decomp_trialwise(x,windowSize),analysis_type,'UniformOutput',false)


analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%,'aggressive_trialwise_CAR'};
windowSize = 10;
cellfun(@(x) IBS_tf_moving_pwr_decomp_trialwise(x,windowSize),analysis_type,'UniformOutput',false)