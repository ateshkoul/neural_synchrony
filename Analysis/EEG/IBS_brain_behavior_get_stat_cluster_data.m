function [brain_stat_data] = IBS_brain_behavior_get_stat_cluster_data(data_analysis_type,analysis,brain_data)
%% Atesh Koul
% 16-03-2021

stat_cluster = IBS_get_stat_cluster(data_analysis_type,analysis);
brain_data = permute(brain_data,[1 3 2]);
[brain_stat_data] = cellfun(@(x) normalize(squeeze(nanmean(nanmean(brain_data.*repmat(x,1,1,size(brain_data,3))))),'zscore'),...
    stat_cluster,'UniformOutput',false);


end