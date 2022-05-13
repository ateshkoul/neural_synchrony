function [connectivity,conditions,connectivity_fname]= IBS_tf_coherence_correlations_manual(analysis_type,measure,Dyads)


if nargin <3
%     Dyads = [1:11 13:23];
    Dyads = 1:23;

end
if nargin <2
  measure = 'coh';  
end
if nargin <1
    analysis_type = 'no_aggressive_trialwise_CAR';
end


analysis_type_params = IBS_get_params_analysis_type(analysis_type);
data_dir = analysis_type_params.data_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
save_dir = analysis_type_params.save_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
coherence_fname = analysis_type_params.coherence_fname{1,1};
conditions = analysis_type_params.conditions;
% process_dir = 'D:\\Experiments\\IBS\\Processed\\EEG\\';
% process_dir = 'D:\\Atesh\\IBS\\';

connectivity_fname = IBS_change_connectivity_f_name(coherence_fname,[measure '_manual']);
clear coherence_fname;


% connectivity_fname = IBS_change_connectivity_f_name(coherence_fname,measure);
% clear coherence_fname;
coherence_fun = @IBS_tf_manual_coherence;
manual_cor_fun = @mscohere;
F = [1:95];

if exist(connectivity_fname,'file')
    cur_analysis_type = analysis_type;
    load(connectivity_fname,'connectivity','conditions','analysis_type');
    assert(strcmp(analysis_type,cur_analysis_type)==1);
else
    
    for Dyd_no = 1:length(Dyads)
        data = IBS_load_clean_IBS_data(Dyads(Dyd_no),analysis_type,data_dir);
        %         load(sprintf('D:\\Experiments\\IBS\\Processed\\EEG\\Dyd_%0.2d_ICA_func_clean_bp_03_95_120s.mat',Dyads(Dyd_no)));
        
        % CAR is not performed for ASR cleaned
        % because it was already done before data cleaning
        
        % the idea here is to avoid mistakes - so that there CAR is
        % performed when requested
        
        % I understand that this is double negation but this is important
        % because contains for 'CAR' gives 1 even for NoCAR
        %         if ~contains(analysis_type,'NoCAR')
        if ~analysis_type_params.CAR_performed
            disp('Perfoming Common Average Referencing (CAR)')
            [data.data_ica_clean_S1] = cellfun(@IBS_re_reference_data,data.data_ica_clean_S1,'UniformOutput', false);
            [data.data_ica_clean_S2] = cellfun(@IBS_re_reference_data,data.data_ica_clean_S2,'UniformOutput', false);
            
        end
        
        
        data.data_ica_clean_S1 = cellfun(@IBS_resampledata,data.data_ica_clean_S1,'UniformOutput', false);       
        data.data_ica_clean_S2 = cellfun(@IBS_resampledata,data.data_ica_clean_S2,'UniformOutput', false);
        
        fsample = data.data_ica_clean_S1{1,1}.fsample;
        window = 2*fsample;
        overlap = 1*fsample;
        %         [data_ica_clean_S1_tf,data_ica_clean_S2_tf] = cellfun(@(x) IBS_tf_condwise(data_ica_clean_S1,data_ica_clean_S2,x),...
        %             conditions,'UniformOutput', false);
        %         clear data_ica_clean_S1 data_ica_clean_S2
        [data_coh] = cellfun(@(x) IBS_tf_coherence_condwise(data.data_ica_clean_S1,data.data_ica_clean_S2,x,coherence_fun,manual_cor_fun,window,overlap,F,fsample),...
            conditions,'UniformOutput', false);
        IBS_save_datasets_tf_manual_conn(Dyads(Dyd_no),data_coh,analysis_type,measure,save_dir)
        
        %         save([ save_dir sprintf('Dyd_%0.2d_trialwise_time_freq_',Dyads(Dyd_no)) analysis_type '.mat'],...
        %             'data_ica_clean_S1_tf','data_ica_clean_S2_tf','-v7.3')
%         if Dyads(Dyd_no) == 12
%            [data_ica_clean_S1_tf,data_ica_clean_S2_tf] = IBS_correct_tf_data(data_ica_clean_S1_tf,data_ica_clean_S2_tf,conditions); 
%         end
        connectivity{1,Dyads(Dyd_no)} = data_coh;
        
    end
    save(connectivity_fname,'connectivity','conditions','analysis_type');
    
end



end