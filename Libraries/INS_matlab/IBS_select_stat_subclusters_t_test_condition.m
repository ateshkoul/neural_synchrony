function [clusters] = IBS_select_stat_subclusters_t_test_condition(data_analysis_type,analysis,stats,cond_test)
%IBS_SELECT_STAT_SUBCLUSTERS_T_TEST_CONDITION function to select clusters from stats file from permutation test
%
% SYNOPSIS: IBS_select_stat_subclusters_t_test_condition
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
% DATE: 18-Jun-2021
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
switch(cond_test)
    case 'Task'
        % cluster 1
        cluster_1_freq_col = 7:8; % alpha
        cluster_1 = nan(size(stats.mask));
        cluster_1(:,cluster_1_freq_col) = stats.posclusterslabelmat(:,cluster_1_freq_col)==2;
        cluster_1(cluster_1==0) = nan;
        
        % cluster 2
        cluster_2_freq_col = 7:8; % alpha
        cluster_2 = nan(size(stats.mask));
        cluster_2(:,cluster_2_freq_col) = stats.posclusterslabelmat(:,cluster_2_freq_col)==3;
        cluster_2(cluster_2==0) = nan;
        
           % cluster 2
        cluster_3_freq_col = 11; % beta
        cluster_3 = nan(size(stats.mask));
        cluster_3(:,cluster_3_freq_col) = stats.posclusterslabelmat(:,cluster_3_freq_col)==4;
        cluster_3(cluster_3==0) = nan;
        
        cluster_4_freq_col = 12:14; % gamma
        cluster_4 = nan(size(stats.mask));
        cluster_4(:,cluster_4_freq_col) = stats.posclusterslabelmat(:,cluster_4_freq_col)==1;
        cluster_4(cluster_4==0) = nan;
        
        
        
        clusters = {cluster_1 cluster_2 cluster_3 cluster_4};
        
end