% Dyads = 23;
% analysis_type = 'no_aggressive_ASR_no_notch_clean_trialwise_CAR';
% IBS_automatic_asr_cleaning(analysis_type,Dyads)
% 
% %%
% IBS_tf_correlations(analysis_type,Dyads)



%%
analysis_type = 'no_aggressive_ASR_8_clean_trialwise_CAR';
Dyads = [1:11 13:18 20:23];

IBS_clean_data_asr(Dyads)
IBS_tf_correlations(analysis_type,Dyads)
