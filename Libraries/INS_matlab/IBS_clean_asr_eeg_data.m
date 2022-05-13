function [clean_eeglab_struct] = IBS_clean_asr_eeg_data(eeg_data_mat)
% eeg_data_mat - nchan x nSamples
eeglab_struct = IBS_template_ft_eeglab(eeg_data_mat);

clean_eeglab_struct = clean_asr(eeglab_struct);



end