function output = IBS_compute_sudden_changes(data_vector,minWindowLength,output_type)
%IBS_COMPUTE_SUDDEN_CHANGES function to compute sudden sustained changes
%
% SYNOPSIS: IBS_compute_sudden_changes
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
% DATE: 23-Apr-2021
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin <3
    output_type = 'high_mean_segments';
end


% data_change_pts = findchangepts(data_vector,'Statistic','mean','MinThreshold',nanmean(data_vector));
% using nanmean as threshold does have some sense - not sure what that is
% though (26-04-2021)
% 29-04-2022: in cases where the data is missing. not sure if this is a
% good idea but it's a quick hack
if sum(isnan(data_vector))>0
if sum(isnan(data_vector)) == length(data_vector)
else
    data_vector(isnan(data_vector)) = [];
end
end

try
    data_change_pts = findchangepts(data_vector,'Statistic','mean','MinThreshold',nanmean(data_vector));
catch
    data_change_pts = length(data_vector);
end
% data_change_pts = findchangepts(data_vector,'Statistic','mean','MinThreshold',100);

data_segments = unique([1 data_change_pts' length(data_vector)]);

% compute average of all the segments
avg_data_segment = arrayfun(@(x,y) mean(data_vector(x:x+y)),data_segments(1:end-1),diff(data_segments));
% arrayfun(@(x,y) behav_data.mouth_size(x+y) - behav_data.mouth_size(x),s(1:end-1),diff(s))

all_segment_starts = arrayfun(@(x,y) data_segments(x:x+1),1:length(data_segments)-1,'UniformOutput',false);

select_decrease = find(diff(avg_data_segment)<0);
select_increase = find(diff(avg_data_segment)>=0);


s = [all_segment_starts(select_increase+1) all_segment_starts(select_decrease)];
unique_indicies = unique(cat(1,s{:}),'rows');

high_mean_segments = arrayfun(@(x,y) unique_indicies(x,1):unique_indicies(x,2),1:size(unique_indicies,1),'UniformOutput',false);

high_mean_segments_lengths = cell2mat(cellfun(@(x) size(x,2),high_mean_segments,'UniformOutput',false));
% this ensures changes less than a window size are ignored
% windowLength = 100;
high_mean_segments(high_mean_segments_lengths<minWindowLength) = [];

high_mean_segments = cat(2,high_mean_segments{:});

switch(output_type)
    case 'high_mean_segments'
        output = high_mean_segments;
    case 'all'
        output = table();
        output = addvars(output,{data_change_pts(select_decrease)},{data_change_pts(select_increase)},...
            'NewVariableNames',{'decrease','increase'});
    case 'changepoints'
        output = length(select_decrease) + length(select_increase);
end




end


%
%
% all_select_indices = [data_change_pts(select_decrease)' data_change_pts(select_increase)'];
% p = diff([0 diff(avg_data_segment)>0]);
% data_change_pts = [1 data_change_pts' ];




