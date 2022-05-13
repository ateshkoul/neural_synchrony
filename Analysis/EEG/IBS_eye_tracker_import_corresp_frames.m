function [corresp_frames] = IBS_eye_tracker_import_corresp_frames(filename,field_name)
%IBS_EYE_TRACKER_IMPORT_CORRESP_FRAMES
%
% SYNOPSIS: IBS_eye_tracker_import_corresp_frames
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
% DATE: 18-Mar-2021
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin <2
    field_name = 'equal_frames';
end
jsonData = jsondecode(fileread(filename));
corresp_frames = jsonData.(field_name);