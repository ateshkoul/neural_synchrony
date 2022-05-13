function cur_timestamps = IBS_import_video_timestamps(Sub_no,condition,sub_dir)
%IBS_IMPORT_VIDEO_TIMESTAMPS timestamps for video analysis
%
% SYNOPSIS: IBS_import_video_timestamps
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
timestamp_data = jsondecode(fileread([sub_dir '\\timestamp_' condition '.json']));
timestamp_data = struct2table(timestamp_data);

initial_time = timestamp_data{1,1};

cur_timestamps = timestamp_data(1,contains(timestamp_data.Properties.VariableNames,['x' num2str(Sub_no) '_timestamp']));
cur_timestamps = table2array(cur_timestamps)-initial_time;

end

