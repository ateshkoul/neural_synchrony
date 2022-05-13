function [sub_avg_behav,frac_AND] = IBS_estimate_behav_distribution(behavior)
%IBS_ESTIMATE_BEHAV_DISTRIBUTION 
%
% SYNOPSIS: IBS_estimate_behav_distribution
%
% INPUT behavior, data_analysis_type,
%
% OUTPUT 
%
% REMARKS
%
% created with MATLAB ver.: 9.8.0.1359463 (R2020a) Update 1 on Microsoft Windows 10 Pro Version 10.0 (Build 19042)
%
% created by: Atesh
% DATE: 19-Aug-2021
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% behavior = 'video_openpose_landmarks_manual_cleaned';
data_analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
analysis = 'Brain_behavior_glm_power_freqwise';
conditions = {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3',};
analysis_sub_type = '_insta_abs_corr_avg_freqwise';
% behaviors = {'Smile_auto'};
analysis_sub_type = '_insta_abs_corr_avg_freqwise';
% analysis_sub_type = '_insta_abs_no_detrend_behav_corr_avg_freqwise';

behav_analysis = 'joint';
output_data = 'all';
behavior_joint = IBS_load_behavior_data(behavior,data_analysis_type,1,conditions,behav_analysis,analysis_sub_type,output_data);


figure;
plot(table2array(behavior_joint{1,1}{1,1}(:,1)))
hold on
plot(table2array(behavior_joint{1,2}{1,1}(:,1)))
plot(table2array(behavior_joint{1,3}{1,1}(:,1)))
xlim([0 100])
ylim([-3 12])
title(analysis_sub_type,'Interpreter','none')


behav_analysis = 'joint_AND';
output_data = 'all';
behavior_data_AND = IBS_load_behavior_data(behavior,data_analysis_type,1:23,conditions,behav_analysis,analysis_sub_type,output_data);


cur_behav_fraction_AND = cellfun(@(x) cell2mat(cellfun(@(sub) nansum(table2array(sub(:,1)))/7206,...
    x,'UniformOutput',0)),behavior_data_AND,'UniformOutput',0);



cur_behav_fraction_AND = cat(1,cur_behav_fraction_AND{:});
cur_behav_fraction_AND_joint = cur_behav_fraction_AND(3,:);

% behav_analysis = 'joint_XOR';
% output_data = 'all';
% behavior_data_XOR = IBS_load_behavior_data(behavior,data_analysis_type,1:23,conditions,behav_analysis,analysis_sub_type,output_data);
% 
% cur_behav_fraction_XOR = cellfun(@(x) cell2mat(cellfun(@(sub) nansum(table2array(sub(:,1)))/7206,...
%     x,'UniformOutput',0)),behavior_data_XOR,'UniformOutput',0);
% 
% cur_behav_fraction_XOR = cat(1,cur_behav_fraction_XOR{:});
% cur_behav_fraction_XOR_joint = cur_behav_fraction_XOR(3,:);



sub_avg_behav = mean(cur_behav_fraction_AND(1:2,:));
frac_AND = cur_behav_fraction_AND(3,:)./sub_avg_behav;
% sub_avg_behav.*frac_AND;
% 
%  bar(mean([sub_avg_behav;sub_avg_behav.*frac_AND],2))
% 
% 
% behav_fraction = [cur_behav_fraction_AND_joint;cur_behav_fraction_XOR_joint];
% behav_fraction = behav_fraction';
% figure;
% sem = @(x,dim) nanstd( x,0,dim ) / sqrt( size( x,dim ));
% bar(mean(behav_fraction))
% hold on
% errorbar(mean(behav_fraction),sem(behav_fraction,1),'k','linestyle','none')

%%

% 
% cur_behav_area_AND = cellfun(@(x) cell2mat(cellfun(@(sub) trapz(table2array(sub(:,1))),...
%     x,'UniformOutput',0)),behavior_data_AND,'UniformOutput',0);
% 
% 
% cur_behav_area_AND = cat(1,cur_behav_area_AND{:});
% cur_behav_area_AND_joint = cur_behav_area_AND(3,:);
% 
% 
% cur_behav_area_XOR = cellfun(@(x) cell2mat(cellfun(@(sub) trapz(table2array(sub(:,1))),...
%     x,'UniformOutput',0)),behavior_data_XOR,'UniformOutput',0);
% 
% cur_behav_area_XOR = cat(1,cur_behav_area_XOR{:});
% cur_behav_area_XOR_joint = cur_behav_area_XOR(3,:);
% 
% 
% behav_area = [cur_behav_area_AND_joint;cur_behav_area_XOR_joint];
% behav_area = behav_area';
% figure;
% sem = @(x,dim) nanstd( x,0,dim ) / sqrt( size( x,dim ));
% bar(mean(behav_area))
% hold on
% errorbar(mean(behav_area),sem(behav_area,1),'k','linestyle','none')
end