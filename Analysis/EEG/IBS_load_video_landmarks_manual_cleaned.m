function [data_sub_cond] = IBS_load_video_landmarks_manual_cleaned(Dyad_no,Sub_no,condition,raw_data_dir,label)
%IBS_LOAD_VIDEO_LANDMARKS_MANUAL_CLEANED load openpose landmarks cleaned
%
% SYNOPSIS: IBS_load_video_landmarks_manual_cleaned
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
% DATE: 29-Mar-2021
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin <4
    label = 'ALL';
    raw_data_dir = 'Y:\\Inter-brain synchrony\\Results\\Video\\3_Grouped\\';
end


if nargin <5
    
    
    label = 'ALL';
end

mapObj = containers.Map({'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3', ...
    'FaOcc_1','FaOcc_2','FaOcc_3', ...
    'NeNoOcc_1','NeNoOcc_2','NeNoOcc_3', ...
    'NeOcc_1','NeOcc_2','NeOcc_3', ...
    'Task_1','Task_2','Task_3'},1:15);


data = load([raw_data_dir sprintf('Dyad_%0.2d',Dyad_no)]);


switch(Sub_no)
    
    case 0
        label_row = strcmp(data.data_0_all.label  ,label);
        data_sub_cond = data.data_0_all.trial{1,mapObj(condition)}(label_row,:)';
        
        data_sub_cond = table(data_sub_cond,'VariableNames',{label});
    case 1
        label_row = strcmp(data.data_1_all.label  ,label);
        data_sub_cond = data.data_1_all.trial{1,mapObj(condition)}(label_row,:)';
        data_sub_cond = table(data_sub_cond,'VariableNames',{label});
end
end












