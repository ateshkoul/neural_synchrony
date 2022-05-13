function [cond_correlation_coeff,cond_correlation_coeff_table] = IBS_replicate_video_mov_synch(Dyad_no,condition)
%IBS_REPLICATE_VIDEO_MOV_SYNCH
%
% SYNOPSIS: IBS_replicate_video_mov_synch
%
% INPUT function to replicate the synch on body movement data (from Davide)
%
% OUTPUT
%
% REMARKS
%
% created with MATLAB ver.: 9.8.0.1359463 (R2020a) Update 1 on Microsoft Windows 10 Pro Version 10.0 (Build 19042)
%
% created by: Atesh
% DATE: 17-01-2022
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

raw_data_dir = 'D:\\iannettilab_dropbox\\Dropbox\\Koul_Atesh\\IBS\\';
varargin_table = table();
varargin_table.behav_analysis = 'joint';
varargin_table.analysis_sub_type = '_insta_abs_detrend';
% Dyad_no = 14;
% Sub_no = 0;
% condition = 'FaNoOcc_1';
% body_part = 'Torso';

% body_parts = {'Head','Torso','Left_Shoulder','Left_Elbow','Left_Wrist',...
%     'Left_Knee','Left_Feet','Right_Shoulder','Right_Elbow','Right_Wrist','Right_Knee','Right_Feet'};

body_parts = {'Head','Torso','Arms','Legs','Feet'};


% video_table = table({'Nose','REye','LEye','REar','LEar'},...
%     {'Neck','MidHip','RHip','LHip'},...
%     {'LShoulder'}, {'LElbow'}, {'LWrist'},{ 'LKnee'},{ 'LAnkle','LBigToe','LSmallToe','LHeel'},...
%     {'RShoulder'},{ 'RElbow'},{ 'RWrist'},{'RKnee'},{ 'RAnkle','RBigToe','RSmallToe', 'RHeel'},...
%     'VariableNames',{'Head','Torso','Left_Shoulder','Left_Elbow','Left_Wrist',...
%     'Left_Knee','Left_Feet','Right_Shoulder','Right_Elbow','Right_Wrist','Right_Knee','Right_Feet'});

video_table = table({'Nose','REye','LEye','REar','LEar'},...
    {'Neck','MidHip','RHip','LHip'},...
    {'LShoulder', 'LElbow', 'LWrist','RShoulder', 'RElbow', 'RWrist'},...
    {'LKnee','LAnkle','RKnee','RAnkle'},...
    {'LBigToe','LSmallToe','LHeel','RBigToe','RSmallToe', 'RHeel'},...
    'VariableNames',{'Head','Torso','Arms','Legs','Feet'});



%%

video_cam_0=cellfun(@(bodypart) IBS_get_all_video_data(bodypart,video_table,Dyad_no,0,...
    condition,raw_data_dir,varargin_table),body_parts,'UniformOutput',0);

video_cam_1=cellfun(@(bodypart) IBS_get_all_video_data(bodypart,video_table,Dyad_no,1,...
    condition,raw_data_dir,varargin_table),body_parts,'UniformOutput',0);

video_cam_0 = cat(2,video_cam_0{:});
video_cam_1 = cat(2,video_cam_1{:});

% alternate (but less safe) way
% arrayfun(@(sub_col) nancorr(video_cam_0{:,sub_col},video_cam_1{:,sub_col}),...
%     2:13,'UniformOutput',0)

% necessary to have {} because this is equivalent to doing table2array
cond_correlation_coeff = corr(video_cam_0{:,1:5},video_cam_1{:,1:5},'type','Pearson');
cond_correlation_coeff = (cond_correlation_coeff+cond_correlation_coeff')./2;


cond_correlation_coeff_table = array2table((cond_correlation_coeff+cond_correlation_coeff')./2,'VariableNames',body_parts);
%% old way
% cond_correlation_coeff_homolog = cell2mat(cellfun(@(body_part) nancorr(video_cam_0{:,contains(video_cam_0.Properties.VariableNames,body_part)},...
%     video_cam_1{:,contains(video_cam_1.Properties.VariableNames,body_part)}),...
%     body_parts,'UniformOutput',0));
% 
% homolog_variable_names = join(repmat(body_parts,2,1),'_',1);
% cond_correlation_coeff_homolog = array2table(cond_correlation_coeff_homolog,'VariableNames',homolog_variable_names);
% 
% 
% body_part_comb = combnk(body_parts,2);
% cond_correlation_coeff_comb = cell2mat(arrayfun(@(body_part_comb_no) nancorr(...
%     video_cam_0{:,contains(video_cam_0.Properties.VariableNames,body_part_comb{body_part_comb_no,1})},...
%     video_cam_1{:,contains(video_cam_1.Properties.VariableNames,body_part_comb{body_part_comb_no,2})}),...
%     1:length(body_part_comb),'UniformOutput',0));
% 
% comb_variable_names = join(body_part_comb,'_',2);
% 
% 
% cond_correlation_coeff_comb = array2table(cond_correlation_coeff_comb,'VariableNames',comb_variable_names);
% 
% cond_correlation_coeff = [cond_correlation_coeff_homolog cond_correlation_coeff_comb ];
end


function bodypart_data_interp_table = IBS_get_all_video_data(body_part,video_table,Dyad_no,Sub_no,condition,raw_data_dir,varargin_table)
varargin_table.labels = video_table.(body_part);

bodypart_data_interp_table = IBS_get_sub_behavior_data('video_openpose_landmarks_manual_cleaned',...
    Dyad_no,Sub_no,condition,raw_data_dir,varargin_table);

bodypart_data_interp_table = renamevars(bodypart_data_interp_table,['ALL_' num2str(Sub_no)],[body_part '_' num2str(Sub_no)]);

bodypart_data_interp_table = removevars(bodypart_data_interp_table,{['timestamps_' num2str(Sub_no)]});
%% old way - to be consistent with Davide analysis (and to avoid nan)
% bodypart_data_interp = interp1(bodypart_data_table.(['timestamps_' num2str(Sub_no)]),...
%     bodypart_data_table.(['ALL_' num2str(Sub_no)]),0:0.1:120);

% don't need this info here
% if strcmp(body_part,'Head')
%     
%     bodypart_data_interp_table = array2table([0:0.1:120;bodypart_data_interp]',...
%     'VariableNames',{['timestamps_' num2str(Sub_no)],[body_part '_' num2str(Sub_no)]});
%     
% else
%     bodypart_data_interp_table = array2table(bodypart_data_interp',...
%     'VariableNames',{[body_part '_' num2str(Sub_no)]});
%     
% end

% bodypart_data_table = renamevars(bodypart_data,['ALL_' num2str(Sub_no)],[body_part '_' num2str(Sub_no)]);
% 
% 
% if ~strcmp(body_part,'Head')
%     bodypart_data = removevars(bodypart_data,{['timestamps_' num2str(Sub_no)]});
% else
%     bodypart_data = movevars(bodypart_data,[body_part '_' num2str(Sub_no)],'After',['timestamps_' num2str(Sub_no)]);
%     
% end

end


