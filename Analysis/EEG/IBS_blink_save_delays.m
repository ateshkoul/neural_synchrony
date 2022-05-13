function IBS_blink_save_delays(results_S1_F,results_S2_F,thresh,thresh_no,condition,data_cleaning,analysis_type,save_dir)


%% Atesh Koul
if nargin <6 || isempty(data_cleaning)
    data_cleaning = 'no_aggressive_trialwise_CAR';
%     save_dir = 'D:\\Experiments\\IBS\\Processed\\EEG\\Only_eye_artefacts\\';
end

if nargin <8
    %     save_dir = 'D:\\Experiments\\IBS\\Processed\\EEG\\Only_eye_artefacts\\';
    analysis_type_params = IBS_get_params_analysis_type(data_cleaning,analysis_type);
    
    save_dir = analysis_type_params.analysis_save_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
    
end

%% get cond name
subset = @(x) x{1};

cond_name = cellfun(@(x) subset(strsplit(x,'_')),condition,'UniformOutput',0);
cond_name = strjoin(unique(cond_name),'_');

%%

% save([save_dir cond_name '_delays_change_thresh_' num2str(thresh(thresh_no)) '.mat'],'results_S1_F','results_S2_F','-v7.3')
save([save_dir cond_name '_delays_change_thresh_' num2str(thresh(thresh_no)) '_additional_11_sub.mat'],'results_S1_F','results_S2_F','-v7.3')

end