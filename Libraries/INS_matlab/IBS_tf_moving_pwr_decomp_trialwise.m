function [moving_decomp,conditions]= IBS_tf_moving_pwr_decomp_trialwise(analysis_type,windowSize,Dyads,analysis)


if nargin <4
    analysis = 'Within_analysis';
end
if nargin <2
windowSize = 5;
end


if nargin <3
       
    %     Dyads = [1:11 13:18 20:23];
    %     Dyads = [1:11 13];
    Dyads = 1:23;
    
    %Dyads = [1:11 13:18];
    
end
analysis_type_params = IBS_get_params_analysis_type(analysis_type,analysis);



data_dir = analysis_type_params.data_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
save_dir = analysis_type_params.analysis_save_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
conditions = analysis_type_params.conditions;


% conditions = {'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'};
%     conditions = {'FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task'};
% freq_bands = [30:55];
% windowSize = 4;% in sec
moving_decomp = cell(2,length(Dyads));
% save_fname = [save_dir sprintf('trialwise_moving_centered_pwr_decomp_%0.1d_window_all_dyads_baseline_normchange_0_120s_CAR.mat',windowSize)];
save_fname = [save_dir sprintf('trialwise_moving_centered_half_overlap_pwr_decomp_%0.1d_window_all_dyads_baseline_normchange_0_120s_CAR.mat',windowSize)];

if exist(save_fname,'file')
    load(save_fname,'moving_decomp','conditions','analysis_type');
else
    for Dyd_no = 1:length(Dyads)
        data = IBS_load_clean_IBS_tf_data(Dyads(Dyd_no),analysis_type,data_dir);
        
        %     data = load(sprintf('D:\\Atesh\\IBS\\CAR\\Dyd_%0.2d_trialwise_time_freq_baseline_normchange_0_120s_CAR.mat',Dyads(Dyd_no)),...
        %         'data_ica_clean_S1_tf','data_ica_clean_S2_tf');
        % ideally should be Dyads(Dyd_no) but par loop doesn't like it.
        moving_decomp{1,Dyads(Dyd_no)} = cellfun(@(x) IBS_moving_pwr_decomp(x,windowSize),...
            data.data_ica_clean_S1_tf,'UniformOutput', false);
        % append in the 2nd col
        moving_decomp{2,Dyads(Dyd_no)} = cellfun(@(x) IBS_moving_pwr_decomp(x,windowSize),...
            data.data_ica_clean_S2_tf,'UniformOutput', false);       
    end
    % vectorize the array to conserve dyad nos to be 1,2,3 etc.
    moving_decomp = moving_decomp(:)';
    
%     moving_decomp = cellfun(@(x) cellfun(@(y) squeeze(mean(mean(cat(4,y{:}),4,'omitnan'),2,'omitnan')), x,'UniformOutput',0),moving_decomp,'UniformOutput',0);
    moving_decomp = cellfun(@(x) cellfun(@(y) squeeze(mean(mean(cat(4,y{:}),2,'omitnan'),4,'omitnan')), x,'UniformOutput',0),moving_decomp,'UniformOutput',0);

    save(save_fname,'moving_decomp','conditions','analysis_type','-v7.3');
end