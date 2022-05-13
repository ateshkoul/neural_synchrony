function IBS_behav_corr(matplot)
%IBS_behav_corr
%
% SYNOPSIS: IBS_behav_corr
%
% INPUT Function to estimate behavioral correlation
%
% OUTPUT
%
% REMARKS
%
% created with MATLAB ver.: 9.8.0.1359463 (R2020a) Update 1 on Microsoft Windows 10 Pro Version 10.0 (Build 19042)
%
% created by: Atesh
% DATE: 12-Aug-2021
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin<1
matplot = 0;
end
behaviors = {'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned'};
% behaviors = {'Eye_tracker_pupil','Smile_auto','video_openpose_landmarks_manual_cleaned'};

behav_analysis = 'joint';
output_data = 'no_joint';

Dyads = 1:23;
% lag_no = [];
analysis = 'Brain_behavior_glm_power_freqwise';
data_analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';

save_dir_figures = IBS_get_params_analysis_type(data_analysis_type,analysis).analysis_save_dir_figures{1,1};
save_dir = IBS_get_params_analysis_type(data_analysis_type,analysis).analysis_save_dir{1,1};

% doesn't change anything for this analysis
% analysis_sub_type = '_insta_corr_avg_freqwise';
analysis_sub_type = '_insta_abs_detrend';
% behavior_data = cellfun(@(x) IBS_load_behavior_data(x,data_analysis_type,Dyads,conditions,behav_analysis,analysis_sub_type),...
%     behaviors,'UniformOutput',false);
conditions = {{'NeNoOcc_1'}, {'NeNoOcc_2'}, {'NeNoOcc_3'} ,{'FaNoOcc_1'},{'FaNoOcc_2'},{'FaNoOcc_3'}};


result_fname = [save_dir 'behav_corr_smile_cor.mat'];

if exist(result_fname,'file')
    avg_over_conditions = load(result_fname);
    % csvwrite([save_dir 'behav_behav_cov_subwise.csv'],avg_over_conditions)
    writetable(avg_over_conditions.avg_over_conditions_table,[save_dir 'behav_corr_smile_cor.csv'])
else
    
    behavior_data = cellfun(@(x) cellfun(@(y) IBS_load_behavior_data(x,data_analysis_type,...
        Dyads,y,behav_analysis,analysis_sub_type,output_data),conditions,'UniformOutput',false),...
        behaviors,'UniformOutput',false);
    
    % mapObj = containers.Map({'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned'},...
    %     {'eye_gaze_distance','mouth_size','ALL'});
    
    
    cur_cov = cellfun(@(behav) cellfun(@(cond) cell2mat(arrayfun(@(x) ...
        nancorr(table2array(cond{1,1}{x}(:,1)),table2array(cond{1,2}{x}(:,1))),1:23,'UniformOutput',0)),...
        behav,'UniformOutput',false),...
        behavior_data,'UniformOutput',false);
    cur_cov = cat(1,cur_cov{:});
    cur_cov =arrayfun(@(x) cat(1,cur_cov{x,:}),1:size(cur_cov,1),'UniformOutput',0);
    
    cur_cov = cat(3,cur_cov{:});
    
    avg_over_conditions = squeeze(nanmean(cur_cov));
    % csvwrite([save_dir 'behav_corr.csv'],avg_over_conditions)
    % nancorr(behavior_data{1, 2}{1, 2}{1, 1}{1, 2}.mouth_size_0,behavior_data{1, 2}{1, 2}{1, 2}{1, 2}.mouth_size_1)
    subset = @(x) x{1};
    short_labels = cellfun(@(x) subset(strsplit(x,'_')),behaviors,'UniformOutput',0);
    
    
    avg_over_conditions_table = array2table(avg_over_conditions,'VariableNames',short_labels);
    % csvwrite([save_dir 'behav_behav_cov_subwise.csv'],avg_over_conditions)
    writetable(avg_over_conditions_table,[save_dir 'behav_corr.csv'])
    save(result_fname,'avg_over_conditions','cur_cov','behaviors','output_data',...
        'behav_analysis','short_labels','avg_over_conditions_table','conditions')

end

if(matplot)
    sem = @(x,dim) nanstd( x,0,dim ) / sqrt( size( x,dim ));
    figure
    bar(mean(avg_over_conditions))
    
    hold on
    errorbar(mean(avg_over_conditions),sem(avg_over_conditions,1),'k','linestyle','none')
    
    xticklabels(short_labels)
    [h,p] = ttest(avg_over_conditions);
    asterik_loc = 0.35;
    asterik = {'*'};
    for comb = 1:length(h)
        text(comb,asterik_loc,asterik(logical(h(comb))),'FontSize',20)
    end
    ylim([-0.02 0.4])
    title('behav corr')
    exportgraphics(gcf,[save_dir_figures 'behav_corr.eps'],'BackgroundColor','none','ContentType','vector')
    
end
end