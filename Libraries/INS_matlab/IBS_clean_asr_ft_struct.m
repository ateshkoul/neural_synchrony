function [ft_struct] = IBS_clean_asr_ft_struct(ft_struct,Cutoff)


if nargin <2
   Cutoff = []; 
end
% asr_cleaned_trials = cellfun(@IBS_clean_asr_eeg_data,ft_struct.trial,'UniformOutput',false); 
% asr_cleaned_trials = cellfun(@IBS_clean_asr_eeg_chanwise,ft_struct.trial,'UniformOutput',false); 
asr_cleaned_trials = cellfun(@(x) IBS_clean_asr_eeg_data(x,Cutoff),ft_struct.trial,'UniformOutput',false); 

% wrong
% ft_struct.trial = asr_cleaned_trials;
nTrials = numel(ft_struct.trial);
for trial = 1:nTrials
    
    ft_struct.trial{1,trial} = asr_cleaned_trials{trial};
end


% 
% ft_struct = cellfun(@(x) IBS_subs_data_trial(ft_struct,x),asr_cleaned_trials,'UniformOutput',false);
% s = cellfun(@(x,y) eval('x = y'),ft_struct.trial,asr_cleaned_trials,'UniformOutput',false);


end