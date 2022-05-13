function IBS_estimate_mov_outliers
%IBS_ESTIMATE_MOV_OUTLIERS 
%
% SYNOPSIS: IBS_estimate_mov_outliers
%
% INPUT estimate the outlier values and zero values in behavior movement data
%
% OUTPUT 
%
% REMARKS
%
% created with MATLAB ver.: 9.8.0.1359463 (R2020a) Update 1 on Microsoft Windows 10 Pro Version 10.0 (Build 19042)
%
% created by: Atesh
% DATE: 30-Aug-2021
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[cur_body_part_zero,cur_body_part_out] = DAV_outlier_estimation();

mean(cur_body_part_out(:))*100
mean(cur_body_part_zero(:))*100

