
function [dataset] = save_ICA_processed_IBS_data()


Dyads = [1:11 13:18 20:23];
% Dyads = 7;


for Dyd_no = 1:length(Dyads)
    data_S1 = load_ICA_clean_IBS_sub_data(Dyads(Dyd_no),'S1_');
        data_S2 = load_ICA_clean_IBS_sub_data(Dyads(Dyd_no),'S2_');

%     Giac_EEGplotNanTrials( data.data_ica_clean_S1{1,1}, {'all'}, [-30 30], 'IBS_S1_layout_64.mat', 'NoReject' );
%     Giac_EEGplotNanTrials( data.data_ica_clean_S2{1,1}, {'all'}, [-30 30], 'IBS_S2_layout_64.mat', 'NoReject' );

    eeg_channels = {'1-*','-1-EXG*'};
    non_eeg_channels = '1-EXG4';
    data_ica_clean_S1  = cellfun(@(x) IBS_analyze_computed_ICA( x, 20, [-30 30], 'IBS_S1_layout_64.mat',eeg_channels,non_eeg_channels),{data_S1.data_onlyEEG},'UniformOutput', false);
    
    
    eeg_channels = {'2-*','-2-EXG*'};
    non_eeg_channels = '2-EXG1';
    data_ica_clean_S2  = cellfun(@(x) IBS_analyze_computed_ICA( x, 20, [-30 30], 'IBS_S2_layout_64.mat',eeg_channels,non_eeg_channels),{data_S2.data_onlyEEG},'UniformOutput', false);
 
%     
%     IBS_save_datasets(Dyads(Dyd_no),data_ica_clean_S1,data_ica_clean_S2)
end