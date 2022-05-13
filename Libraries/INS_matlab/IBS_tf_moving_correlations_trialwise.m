function [moving_correlation,conditions]= IBS_tf_moving_correlations_trialwise(freq_bands,windowSize,analysis_type,Dyads)



if nargin <4
%     Dyads = [1:11 13:18 20:23];
    %     Dyads = [1:11 13];
    Dyads = 1:23;
    
    %Dyads = [1:11 13:18];
    
end

analysis_type_params = IBS_get_params_analysis_type(analysis_type);



data_dir = analysis_type_params.data_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
save_dir = analysis_type_params.save_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
conditions = analysis_type_params.conditions;


% conditions = {'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'};
%     conditions = {'FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task'};
% freq_bands = [30:55];
% windowSize = 4;% in sec
save_fname = [save_dir sprintf('trialwise_moving_centered_corr_%0.1d_window_%0.1d_%0.1d_all_dyads_baseline_normchange_0_120s_CAR.mat',windowSize,freq_bands(1),freq_bands(end))];
if exist(save_fname,'file')
    load(save_fname,'moving_correlation','conditions','analysis_type');
else
    for Dyd_no = 1:length(Dyads)
        data = IBS_load_clean_IBS_tf_data(Dyads(Dyd_no),analysis_type,data_dir);
        
        %     data = load(sprintf('D:\\Atesh\\IBS\\CAR\\Dyd_%0.2d_trialwise_time_freq_baseline_normchange_0_120s_CAR.mat',Dyads(Dyd_no)),...
        %         'data_ica_clean_S1_tf','data_ica_clean_S2_tf');
        % ideally should be Dyads(Dyd_no) but par loop doesn't like it.
        moving_correlation{1,Dyd_no} = cellfun(@(x,y) IBS_moving_power_correlation(x,y,freq_bands,windowSize),...
            data.data_ica_clean_S1_tf,data.data_ica_clean_S2_tf,'UniformOutput', false);
        
        
    end
    save(save_fname,'moving_correlation','conditions','analysis_type','-v7.3');
end
