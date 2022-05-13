function IBS_brain_behav_plot_glm_modulation_coeff(data_analysis_type,analysis,glm_result,plot_title,cond_name)
%IBS_BRAIN_BEHAV_PLOT_GLM_COEFF function to plot lme stat coeff
%
% SYNOPSIS: IBS_brain_behav_plot_glm_coeff
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

cluster_1 = glm_result.stats_cell{1,1};
% cluster_1 = glm_result{1,1};
% coeff_eye_smile_mov_1 = [cluster_1.Coefficients{2,2} cluster_1.Coefficients{8,2} cluster_1.Coefficients{9,2}];
% coeff_eye_smile_mov_1 = [cluster_1.Coefficients{2,2} cluster_1.Coefficients{3,2} cluster_1.Coefficients{4,2}];

% load('E:\Projects\IBS\Results\EEG\Brain_behavior_glm_power_freqwise\no_aggressive_CAR_ASR_5_ICA_appended_trials\Brain_behavior_glm_power_freqwiseno_aggressive_CAR_ASR_5_ICA_appended_trials_joint_OR_avg_sig_cluster_interaction_delay_moving.mat')

cluster_2 = glm_result.stats_cell{1,2};
% cluster_2 = glm_result{1,2};
% coeff_eye_smile_mov_2 = [cluster_2.Coefficients{2,2} cluster_2.Coefficients{8,2} cluster_2.Coefficients{9,2}];
% coeff_eye_smile_mov_2 = [cluster_2.Coefficients{2,2} cluster_2.Coefficients{3,2} cluster_2.Coefficients{4,2}];

cluster_3 = glm_result.stats_cell{1,3};
% cluster_3 = glm_result{1,3};
% coeff_eye_smile_mov_3 = [cluster_3.Coefficients{2,2} cluster_3.Coefficients{8,2} cluster_3.Coefficients{9,2}];
% coeff_eye_smile_mov_3 = [cluster_3.Coefficients{2,2} cluster_3.Coefficients{3,2} cluster_3.Coefficients{4,2}];


%% based on the figure

coeff_eye_smile_mov_1 = [cluster_1.Coefficients{2,2} cluster_1.Coefficients{4,2} cluster_1.Coefficients{3,2} ...
    cluster_1.Coefficients{5,2} cluster_1.Coefficients{6,2}];

coeff_eye_smile_mov_2 = [cluster_2.Coefficients{2,2} cluster_2.Coefficients{4,2} cluster_2.Coefficients{3,2}  ...
    cluster_2.Coefficients{5,2} cluster_2.Coefficients{6,2}];

coeff_eye_smile_mov_3 = [cluster_3.Coefficients{2,2} cluster_3.Coefficients{4,2} cluster_3.Coefficients{3,2}  ...
    cluster_3.Coefficients{5,2} cluster_3.Coefficients{6,2}];


%%
% bar([coeff_eye_smile_mov_1;coeff_eye_smile_mov_2 ;coeff_eye_smile_mov_3])
all_sig_coef = [coeff_eye_smile_mov_1;coeff_eye_smile_mov_2 ;coeff_eye_smile_mov_3];

% y_limits = [0 0.05;-0.16 0.05;-0.16 0.05];
% y_limits = [-0.08 0.06;-0.4 0.06;-0.16 0.06];
% y_limits = [-0.45 0.4;-0.45 0.4;-0.45 0.4];
% y_limits = [-0.3 0.15;-0.3 0.15;-0.3 0.15];
y_limits = [-0.07 0.07;-0.07 0.07;-0.07 0.07];
asterik_loc = 0.055;
switch(cond_name)
    case {'FaNoOcc_NeNoOcc_all_norm','FaNoOcc_all_norm'}
        y_limits = [-1.1 1.1;-1.1 1.1;-1.1 1.1];
        asterik_loc = 0.95;
    case 'NeNoOcc_all_norm'
        
        y_limits = [-2.1 2.1;-2.1 2.1;-2.1 2.1];
        asterik_loc = 1.9;
end

% figure('units','normalized','outerposition',[0 0 1 1])
figure('units','normalized','outerposition',[0 0 0.5 1])

for i = 1:3
subplot(3,1,i)
b = bar(all_sig_coef(i,:));
b.CData(2,:) = [0.9 0.1 0];
b.CData(3,:) = [0.2 0.5 0.3];

b.FaceColor = 'flat';
hold on

if cluster_1.Coefficients{2,6}<0.05 && i == 1
    text(1,asterik_loc,'*','FontSize',20)
end
   
% if cluster_1.Coefficients{8,6}<0.05 && i == 1
%     text(2,asterik_loc,'*','FontSize',20)
% end

   
if cluster_1.Coefficients{3,6}<0.05 && i == 1
    text(2,asterik_loc,'*','FontSize',20)
end
   
