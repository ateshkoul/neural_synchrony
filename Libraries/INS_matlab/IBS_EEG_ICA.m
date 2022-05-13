function [data_ica_clean_S1,data_ica_clean_S2] = IBS_EEG_ICA(data_S1,data_S2,modality,layout_S1,layout_S2)
if nargin <3
modality = 'save';
end

if nargin <4
    layout_S1 = 'IBS_S1_layout_64.mat';
    layout_S2 = 'IBS_S2_layout_64.mat';
end



% if nargin <2
eeg_channels = {'1-*','-1-EXG*'};
non_eeg_channels = '1-EXG4';
% end
% [ data_ica_clean_S1, Rem_Cmp ] = Giac_AK_EEG_ICA_save_reject( data_S1, 20, [-30 30], layout_S1,eeg_channels,non_eeg_channels,modality);
[ data_ica_clean_S1, Rem_Cmp ] = Giac_AK_EEG_ICA_save_reject_no_eye(data_S1, 20, [-30 30], layout_S1,eeg_channels,modality);
% [ data_ica_clean_S1, Rem_Cmp ] = Giac_AK_EEG_ICA( data_S1, 20, [-30 30], 'IBS_S1_layout_64.mat',eeg_channels,non_eeg_channels);



eeg_channels = {'2-*','-2-EXG*'};
non_eeg_channels = '2-EXG1';
% [ data_ica_clean_S2, Rem_Cmp ] = Giac_AK_EEG_ICA_save_reject( data_S2, 20, [-30 30], 'IBS_S2_layout_64.mat',eeg_channels,non_eeg_channels,modality);
[ data_ica_clean_S2, Rem_Cmp ] = Giac_AK_EEG_ICA_save_reject_no_eye(data_S2, 20, [-30 30], layout_S2,eeg_channels,modality);

% [ data_ica_clean_S2, Rem_Cmp ] = Giac_AK_EEG_ICA( data_S2, 20, [-30 30], 'IBS_S2_layout_64.mat',eeg_channels,non_eeg_channels);

end