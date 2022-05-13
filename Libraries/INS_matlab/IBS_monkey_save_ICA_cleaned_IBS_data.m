function IBS_monkey_save_ICA_cleaned_IBS_data(analysis_type,Sessions)
%IBS_MONKEY_SAVE_ICA_CLEANED_IBS_DATA function to save data after batch ICA processing
%
% SYNOPSIS: IBS_monkey_save_ICA_cleaned_IBS_data
%
% INPUT 
%
% OUTPUT 
%
% REMARKS
%
% created with MATLAB ver.: 9.8.0.1359463 (R2020a) Update 1 on Microsoft Windows 10 Pro Version 10.0 (Build 19042)
%
% created by: Atesh
% DATE: 21-Mar-2021
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin <1
    analysis_type = 'no_aggressive_CAR_ASR_5_ICA_appended_trials';
end
if nargin <2
% Dyads = [1 2 3 4 5];
Sessions = [2:16];

% Dyads = [6:8];
end
% blocks = {'blocks'};
analysis_type_params = IBS_monkey_get_params_analysis_type(analysis_type);
processed_dir = analysis_type_params.processed_data_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
layout_S1 = analysis_type_params.layout_S1{1,1};
layout_S2 = analysis_type_params.layout_S2{1,1};
remove_comp = 0;
for Ses_no = 1:length(Sessions)
        data = IBS_monkey_load_clean_IBS_data(Sessions(Ses_no),analysis_type,processed_dir,remove_comp);
    [data_clean_S1,data_clean_S2] = cellfun(@(x,y) IBS_EEG_ICA(x,y,'reject',layout_S1,layout_S2),data.data_ica_clean_S1,data.data_ica_clean_S2,'UniformOutput', false);
    IBS_monkey_save_datasets(Sessions(Ses_no),data_clean_S1,data_clean_S2,analysis_type,processed_dir)
end