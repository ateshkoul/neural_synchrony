function [corresp_frames] = IBS_eye_tracker_load_corresp_frames(Dyad_no,condition,raw_data_dir)
%IBS_EYE_TRACKER_LOAD_CORRESP_FRAMES
%
% SYNOPSIS: [corresp_frames] = IBS_eye_tracker_load_corresp_frames()
%
% INPUT a
%
% OUTPUT a
%
% REMARKS
%
% created with MATLAB ver.: 9.8.0.1359463 (R2020a) Update 1 on Microsoft Windows 10 Pro Version 10.0 (Build 19042)
%
% created by: Atesh
% DATE: 18-Mar-2021
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin <3
    raw_data_dir = 'D:\\iannettilab_dropbox\\Dropbox\\Koul_Atesh\\IBS\\';
end
% Sub is always 1 (that's the way it's saved) also because sub 1 has more
% frames (mostly?)
behavior = 'Eye_tracker';
sub_dir = IBS_get_sub_behavior_dir(behavior,Dyad_no,1,condition);
sub_dir = [raw_data_dir sub_dir];
corresp_frames = IBS_eye_tracker_import_corresp_frames([sub_dir '\\corresp_frames.json']);
