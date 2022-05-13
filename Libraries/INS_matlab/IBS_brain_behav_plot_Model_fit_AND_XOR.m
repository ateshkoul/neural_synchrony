function IBS_brain_behav_plot_Model_fit_AND_XOR(data_analysis_type,analysis,glm_result_XOR,glm_result_AND)
%IBS_BRAIN_BEHAV_PLOT_MODEL_FIT function to plot lme model param
%
% SYNOPSIS: IBS_brain_behav_plot_Model_fit
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
% DATE: 19-Apr-2021
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save_dir = IBS_get_params_analysis_type(data_analysis_type,analysis).analysis_save_dir_figures{1,1};

AIC_XOR = cell2mat(cellfun(@(x) x.ModelCriterion{1,1}, glm_result_XOR.stats_cell,'UniformOutput',0));

BIC_XOR = cell2mat(cellfun(@(x) x.ModelCriterion{1,2}, glm_result_XOR.stats_cell,'UniformOutput',0));
Null_AIC_dev = cell2mat(cellfun(@(x) x{1,2}, glm_result_XOR.deviances,'UniformOutput',0));


AIC_AND = cell2mat(cellfun(@(x) x.ModelCriterion{1,1}, glm_result_AND.stats_cell,'UniformOutput',0));

BIC_AND = cell2mat(cellfun(@(x) x.ModelCriterion{1,2}, glm_result_AND.stats_cell,'UniformOutput',0));
% Null_AIC_dev = cell2mat(cellfun(@(x) x{1,2}, glm_result.deviances,'UniformOutput',0));

% figure('units','normalized','outerposition',[0 0 1 1])
figure('units','normalized','outerposition',[0 0 0.3 1])

for i =1:3
subplot(3,1,i)
% b = bar([AIC_OR(i)-Null_AIC_dev_OR(i);AIC_AND(i)-Null_AIC_dev_OR(i)]);
b = bar([Null_AIC_dev(i);AIC_XOR(i);AIC_AND(i)]);
% b = bar([Null_AIC_dev_OR(i);BIC_OR(i);BIC_AND(i)]);

b.CData(2,:) = [0.9 0.1 0];
b.CData(3,:) = [0.2 0.5 0.3];
b.FaceColor = 'flat';
% yaxis([4.2*10e4 4.3*10e4])
yaxis([4.25*10e4 4.68*10e4])

% yaxis([3.5*10e4 4*10e4])
xticklabels({'Null model' 'joint XOR' 'joint AND'})
title(['cluster ' num2str(i)])
ylabel('AIC (a.u.)')

end
% save_f_name = 'E:\Projects\IBS\Results\EEG\Brain_behavior_glm_power_freqwise\no_aggressive_CAR_ASR_10_ICA_appended_trials\figures';
% save_f_name = 'E:\Projects\IBS\Results\EEG\Brain_behavior_glm_power_freqwise\no_aggressive_CAR_ASR_5_ICA_appended_trials\figures';

% saveas(gcf,[save_f_name '\\AIC_value_plots.tif'])
% saveas(gcf,[save_f_name '\\AIC_value_plots_delay_moving.tif'])
% saveas(gcf,[save_dir '\\Model_fit_XOR_AND_' data_analysis_type '_' analysis '.tif'])
end

