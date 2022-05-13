function IBS_save_datasets(Dyad_no,data_S1,data_S2,data_cleaning,save_dir)
%% Atesh Koul
if nargin <4
    data_cleaning = 'no_aggressive_trialwise_CAR';
%     save_dir = 'D:\\Experiments\\IBS\\Processed\\EEG\\Only_eye_artefacts\\';
end

if nargin <5
    %     save_dir = 'D:\\Experiments\\IBS\\Processed\\EEG\\Only_eye_artefacts\\';
    analysis_type_params = IBS_get_params_analysis_type(analysis_type);
    
    save_dir = analysis_type_params.save_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
    
end
% processed_dir = 'D:\\Experiments\\IBS\\Processed\\EEG\\';


% [Dyad, block_no,~,datafile] = IBS_get_dyad_cond_from_struct(data,data.depth);
%
% processed_dir = IBS_get_rep_struct_field_from_depth(data.cfg,'previous',data.depth,'processed_dir');




switch(data_cleaning)
    case {'no_aggressive_trialwise_CAR','no_aggressive_trialwise_NoCAR'}
        data_ica_clean_S1 = data_S1;
        data_ica_clean_S2 = data_S2;
        save([save_dir sprintf('Dyd_%0.2d_ICA_func_clean_bp_03_95_120s.mat',Dyad_no)],'data_ica_clean_S1','data_ica_clean_S2','-v7.3')
    case {'aggressive_trialwise_CAR','aggressive_trialwise_NoCAR'}
        data_ica_clean_S1 = data_S1;
        data_ica_clean_S2 = data_S2;
        save([save_dir sprintf('Dyd_%0.2d_ICA_blocks_only_neck_artefact_clean_bp_03_95_120s.mat',Dyad_no)],'data_ica_clean_S1','data_ica_clean_S2','-v7.3')
                 
    case {'no_aggressive_ASR_clean_trialwise_CAR','no_aggressive_ASR_clean_trialwise_NoCAR'}
        data_ica_clean_S1 = data_S1;
        data_ica_clean_S2 = data_S2;
        save([save_dir sprintf('Dyd_%0.2d_ASR_ICA_cleaned.mat',Dyad_no)],'data_ica_clean_S1','data_ica_clean_S2','-v7.3')
        
    case 'no_aggressive_CAR_ASR_5_ICA_appended_trials'
        data_ica_clean_S1 = data_S1;
        data_ica_clean_S2 = data_S2;
        save([save_dir sprintf('Dyd_%0.2d_CAR_ASR_5_ICA_appended_comp.mat',Dyad_no)],'data_ica_clean_S1','data_ica_clean_S2','-v7.3')
    case 'no_aggressive_CAR_ASR_10_ICA_appended_trials'
        data_ica_clean_S1 = data_S1;
        data_ica_clean_S2 = data_S2;
        save([save_dir sprintf('Dyd_%0.2d_CAR_ASR_10_ICA_appended_comp.mat',Dyad_no)],'data_ica_clean_S1','data_ica_clean_S2','-v7.3')
        
        case 'no_aggressive_CAR_ASR_20_ICA_appended_trials'
        data_ica_clean_S1 = data_S1;
        data_ica_clean_S2 = data_S2;
        save([save_dir sprintf('Dyd_%0.2d_CAR_ASR_20_ICA_appended_comp.mat',Dyad_no)],'data_ica_clean_S1','data_ica_clean_S2','-v7.3')
        
            
        
    case 'raw_unfiltered'
        save([save_dir sprintf('Dyd_%0.2d_raw_unfiltered.mat',Dyad_no)],'data_S1','data_S2','-v7.3')
        %         IBS_sub_data = load([ processed_dir sprintf('Dyd_%0.2d_ASR_ICA_cleaned.mat',Dyad_no)],'data_ica_clean_S1','data_ica_clean_S2');
end
end