% if cluster_1.Coefficients{9,6}<0.05 && i == 1
%     text(3,asterik_loc,'*','FontSize',20)
% end
 if cluster_1.Coefficients{4,6}<0.05 && i == 1
    text(3,asterik_loc,'*','FontSize',20)
 end   

  if cluster_1.Coefficients{5,6}<0.05 && i == 1
    text(4,asterik_loc,'*','FontSize',20)
  end   
 if cluster_1.Coefficients{6,6}<0.05 && i == 1
    text(5,asterik_loc,'*','FontSize',20)
end   
 %
 if cluster_2.Coefficients{2,6}<0.05 && i == 2
    text(1,asterik_loc,'*','FontSize',20)
end
%    
% if cluster_2.Coefficients{8,6}<0.05 && i == 2
%     text(2,asterik_loc,'*','FontSize',20)
% end
%    
% if cluster_2.Coefficients{9,6}<0.05 && i == 2
%     text(3,0.04,'*','FontSize',20)
% end


if cluster_2.Coefficients{3,6}<0.05 && i == 2
    text(2,asterik_loc,'*','FontSize',20)
end
   
if cluster_2.Coefficients{4,6}<0.05 && i == 2
    text(3,asterik_loc,'*','FontSize',20)
end
if cluster_2.Coefficients{5,6}<0.05 && i == 2
    text(4,asterik_loc,'*','FontSize',20)
end
   
if cluster_2.Coefficients{6,6}<0.05 && i == 2
    text(5,asterik_loc,'*','FontSize',20)
end

%
 if cluster_3.Coefficients{2,6}<0.05 && i == 3
    text(1,asterik_loc,'*','FontSize',20)
end
   
% if cluster_3.Coefficients{8,6}<0.05 && i == 3
% %     text(2,cluster_3.Coefficients{8,2}+(0.05.* sign(cluster_3.Coefficients{8,2})),'*','FontSize',20)
%         text(2,asterik_loc,'*','FontSize',20)
% 
% end
%    


if cluster_3.Coefficients{3,6}<0.05 && i == 3
%     text(2,cluster_3.Coefficients{8,2}+(0.05.* sign(cluster_3.Coefficients{8,2})),'*','FontSize',20)
        text(2,asterik_loc,'*','FontSize',20)

end


% if cluster_3.Coefficients{9,6}<0.05 && i == 3
% %     text(3,cluster_3.Coefficients{9,2}+(0.05.* sign(cluster_3.Coefficients{8,2})),'*','FontSize',20)
%     text(3,asterik_loc,'*','FontSize',20)
% 
% end

if cluster_3.Coefficients{4,6}<0.05 && i == 3
%     text(3,cluster_3.Coefficients{9,2}+(0.05.* sign(cluster_3.Coefficients{8,2})),'*','FontSize',20)
    text(3,asterik_loc,'*','FontSize',20)

end

if cluster_3.Coefficients{5,6}<0.05 && i == 3
%     text(3,cluster_3.Coefficients{9,2}+(0.05.* sign(cluster_3.Coefficients{8,2})),'*','FontSize',20)
    text(4,asterik_loc,'*','FontSize',20)

end

if cluster_3.Coefficients{6,6}<0.05 && i == 3
%     text(3,cluster_3.Coefficients{9,2}+(0.05.* sign(cluster_3.Coefficients{8,2})),'*','FontSize',20)
    text(5,asterik_loc,'*','FontSize',20)

end
yaxis(y_limits(i,:))
% axis auto
% xticklabels({'Gaze nose' 'Mouth size' 'All mov'})
% xticklabels({'Eye contact' 'Smile' 'Body movements'})

xtl_eye = '\begin{tabular}{c} Eye \\ contact \end{tabular}';
xtl_body = '\begin{tabular}{c} Body \\ movements   \end{tabular}';
xtl_smiling = '\begin{tabular}{c} Smile \\ behavior \end{tabular}';
xtl_eye_smiling = '\begin{tabular}{c} Eye - Smile \\ behavior \end{tabular}';

xtl_eye_body = '\begin{tabular}{c} Eye -Body \\ movements   \end{tabular}';

set(gca, 'XTickLabel', {xtl_eye xtl_body xtl_smiling xtl_eye_smiling xtl_eye_body }, 'TickLabelInterpreter', 'latex');


ylabel('normalized coefficients')
ax = gca;
ax.XAxis.FontSize = 11;
% ax.XAxis.TickLabelRotation = 45;
ax.YAxis.Label.FontSize = 12;
end

sgtitle([cond_name '_' plot_title],'Interpreter','none')
% save_f_name = 'E:\Projects\IBS\Results\EEG\Brain_behavior_glm_power_freqwise\no_aggressive_CAR_ASR_10_ICA_appended_trials\figures';
% save_f_name = 'E:\Projects\IBS\Results\EEG\Brain_behavior_glm_power_freqwise\no_aggressive_CAR_ASR_5_ICA_appended_trials\figures';

saveas(gcf,[save_dir '\\' 'no_detrend_' cond_name '_coefficient_' plot_title '.tif'])
% exportgraphics(gcf,[save_dir '\\' cond_name '_coefficient_' plot_title '.eps'],'BackgroundColor','none','ContentType','vector')
end