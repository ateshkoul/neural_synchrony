function [ft_struct] = IBS_clean_asr_combined_trials_ft_struct(ft_struct,Cutoff)
%% Function to clean EEG data using ASR
% Inputs:
% ft_struct                 Fieldtrip struct
% Cutoff                    Cutoff parameter for ASR datacleaning

%% Atesh Koul
if nargin <2
    Cutoff = [];
end

nTrials = numel(ft_struct.trial);
[nChan,nTimePoints] = size(ft_struct.trial{1,1});
all_trials = cat(2,ft_struct.trial{:});
asr_cleaned_combined_trials = IBS_clean_asr_eeg_data(all_trials,Cutoff);

ft_struct.trial = mat2cell(asr_cleaned_combined_trials,nChan,repmat(nTimePoints,1,nTrials));

% ft_struct.trial = mat2cell(all_trials,nChan,repmat(nTimePoints,1,nTrials));

% ft_struct_long = IBS_clean_asr_ft_struct(ft_struct);



end