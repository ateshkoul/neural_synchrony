analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};

IBS_asr_clean_combined_trials(analysis_type,[1:11 13:23]);
cellfun(@(x) IBS_asr_clean_combined_trials(x,[1:11 13:23]),analysis_type,'UniformOutput',false)


analysis_type = 'no_aggressive_CAR_ASR_20_ICA_appended_trials';
IBS_asr_clean_combined_trials(analysis_type,12:23);