function IBS_brain_behav_plot_Model_fit(data_analysis_type,analysis,glm_result,cond_name)
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
% DATE: 16-Apr-2021
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save_dir = IBS_get_params_analysis_type(data_analysis_type,analysis).analysis_save_dir_figures{1,1};

AIC = cell2mat(cellfun(@(x) x.ModelCriterion{1,1}, glm_result.stats_cell,'UniformOutput',0));

BIC = cell2mat(cellfun(@(x) x.ModelCriterion{1,2}, glm_result.stats_cell,'UniformOutput',0));
Null_AIC_dev = cell2mat(cellfun(@(x) x{1,1}, glm_result.deviances,'UniformOutput',0));

Null_BIC_dev = cell2mat(cellfun(@(x) x{1,2}, glm_result.deviances,'UniformOutput',0));

% figure('units','normalized','outerposition',[0 0 1 1])
figure('units','normalized','outerposition',[0 0 0.3 1])

for i =1:3
subplot(3,1,i)
% b = bar([AIC_OR(i)-Null_AIC_dev_OR(i);AIC_AND(i)-Null_AIC_dev_OR(i)]);
b = bar([Null_AIC_dev(i);AIC(i)]);
% b = bar([Null_AIC_dev_OR(i);BIC_OR(i);BIC_AND(i)]);
% text(1.5,Null_AIC_dev(i)+0.04*Null_AIC_dev(i),num2str(AIC(i)-Null_AIC_dev(i)))
% b.CData(2,:) = [0.9 0.1 0];
b.CData(1,:) = [0 0 0];
b.CData(2,:) = [0.5 0.5 0.5];

b.FaceColor = 'flat';
% yaxis([4.41*10e4 4.46*10e4])
% yaxis([4.42*10e4 4.59*10e4])
yaxis([4.465*10e4 4.495*10e4])

% axis auto

% yaxis([3.5*10e4 4*10e4])
% xticklabels({'Null model' 'joint'})
% xticklabels({'Null model' ''})
xtl = '\begin{tabular}{c} Social Behavior \\ model \end{tabular}';
xtl_null = '\begin{tabular}{c} Null \\ model \end{tabular}';

set(gca, 'XTickLabel', {xtl_null xtl}, 'TickLabelInterpreter', 'latex');

title(['cluster ' num2str(i)])
ylabel('AIC (a.u.)')
ax = gca;
% ax.XAxis.FontSize = 15;

% ax = gca;
ax.XAxis.FontSize = 12;
% ax.XAxis.TickLabelRotation = 45;
ax.YAxis.Label.FontSize = 12;
end
sgtitle([cond_name '_joint'],'Interpreter','none')

% save_f_name = 'E:\Projects\IBS\Results\EEG\Brain_behavior_glm_power_freqwise\no_aggressive_CAR_ASR_10_ICA_appended_trials\figures';
% save_f_name = 'E:\Projects\IBS\Results\EEG\Brain_behavior_glm_power_freqwise\no_aggressive_CAR_ASR_5_ICA_appended_trials\figures';

% saveas(gcf,[save_f_name '\\AIC_value_plots.tif'])
% saveas(gcf,[save_f_name '\\AIC_value_plots_delay_moving.tif'])
% saveas(gcf,[save_dir '\\' 'no_detrend_' cond_name '_model_fit.tif'])
% exportgraphics(gcf,[save_dir '\\' cond_name '_model_fit_new_smile_cor7.eps'],'BackgroundColor','none','ContentType','vector')

end

