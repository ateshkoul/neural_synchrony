function IBS_process_saved_data(analysis_type,Dyads)


if nargin <2
    Dyads = [1:11 13:23];
end

if nargin <1
    analysis_type = 'no_aggressive_trialwise_CAR';
end

% Dyads = [1:11 13:18 20:23];
% conditions = {'Baseline end'};



analysis_type_params = IBS_get_params_analysis_type(analysis_type);

processed_dir = analysis_type_params.save_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';

modality = 'reject';
for Dyd_no = 1:length(Dyads)
    data = IBS_load_clean_IBS_data(Dyads(Dyd_no),analysis_type,processed_dir);
    
    [data_clean_S1,data_clean_S2] = cellfun(@(x,y) IBS_EEG_ICA(x,y,modality),data.data_ica_clean_S1,data.data_ica_clean_S2,'UniformOutput', false);
    
    
    IBS_save_datasets(Dyads(Dyd_no),data_clean_S1,data_clean_S2,analysis_type,processed_dir)
    
    
end

end