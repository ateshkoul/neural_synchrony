function [avg_spectrum,conditions] = IBS_tf_within_pwr_decomp_trialwise(analysis_type,Dyads,analysis)
%IBS_TF_WITHIN_PWR_DECOMP_TRIALWISE function to decompose power in conditions
%
% SYNOPSIS: IBS_TF_WITHIN_PWR_DECOMP_TRIALWISE
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
% DATE: 12-Apr-2021
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin <3
    analysis = 'Within_analysis';
end


if nargin <2
    
    %     Dyads = [1:11 13:18 20:23];
    %     Dyads = [1:11 13];
    Dyads = 1:23;
    
    %Dyads = [1:11 13:18];
    
end
analysis_type_params = IBS_get_params_analysis_type(analysis_type,analysis);



data_dir = analysis_type_params.data_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
save_dir = analysis_type_params.analysis_save_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
conditions = analysis_type_params.conditions;
anova_cond = {'FaOcc','FaNoOcc','NeOcc', 'NeNoOcc' };


% conditions = {'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'};
%     conditions = {'FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task'};
% freq_bands = [30:55];
% windowSize = 4;% in sec
avg_spectrum = cell(2,length(Dyads));

tf_fun = @IBS_tf_within;



% save_fname = [save_dir sprintf('trialwise_moving_centered_pwr_decomp_%0.1d_window_all_dyads_baseline_normchange_0_120s_CAR.mat',windowSize)];
save_fname = [save_dir 'trialwise_within_analysis_pwr_decomp_all_dyads_baseline_combined_normchange_0_120s_CAR.mat'];

if exist(save_fname,'file')
    load(save_fname,'avg_spectrum','conditions','analysis_type');
else
    for Dyd_no = 1:length(Dyads)
        data = IBS_load_clean_IBS_data(Dyads(Dyd_no),analysis_type,data_dir);
        
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
        
        
        
        [data_ica_clean_S1_tf,data_ica_clean_S2_tf] = cellfun(@(x) IBS_tf_condwise(data.data_ica_clean_S1,data.data_ica_clean_S2,x,tf_fun),...
            conditions,'UniformOutput', false);
        IBS_save_datasets_tf_within(Dyads(Dyd_no),data_ica_clean_S1_tf,data_ica_clean_S2_tf,analysis_type,data_dir)

        %         IBS_save_datasets_tf(Dyads(Dyd_no),data_ica_clean_S1_tf,data_ica_clean_S2_tf,analysis_type,data_dir)
        anova_cond_loc = ismember(conditions,anova_cond);
        % normchange
        data_ica_clean_S1_tf(anova_cond_loc) = IBS_tf_compute_joint_baseline(data_ica_clean_S1_tf(anova_cond_loc));
        data_ica_clean_S2_tf(anova_cond_loc) = IBS_tf_compute_joint_baseline(data_ica_clean_S2_tf(anova_cond_loc));
        % first average over time (4th dimension) and then over trials
        avg_spectrum{1,Dyd_no} = cellfun(@(x) squeeze(mean(mean(x.powspctrm,4,'omitnan'),1)),...
            data_ica_clean_S1_tf,'UniformOutput', false);
        avg_spectrum{2,Dyd_no} = cellfun(@(x) squeeze(mean(mean(x.powspctrm,4,'omitnan'),1)),...
            data_ica_clean_S2_tf,'UniformOutput', false);
    end
    % vectorize the array to conserve dyad nos to be 1,2,3 etc.
    avg_spectrum = avg_spectrum(:)';
    
    %     moving_decomp = cellfun(@(x) cellfun(@(y) squeeze(mean(mean(cat(4,y{:}),4,'omitnan'),2,'omitnan')), x,'UniformOutput',0),moving_decomp,'UniformOutput',0);
%     moving_decomp = cellfun(@(x) cellfun(@(y) squeeze(mean(mean(cat(4,y{:}),2,'omitnan'),4,'omitnan')),...
%         x,'UniformOutput',0),moving_decomp,'UniformOutput',0);
    
    save(save_fname,'avg_spectrum','conditions','analysis_type','-v7.3');
end
