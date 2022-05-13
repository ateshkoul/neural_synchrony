function [clean_eeglab_data] = IBS_clean_asr_eeg_chanwise(eeg_data_mat,Cutoff,windowlen)
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
% eeglab_struct = arrayfun(@(x) IBS_template_ft_eeglab(eeg_data_mat(x,:)),1:size(eeg_data_mat,1),'UniformOutput',false);
% clean_eeglab_struct = cellfun(@(x) clean_asr(x,Cutoff,windowlen,[],[],[],[],[],true),eeglab_struct,'UniformOutput',false);
% baseline_eeglab_struct = IBS_template_ft_eeglab(baseline_data);
clean_eeglab_struct = clean_asr(eeglab_struct,Cutoff,windowlen,[],[],[],[],[],true);
% clean_eeglab_struct = clean_asr(eeglab_struct,Cutoff,windowlen,[],[],baseline_eeglab_struct,[],[],true);
clean_eeglab_data = clean_eeglab_struct.data; 

end