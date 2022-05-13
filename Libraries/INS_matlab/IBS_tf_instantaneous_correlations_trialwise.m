function [instantaneous_correlation,conditions]= IBS_tf_instantaneous_correlations_trialwise(analysis_type,Dyads)



if nargin <2
    %     Dyads = [1:11 13:18 20:23];
    %     Dyads = [1:11 13];
    Dyads = 1:23;
    
    %Dyads = [1:11 13:18];
    
end

analysis_type_params = IBS_get_params_analysis_type(analysis_type);
data_dir = analysis_type_params.data_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
% save_power_dir = analysis_type_params.save_power_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
correlation_fname = analysis_type_params.correlation_fname{1,1};
correlation_fname = strrep(correlation_fname,'trialwise_correlations_','insta_corr_smooth_2_s_');
conditions = analysis_type_params.conditions;
% process_dir = 'D:\\Experiments\\IBS\\Processed\\EEG\\';
% process_dir = 'D:\\Atesh\\IBS\\';

if exist(correlation_fname,'file')
    load(correlation_fname,'instantaneous_correlation','conditions','analysis_type');
else
    for Dyd_no = 1:length(Dyads)
        data = IBS_load_clean_IBS_tf_data(Dyads(Dyd_no),analysis_type,data_dir);
        
        %     data = load(sprintf('D:\\Atesh\\IBS\\CAR\\Dyd_%0.2d_trialwise_time_freq_baseline_normchange_0_120s_CAR.mat',Dyads(Dyd_no)),...
        %         'data_ica_clean_S1_tf','data_ica_clean_S2_tf');
        % ideally should be Dyads(Dyd_no) but par loop doesn't like it.
        instantaneous_correlation = cellfun(@(x,y) IBS_compute_instantaneous_angle_tf(x,y),...
            data.data_ica_clean_S1_tf,data.data_ica_clean_S2_tf,'UniformOutput', false);
        
        save_fname = [data_dir sprintf('Dyd_%0.1d_instantaneous_corr_smooth_2_s.mat',Dyads(Dyd_no))];
        
        save(save_fname,'instantaneous_correlation','conditions','analysis_type','-v7.3');
        instantaneous_correlation_all_dyads{1,Dyd_no} =instantaneous_correlation;
    end
    save(correlation_fname,'instantaneous_correlation_all_dyads','conditions','analysis_type','-v7.3');
end