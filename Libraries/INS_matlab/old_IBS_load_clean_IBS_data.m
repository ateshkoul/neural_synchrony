
%% A function to load the cleaned IBS dataset

function [IBS_Data] = IBS_load_clean_IBS_data(Dyads,analysis_type,processed_dir)
if nargin <2
    analysis_type = 'no_aggressive_trialwise_CAR';
    processed_dir = 'D:\\Experiments\\IBS\\Processed\\EEG\\Only_eye_artefacts\\';
end

if nargin <3
    %     processed_dir = 'D:\\Experiments\\IBS\\Processed\\EEG\\Only_eye_artefacts\\';
    analysis_type_params = IBS_get_params_analysis_type(analysis_type);
    
    processed_dir = analysis_type_params.data_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
    
end
IBS_Data = arrayfun(@(x) IBS_load_clean_IBS_sub_data(x,analysis_type,processed_dir),Dyads);

end

function [IBS_sub_data] = IBS_load_clean_IBS_sub_data(Dyad_no,analysis_type,processed_dir)


if nargin <2
    analysis_type = 'no_aggressive_trialwise_CAR';
    processed_dir = 'D:\\Experiments\\IBS\\Processed\\EEG\\Only_eye_artefacts\\';
end

if nargin <3
    %     processed_dir = 'D:\\Experiments\\IBS\\Processed\\EEG\\Only_eye_artefacts\\';
    analysis_type_params = IBS_get_params_analysis_type(analysis_type);
    
    processed_dir = analysis_type_params.data_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
    
end




switch(analysis_type)
    case {'no_aggressive_trialwise_CAR','no_aggressive_trialwise_NoCAR'}
        IBS_sub_data = load([ processed_dir sprintf('Dyd_%0.2d_ICA_func_clean_bp_03_95_120s.mat',Dyad_no)],'data_ica_clean_S1','data_ica_clean_S2');
        IBS_sub_data.data_ica_clean_S1 = cellfun(@(x) rmfield(x,'comp'),data.data_ica_clean_S1,'UniformOutput', false);
        IBS_sub_data.data_ica_clean_S2 = cellfun(@(x) rmfield(x,'comp'),data.data_ica_clean_S2,'UniformOutput', false);

    case {'no_aggressive_ASR_clean_trialwise_CAR','no_aggressive_ASR_clean_trialwise_NoCAR'}
        IBS_sub_data = load([ processed_dir sprintf('Dyd_%0.2d_ASR_ICA_cleaned.mat',Dyad_no)],'data_ica_clean_S1','data_ica_clean_S2');
    case 'no_aggressive_ASR_no_notch_clean_trialwise_CAR'
        IBS_sub_data = load([ processed_dir sprintf('Dyd_%0.2d_ASR_no_notch_ICA_cleaned.mat',Dyad_no)],'data_ica_clean_S1','data_ica_clean_S2');
    case 'no_aggressive_ASR_re_notch_clean_trialwise_CAR'
        IBS_sub_data = load([ processed_dir sprintf('Dyd_%0.2d_ASR_re_notch_ICA_cleaned.mat',Dyad_no)],'data_ica_clean_S1','data_ica_clean_S2');
    case 'no_aggressive_ASR_8_clean_trialwise_CAR'
        IBS_sub_data = load([ processed_dir sprintf('Dyd_%0.2d_ASR_8_ICA_cleaned.mat',Dyad_no)],'data_ica_clean_S1','data_ica_clean_S2');
    case 'no_aggressive_ASR_20_clean_trialwise_CAR'
        IBS_sub_data = load([ processed_dir sprintf('Dyd_%0.2d_ASR_20_ICA_cleaned.mat',Dyad_no)],'data_ica_clean_S1','data_ica_clean_S2');
        
end

end