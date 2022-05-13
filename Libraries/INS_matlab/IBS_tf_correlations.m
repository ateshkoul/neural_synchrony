function [correlations,conditions,correlation_fname]= IBS_tf_correlations(analysis_type,Dyads)


if nargin <2
    Dyads = [1:23];
end

if nargin <1
    analysis_type = 'no_aggressive_trialwise_CAR';
end


analysis_type_params = IBS_get_params_analysis_type(analysis_type);
data_dir = analysis_type_params.data_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
% save_power_dir = analysis_type_params.save_power_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
correlation_fname = analysis_type_params.correlation_fname{1,1};
conditions = analysis_type_params.conditions;
% process_dir = 'D:\\Experiments\\IBS\\Processed\\EEG\\';
% process_dir = 'D:\\Atesh\\IBS\\';
correlation_fname = strrep(correlation_fname,'trialwise_correlations_','trialwise_detrend_correlations_');
% correlation_fname = strrep(correlation_fname,'trialwise_correlations_','trialwise_detrend_correlations_gamma_200avg_');


if exist(correlation_fname,'file')
    load(correlation_fname,'correlations','conditions');
    % fisher transform it
    fisher_fun = @(x) 0.5 * log((1 + x)/(1 - x)); % or @(x) atanh(x);
    correlations = cellfun(@(x) cellfun(@(y) arrayfun(@(z) fisher_fun(z),y),x,'UniformOutput',0),...
        correlations,'UniformOutput',0);
    
    
else
    
    parfor Dyd_no = 1:length(Dyads)
        try
            data = IBS_load_clean_IBS_tf_data(Dyads(Dyd_no),analysis_type,data_dir);
            data_ica_clean_S1_tf = data.data_ica_clean_S1_tf;
            data_ica_clean_S2_tf = data.data_ica_clean_S2_tf;
            
        catch
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
            %         [data_ica_clean_S1_tf,data_ica_clean_S2_tf] = cellfun(@(x) IBS_tf_condwise(data_ica_clean_S1,data_ica_clean_S2,x),...
            %             conditions,'UniformOutput', false);
            %         clear data_ica_clean_S1 data_ica_clean_S2
            [data_ica_clean_S1_tf,data_ica_clean_S2_tf] = cellfun(@(x) IBS_tf_condwise(data.data_ica_clean_S1,data.data_ica_clean_S2,x),...
                conditions,'UniformOutput', false);
            IBS_save_datasets_tf(Dyads(Dyd_no),data_ica_clean_S1_tf,data_ica_clean_S2_tf,analysis_type,data_dir)
            
            %         save([ save_dir sprintf('Dyd_%0.2d_trialwise_time_freq_',Dyads(Dyd_no)) analysis_type '.mat'],...
            %             'data_ica_clean_S1_tf','data_ica_clean_S2_tf','-v7.3')
        end
        correlations{1,Dyd_no} = cellfun(@(x,y) IBS_power_correlation(x,y),data_ica_clean_S1_tf,data_ica_clean_S2_tf,...
            'UniformOutput', false);
    end
    save(correlation_fname,'correlations','conditions');
    
end



end



% switch(analysis_type)
%     % these are old wrong correlation analyses
%     % correlation_fname = 'D:\\Experiments\\IBS\\Processed\\EEG\\correlations_1_11_13_18_20_23_dyads_CAR.mat';
%     % correlation_fname = 'D:\\Experiments\\IBS\\Processed\\EEG\\correlations_1_11_13_18_20_23_dyads_baseline_rel_0_120s_CAR.mat';
%     % correlation_fname = 'D:\\Experiments\\IBS\\Processed\\EEG\\Only_eye_artefacts\\correlations_1_11_13_18_20_23_dyads_baseline_normchange_0_120s_NoCAR.mat';
%
%     % correlation_fname = 'D:\\Experiments\\IBS\\Processed\\EEG\\Only_eye_artefacts\\correlations_1_11_13_18_20_23_dyads_baseline_normchange_0_120s_CAR.mat';
%     % correlation_fname = 'D:\\Experiments\\IBS\\Processed\\EEG\\correlations_1_11_13_18_20_23_dyads_muscle_baseline_normchange_0_120s_NoCAR.mat';
%     % correlation_fname = 'D:\\Experiments\\IBS\\Processed\\EEG\\correlations_1_11_13_18_20_23_dyads_muscle_baseline_normchange_0_120s_CAR.mat';
%
%     case 'aggressive_trialwise_NoCAR'
%         conditions = {'FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task'};
%
%         correlation_fname = [process_dir 'trialwise_correlations_1_11_13_18_20_23_dyads_muscle_baseline_normchange_0_120s_NoCAR.mat'];
%
%     case 'aggressive_trialwise_CAR'
%         conditions = {'FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task'};
%
%         correlation_fname = 'D:\\Experiments\\IBS\\Processed\\EEG\\trialwise_correlations_1_11_13_18_20_23_dyads_muscle_baseline_normchange_0_120s_CAR.mat';
%
%     case 'no_aggressive_trialwise_CAR'
%         conditions = {'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'};
%
%         correlation_fname = [ process_dir 'trialwise_correlations_1_11_13_18_20_23_dyads_baseline_normchange_0_120s_CAR.mat'];
%     case 'no_aggressive_trialwise_NoCAR'
%         conditions = {'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'};
%         save_dir = [process_dir 'Only_eye_artefacts\\'];
%
%         correlation_fname = [process_dir 'trialwise_correlations_1_11_13_18_20_23_dyads_baseline_normchange_0_120s_NoCAR.mat'];
%     case 'no_aggressive_ASR_clean_trialwise_CAR'
%         conditions = {'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'};
%         correlation_fname = [ process_dir 'ASR_clean_trialwise_correlations_1_11_13_18_20_23_dyads_baseline_normchange_0_120s_CAR.mat'];
%         save_dir = [process_dir 'ASR_cleaned\\'];
%
%     case 'no_aggressive_ASR_re_notch_clean_trialwise_CAR'
%         conditions = {'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'};
%         correlation_fname = [ process_dir 'ASR_clean_re_notch_trialwise_correlations_1_11_13_18_20_23_dyads_baseline_normchange_0_120s_CAR.mat'];
%         save_dir = [process_dir 'ASR_cleaned\\'];
%     case 'no_aggressive_ASR_8_clean_trialwise_CAR'
%         conditions = {'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'};
%         correlation_fname = [ process_dir 'ASR_clean_8_trialwise_correlations_1_11_13_18_20_23_dyads_baseline_normchange_0_120s_CAR.mat'];
%         save_dir = [process_dir 'ASR_cleaned\\'];
%          case 'no_aggressive_ASR_20_clean_trialwise_CAR'
%         conditions = {'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'};
%         correlation_fname = [ process_dir 'ASR_clean_20_trialwise_correlations_1_11_13_18_20_23_dyads_baseline_normchange_0_120s_CAR.mat'];
%         save_dir = [process_dir 'ASR_cleaned\\'];
%
%    case 'no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'
%         conditions = {'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'};
%         correlation_fname = [ process_dir 'CAR_ASR_5_ICA_appended_trials_comp_CAR_trialwise_correlations_1_11_13_18_20_23_dyads_baseline_normchange_0_120s_CAR.mat'];
%         save_dir = [process_dir 'ASR_cleaned\\'];
% end