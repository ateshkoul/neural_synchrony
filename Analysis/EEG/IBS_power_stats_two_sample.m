

function [] = IBS_power_stats_two_sample(analysis_type,cor_fun,varargin)

%
% analysis_type = 'no_aggressive_trialwise_CAR';
% analysis_type = 'no_aggressive_ASR_clean_trialwise_CAR';
% analysis_type = 'no_aggressive_ASR_8_clean_trialwise_CAR';

if nargin <1
    analysis_type = 'no_aggressive_trialwise_CAR';
end

if nargin <2
    cor_fun = @IBS_tf_correlations;% IBS_process_tf_connectivity
end



cluster_stats_fname = IBS_get_params_analysis_type(analysis_type).cluster_stats_fname{1,1};
%% cluster based

% if exist(cluster_stats_fname,'file')
%     
%     cur_analysis_type = analysis_type;
%     load(cluster_stats_fname,'stat','anova_cond','analysis_type','test_freq');
%     assert(strcmp(cur_analysis_type,analysis_type) ==1);
%     
% else
    
    [correlations_cell,cond] = cor_fun(analysis_type);
    
    combined_correlations = cat(1,correlations_cell{:});
%     anova_cond = {'FaOcc','FaNoOcc','NeOcc', 'NeNoOcc' };
    test_freq = 1:95;
    anova_cond = {'NeNoOcc' };

    
    
    anova_cond_no = ismember(cond,anova_cond);

    combined_correlations_anova = combined_correlations(:,anova_cond_no);
    levels = [];
    [stat] = IBS_cluster_two_sample(combined_correlations_anova,test_freq,levels','independent');

    
%     save(cluster_stats_fname,'stat','anova_cond','analysis_type','test_freq');
% end

IBS_cluster_plot(stat,cluster_interaction_fname)
close all
%% point wise anova

% analysis_type = 'no_aggressive_trialwise_CAR';
% analysis_type = 'no_aggressive_ASR_clean_trialwise_CAR';
% analysis_type = 'no_aggressive_ASR_8_clean_trialwise_CAR';
%
% save_dir = IBS_get_params_analysis_type(analysis_type).save_dir{1,1};
% save_dir = [save_dir 'figures\\'];
%
% [correlations_cell,cond] = IBS_tf_correlations(analysis_type);
% % [correlations_cell,conditions] = IBS_tf_correlations_trialwise(2);
% combined_correlations = cat(1,correlations_cell{:});
%
% anova_cond = {'FaOcc','FaNoOcc','NeOcc', 'NeNoOcc' };
% % 1st trial of F is main effect of Occ,
% % 2nd trial of F is main effect of Distance,
% pointwise_anova_fname = IBS_get_params_analysis_type(analysis_type).pointwise_anova_fname{1,1};
% if exist(pointwise_anova_fname,'file')
%     cur_analysis_type = analysis_type;
%     load(pointwise_anova_fname,'F','P','anova_cond','analysis_type');
%     assert(strcmp(cur_analysis_type,analysis_type) ==1);
% else
% [F,P] = IBS_pointwise_anova(combined_correlations,cond,anova_cond);
%
% save(pointwise_anova_fname,'F','P','anova_cond','analysis_type');
% end
% % F_limits = [-6 6];
% % correlation_aggressive_ICA_baseline_normchange_0_120s_NoCAR
% plot_type = 'movie_topoplot';
% contrasts = {'F value main Occ','F value main Dist','F value Interaction'};
% cellfun(@(x,y) IBS_plot_correlation_map(x,['corr ' y ' ' analysis_type],plot_type,'F_value',analysis_type,[],save_dir),F.trial,contrasts)
% close all
% cellfun(@(x) IBS_plot_correlation_map(x,'F_value main Occ','movie_topoplot','F_value',analysis_type,F_limits,save_dir),F.trial(1,1))
% cellfun(@(x) IBS_plot_correlation_map(x,'F_value main Dist','movie_topoplot','F_value',analysis_type,F_limits,save_dir),F.trial(1,2))
% cellfun(@(x) IBS_plot_correlation_map(x,'F_value interaction','movie_topoplot','F_value',analysis_type,F_limits,save_dir),F.trial(1,3))
%



end


%%
%% point wise anova

% analysis_type = 'aggressive_trialwise_CAR';
% [correlations_cell,cond] = IBS_tf_correlations(analysis_type);
% % [correlations_cell,conditions] = IBS_tf_correlations_trialwise(2);
% combined_correlations = cat(1,correlations_cell{:});
%
% anova_cond = {'FaOcc','FaNoOcc','NeOcc', 'NeNoOcc' };
% % 1st trial of F is main effect of Occ,
% % 2nd trial of F is main effect of Distance,
% [F,P] = IBS_pointwise_anova(combined_correlations,cond,anova_cond);
%
% % correlation_aggressive_ICA_baseline_normchange_0_120s_NoCAR
% cellfun(@(x) IBS_plot_correlation_map(x,'F value aggr main Occ','movie_topoplot','F_value'),F.trial(1,1))
% cellfun(@(x) IBS_plot_correlation_map(x,'F value aggr main Dist','movie_topoplot','F_value'),F.trial(1,2))
% cellfun(@(x) IBS_plot_correlation_map(x,'F value aggr interaction','movie_topoplot','F_value'),F.trial(1,3))
%
