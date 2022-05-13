function [stat_clusters] = IBS_get_stat_cluster(data_analysis_type,analysis)
%% Atesh Koul
% 04-02-2021


% load('test_sig_cluster_no_aggressive_trialwise_CAR.mat')
if nargin <2
    
    analysis = 'Power_correlation_analysis';
end



mapObj = containers.Map({'Brain_behavior_glm_power_freqwise','Power_correlation_analysis','Power_correlation_analysis_freqwise',...
    'Brain_behavior_glm_power_all_freq','Dyad_classification_sex','Dyad_classification_smile','Brain_behav_physio_SEM_freqwise'},...
    {'Power_correlation_analysis','Power_correlation_analysis','Power_correlation_analysis','Power_correlation_analysis',...
    'Power_correlation_analysis','Power_correlation_analysis','Power_correlation_analysis'});

cluster_analysis_type = mapObj(analysis);


varargin_table = table();
varargin_table.measure = 'corr';
varargin_table.plot_type = 'no';
cor_fun = @IBS_tf_correlations;

if contains(analysis,'freqwise')
    
    [stat_main_effects,stat_interaction] = IBS_power_stats_freqwise(data_analysis_type,cluster_analysis_type,cor_fun,varargin_table);
else
    [stat_main_effects,stat_interaction] = IBS_power_stats(data_analysis_type,cluster_analysis_type,cor_fun,varargin_table);
    
end





%% choose which cluster/subcluster to choose

% choose the beta posterior cluster

[stat_clusters] = IBS_select_stat_subclusters(data_analysis_type,analysis,stat_main_effects{1,2},stat_interaction);



% stat_main_effects{1,2}.posclusterslabelmat(stat_main_effects{1,2}.posclusterslabelmat==0) = nan;
% stat_main_effects{1,2}.posclusterslabelmat(stat_main_effects{1,2}.posclusterslabelmat==2) = nan;
% stat_main_effects{1,2}.posclusterslabelmat(stat_main_effects{1,2}.posclusterslabelmat==3) = nan;
% stat_clusters = stat_main_effects{1,2}.posclusterslabelmat;


end