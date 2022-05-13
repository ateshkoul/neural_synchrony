function [clean_eeglab_data] = IBS_clean_asr_eeg_data(eeg_data_mat,Cutoff,windowlen,template_table)
%% Function to clean EEG data using ASR
% Inputs:
% eeg_data_mat                 raw EEG data (nChan x nTimepoints)
% ASR parameters:
% Cutoff                       Cutoff parameter for ASR datacleaning
% windowlen                    window length of the ASR cleaning
%% Atesh Koul



% since the input is data, the output should be similar. 
% Also, all the other details in the struct are easily gotten by the template
% so there isn't anything that is 'new' in the struct compared to data
if nargin <2
    
   Cutoff = []; 
end

if nargin <3
    windowlen = [];
end
% eeg_data_mat - nchan x nSamples
eeglab_struct = IBS_template_ft_eeglab(eeg_data_mat);
% baseline_eeglab_struct = IBS_template_ft_eeglab(baseline_data);
clean_eeglab_struct = clean_asr(eeglab_struct,Cutoff,windowlen,[],[],[],[],[],true);
% clean_eeglab_struct = clean_asr(eeglab_struct,Cutoff,windowlen,[],[],baseline_eeglab_struct,[],[],true);

clean_eeglab_data = clean_eeglab_struct.data; 

end