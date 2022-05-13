function [dataset] = IBS_save_artefact_removed_processed_IBS_data()


% Dyads = [1:11 13:18 20:23];
Dyads = 1;


for Dyd_no = 1:length(Dyads)
    IBS_data = IBS_load_clean_IBS_data(Dyads(Dyd_no),analysis_type);


%     Giac_EEGplotNanTrials( data.data_ica_clean_S1{1,1}, {'all'}, [-30 30], 'IBS_S1_layout_64.mat', 'NoReject' );
%     Giac_EEGplotNanTrials( data.data_ica_clean_S2{1,1}, {'all'}, [-30 30], 'IBS_S2_layout_64.mat', 'NoReject' );
    [data_ica_clean_S1,data_ica_clean_S2] = cellfun(@(x,y) IBS_EEG_ICA(x,y,'reject'),data_clean_S1,data_clean_S2,'UniformOutput', false);

%     
%     IBS_save_datasets(Dyads(Dyd_no),data_ica_clean_S1,data_ica_clean_S2)
end