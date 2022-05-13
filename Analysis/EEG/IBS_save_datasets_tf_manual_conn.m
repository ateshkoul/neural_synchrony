function IBS_save_datasets_tf_manual_conn(Dyad_no,data_coherence,data_cleaning,measure,processed_dir)

if nargin <3
    data_cleaning = 'no_aggressive_trialwise_CAR';
    %         processed_dir = 'D:\\Experiments\\IBS\\Processed\\EEG\\Only_eye_artefacts\\';
    
end
if nargin <4
    measure = 'coh';
end
if nargin <5
    
    analysis_type_params = IBS_get_params_analysis_type(analysis_type);
    
    processed_dir = analysis_type_params.data_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
    
    %     processed_dir = 'D:\\Experiments\\IBS\\Processed\\EEG\\Only_eye_artefacts\\';
end



% processed_dir = 'D:\\Experiments\\IBS\\Processed\\EEG\\';


% [Dyad, block_no,~,datafile] = IBS_get_dyad_cond_from_struct(data,data.depth);
%
% processed_dir = IBS_get_rep_struct_field_from_depth(data.cfg,'previous',data.depth,'processed_dir');




switch(data_cleaning)
    case {'no_aggressive_trialwise_CAR','no_aggressive_trialwise_NoCAR'}
        save([processed_dir sprintf('Dyd_%0.2d_trialwise_time_freq_manual', Dyad_no) '_' measure '_' data_cleaning '.mat'],...
            'data_coherence','-v7.3')
   case {'aggressive_trialwise_CAR','aggressive_trialwise_NoCAR'}
        save([processed_dir sprintf('Dyd_%0.2d_trialwise_aggressive_time_freq_manual', Dyad_no) '_' measure '_' data_cleaning '.mat'],...
            'data_coherence','-v7.3')    
%     case {'no_aggressive_ASR_clean_trialwise_CAR','no_aggressive_ASR_clean_trialwise_NoCAR'}
%         save([processed_dir sprintf('Dyd_%0.2d_trialwise_time_freq_',Dyad_no) data_cleaning '.mat'],...
%             'data_ica_clean_S1_tf','data_ica_clean_S2_tf','-v7.3')
%         %         IBS_sub_data = load([ processed_dir sprintf('Dyd_%0.2d_ASR_ICA_cleaned.mat',Dyad_no)],'data_ica_clean_S1','data_ica_clean_S2');
%     case 'no_aggressive_ASR_re_notch_clean_trialwise_CAR'
%         save([processed_dir sprintf('Dyd_%0.2d_trialwise_ASR_re_notch_time_freq_',Dyad_no) data_cleaning '.mat'],...
%             'data_ica_clean_S1_tf','data_ica_clean_S2_tf','-v7.3')
%     case 'no_aggressive_ASR_8_clean_trialwise_CAR'
%         save([processed_dir sprintf('Dyd_%0.2d_trialwise_ASR_8_time_freq_',Dyad_no) data_cleaning '.mat'],...
%             'data_ica_clean_S1_tf','data_ica_clean_S2_tf','-v7.3')
%     case 'no_aggressive_ASR_20_clean_trialwise_CAR'
%         save([processed_dir sprintf('Dyd_%0.2d_trialwise_ASR_20_time_freq_',Dyad_no) data_cleaning '.mat'],...
%             'data_ica_clean_S1_tf','data_ica_clean_S2_tf','-v7.3')
    case 'no_aggressive_CAR_ASR_5_ICA_appended_trials'
        save([processed_dir sprintf('Dyd_%0.2d_trialwise_CAR_ASR_5_ICA_time_freq_manual',Dyad_no) '_' measure '_' data_cleaning '.mat'],...
            'data_coherence','-v7.3')
    case 'no_aggressive_CAR_ASR_10_ICA_appended_trials'
        save([processed_dir sprintf('Dyd_%0.2d_trialwise_CAR_ASR_10_ICA_time_freq_manual',Dyad_no) '_' measure '_' data_cleaning '.mat'],...
            'data_coherence','-v7.3')
end
end