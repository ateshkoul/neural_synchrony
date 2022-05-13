function [coherences,conditions,coherence_fname]= IBS_tf_coherence_correlations(analysis_type,measure,Dyads)


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


% connectivity_fname = IBS_change_connectivity_f_name(coherence_fname,measure);
% clear coherence_fname;

if exist(coherence_fname,'file')
    cur_analysis_type = analysis_type;
    load(coherence_fname,'coherences','conditions','analysis_type');
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
        
        
        %         [data_ica_clean_S1_tf,data_ica_clean_S2_tf] = cellfun(@(x) IBS_tf_condwise(data_ica_clean_S1,data_ica_clean_S2,x),...
        %             conditions,'UniformOutput', false);
        %         clear data_ica_clean_S1 data_ica_clean_S2
        [data_coh] = cellfun(@(x) IBS_tf_coherence_condwise(data.data_ica_clean_S1,data.data_ica_clean_S2,x),...
            conditions,'UniformOutput', false);
        IBS_save_datasets_tf_coherence(Dyads(Dyd_no),data_coh,analysis_type,save_dir)
        
%         data_coh = IBS_load_tf_coherence(Dyads(Dyd_no),analysis_type,data_dir);
%         data_coh = data_coh.data_coherence;
        
        %         save([ save_dir sprintf('Dyd_%0.2d_trialwise_time_freq_',Dyads(Dyd_no)) analysis_type '.mat'],...
        %             'data_ica_clean_S1_tf','data_ica_clean_S2_tf','-v7.3')
%         if Dyads(Dyd_no) == 12
%            [data_ica_clean_S1_tf,data_ica_clean_S2_tf] = IBS_correct_tf_data(data_ica_clean_S1_tf,data_ica_clean_S2_tf,conditions); 
%         end
        coherences{1,Dyads(Dyd_no)} = cellfun(@(x,y) IBS_connectivity_analysis(x,measure),data_coh,...
            'UniformOutput', false);
        
    end
    save(coherence_fname,'coherences','conditions','analysis_type');
    
end



end

% valid measures
%     'amplcorr',  amplitude correlation, support for freq and source data
%     'coh',       coherence, support for freq, freqmvar and source data.
%                  For partial coherence also specify cfg.partchannel, see below.
%                  For imaginary part of coherency or coherency also specify
%                  cfg.complex, see below.
%     'csd',       cross-spectral density matrix, can also calculate partial
%                  csds - if cfg.partchannel is specified, support for freq
%                  and freqmvar data
%     'dtf',       directed transfer function, support for freq and freqmvar data
%     'granger',   granger causality, support for freq and freqmvar data
%     'pdc',       partial directed coherence, support for freq and freqmvar data
%     'plv',       phase-locking value, support for freq and freqmvar data
%     'powcorr',   power correlation, support for freq and source data
%     'powcorr_ortho', power correlation with single trial
%                  orthogonalisation, support for source data
%     'ppc'        pairwise phase consistency
%     'psi',       phaseslope index, support for freq and freqmvar data
%     'wpli',      weighted phase lag index (signed one, still have to
%                  take absolute value to get indication of strength of
%                  interaction. Note that this measure has a positive
%                  bias. Use wpli_debiased to avoid this.
%     'wpli_debiased'  debiased weighted phase lag index (estimates squared wpli)
%     'wppc'       weighted pairwise phase consistency
%     'corr'       Pearson correlation, support for timelock or raw data
%     'laggedcoherence', lagged coherence estimate