function [results_S1_F,results_S2_F] = IBS_blink_load_delays(Dyad_no,condition_no,thresh,thresh_no,data_cleaning,analysis_type,save_dir)


%% Atesh Koul
if nargin <5 || isempty(data_cleaning)
    data_cleaning = 'no_aggressive_trialwise_CAR';
%     save_dir = 'D:\\Experiments\\IBS\\Processed\\EEG\\Only_eye_artefacts\\';
end

if nargin<6
    
analysis_type = 'Blink_detection';

end
if nargin <7
    %     save_dir = 'D:\\Experiments\\IBS\\Processed\\EEG\\Only_eye_artefacts\\';
    analysis_type_params = IBS_get_params_analysis_type(data_cleaning,analysis_type);
    
    save_dir = analysis_type_params.analysis_save_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
    
end

% load([save_dir 'test_all_sub_change_thresh_' num2str(thresh(thresh_no)) '.mat'],'results_S1_F','results_S2_F')
load([save_dir 'delays_change_thresh_' num2str(thresh(thresh_no)) '.mat'],'results_S1_F','results_S2_F')

results_S1_F = results_S1_F(Dyad_no,condition_no);
results_S2_F = results_S2_F(Dyad_no,condition_no);
end