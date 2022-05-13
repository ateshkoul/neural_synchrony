% actual used 31-08-2021

analysis_type = {'no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
cellfun(@(x) IBS_tf_instantaneous_correlations_trialwise_freqwise(x),analysis_type,'UniformOutput',false)

