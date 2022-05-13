function IBS_save_ICA_cleaned_data
%IBS_SAVE_ICA_CLEANED_DATA
%
% SYNOPSIS: IBS_save_ICA_cleaned_data
%
% INPUT function to save data after computation of ICA
%
% OUTPUT 
%
% REMARKS
%
% created with MATLAB ver.: 9.8.0.1359463 (R2020a) Update 1 on Microsoft Windows 10 Pro Version 10.0 (Build 19042)
%
% created by: Atesh
% DATE: 11-Aug-2021
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if nargin <1
    analysis_type = 'no_aggressive_trialwise_CAR';
end
if nargin <2
% Dyads = [1 2 3 4 5];
Dyads = [1:23];

% Dyads = [6:8];
end
blocks = {'baseline_1','blocks','baseline_2'};
% blocks = {'blocks'};

save_dir = IBS_get_params_analysis_type(analysis_type).save_dir{1,1};




for Dyd_no = 1:length(Dyads)
        IBS_data = IBS_load_clean_IBS_data(Dyads(Dyd_no));
    [data_ica_clean_S1] = cellfun(@IBS_EEG_manual_artefact_removal,IBS_data.data_ica_clean_S1,'UniformOutput', false);
    [data_ica_clean_S2] = cellfun(@IBS_EEG_manual_artefact_removal,IBS_data.data_ica_clean_S2,'UniformOutput', false);

    
end
