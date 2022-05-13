function IBS_brain_behavior_behav_crosscorr(analysis_type,behavior,conditions,analysis_sub_type)
%IBS_BRAIN_BEHAVIOR_BEHAV_CROSSCORR crosscorr with behav of 2 individuals
%
% SYNOPSIS: IBS_brain_behavior_behav_crosscorr
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
% DATE: 14-May-2021
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
behav_analysis = 'joint';
output_data = 'all';
% analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
% conditions = {'NeNoOcc_1' 'NeNoOcc_2' 'NeNoOcc_3'};
% condition_starts = [1 1201 1201+1201 1201+1201+1201];
condition_starts = [0 1201 1201+1201 1201+1201+1201];
condition_starts = [0 1201 1201+1201 1201*3 1201*4 1201*5 1201*6 1201*7];
Dyads = 1:23;
% lag_no = [];
analysis = 'Brain_behavior_glm_power_freqwise';

behav_data = IBS_load_behavior_data(behavior,analysis_type,Dyads,conditions,behav_analysis,analysis_sub_type,output_data);
analysis_type_params = IBS_get_params_analysis_type(analysis_type,analysis);
analysis_save_dir_figures = analysis_type_params.analysis_save_dir_figures{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
lags =100;
xcf_joint_mat = nan(length(Dyads),2*lags+1);

mapObj = containers.Map({'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned'},...
    {'eye_gaze_distance','mouth_size','ALL'});
% mapObj = containers.Map({'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned'},...
%     {'Fun_eye_gaze_distance','Fun_mouth_size','Fun_ALL'});
mapObj_ylims = containers.Map({'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned'},...
    {[-0.04 0.07], [-0.04 0.5], [-0.04 0.2]});


for dyd_no = 1:length(Dyads)
    
    S1_value = behav_data{1}{Dyads(dyd_no)};
    S2_value = behav_data{2}{Dyads(dyd_no)};
    
    xcf_joint_mat_cond = nan(2*lags+1,length(conditions));
    for cond = 1:length(conditions)
      cur_behav_1 = S1_value.([mapObj(behavior) '_0']);
      cur_behav_2 = S2_value.([mapObj(behavior) '_1']);

      
      cur_behav_1 = cur_behav_1((condition_starts(cond)+1):condition_starts(cond+1));
      
      cur_behav_2 = cur_behav_2((condition_starts(cond)+1):condition_starts(cond+1));
      
      
     cur_corr(Dyads(dyd_no),cond) = nancorr(cur_behav_1,cur_behav_2);
      
    cur_behav_1(isnan(cur_behav_1)) = 0;
    cur_behav_2(isnan(cur_behav_2)) = 0;
    % [xcf,lags,bounds] = crosscorr(S1_value,S2_value,'Numlags',200);
%     [xcf,lags,bounds] = crosscorr(cur_mouth_size_1,cur_mouth_size_2,'Numlags',400);
    xcf = xcov(cur_behav_1,cur_behav_2,lags,'coeff');
    xcf_joint_mat_cond(:,cond) = xcf;
%     lag_no(Dyads(dyd_no)) = find(xcf == max(xcf));
%     xcf_mat(Dyads(dyd_no),:) = xcf;

    end
    xcf_joint_mat(Dyads(dyd_no),:) = mean(xcf_joint_mat_cond,2);

end

[h,p] = ttest(mean(cur_corr,2))
%% plot
%% get cond name
subset = @(x) x{1};

cond_name = cellfun(@(x) subset(strsplit(x,'_')),conditions,'UniformOutput',0);
cond_name = strjoin(unique(cond_name),'_');

cond_name = [cond_name '_all_norm'];


figure('units','normalized','outerposition',[0 0 0.3 0.8])
% shows the lags between the smile of the two individuals  
sem = @(x,dim) nanstd( x,0,dim ) / sqrt( size( x,dim ));
yu = nanmean(xcf_joint_mat) + sem(xcf_joint_mat,1);
yl = nanmean(xcf_joint_mat) - sem(xcf_joint_mat,1);
x = 1:length(xcf_joint_mat);
fill([x fliplr(x)], [yu fliplr(yl)], [.9 .9 .9], 'linestyle', 'none')
hold all
plot(nanmean(xcf_joint_mat),'--rs','LineWidth',2)
xline((length(xcf_joint_mat)-1)/2)
yline(0)
title([cond_name '_' behavior '_crosscorr'],'Interpreter','none')
xticks(0:50:2*lags)
xlim([0 2*lags+1])
ylim(mapObj_ylims(behavior))
xticklabels((0:50:2*lags) - lags)
xlabel('lags')
ylabel('corr coeff')
% [h,p] = ttest(lag_no_mouth_joint_pre*0.1,lag_no_mouth_joint_post*0.1)
% saveas(gcf,[analysis_save_dir_figures cond_name '_' behavior '_crosscorr.tif'])
close all

end
