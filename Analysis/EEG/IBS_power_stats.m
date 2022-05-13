

function [stat_main_effects,stat_interaction] = IBS_power_stats(data_analysis_type,analysis,cor_fun,varargin_table)

% https://www.fieldtriptoolbox.org/tutorial/cluster_permutation_timelock/#the-format-of-the-output
% analysis_type = 'no_aggressive_trialwise_CAR';
% analysis_type = 'no_aggressive_ASR_clean_trialwise_CAR';
% analysis_type = 'no_aggressive_ASR_8_clean_trialwise_CAR';

if nargin <1
    data_analysis_type = 'no_aggressive_trialwise_CAR';
end

if nargin <2
    analysis = 'Power_correlation_analysis';
varargin_table = table();
varargin_table.measure = 'corr';
end

if nargin <3 || isempty(cor_fun)
    cor_fun = @IBS_tf_correlations;% IBS_process_tf_connectivity

end


try
    plot_type = varargin_table.plot_type;
catch
    
    varargin_table.plot_type = 'topoplots';
end


cur_func_params = {'plot_type','measure'};


varargin_cell = table2cell(removevars(varargin_table,cur_func_params));
cluster_main_effects_fname = IBS_get_params_analysis_type(data_analysis_type,analysis).cluster_main_effects_fname{1,1};

cluster_interaction_fname = IBS_get_params_analysis_type(data_analysis_type,analysis).cluster_interaction_fname{1,1};

cluster_stats_fname = IBS_get_params_analysis_type(data_analysis_type,analysis).cluster_stats_fname{1,1};

%%
cluster_stats_fname = IBS_update_stat_fname(cluster_stats_fname,data_analysis_type,cor_fun,varargin_table);
cluster_interaction_fname = IBS_update_stat_fname(cluster_interaction_fname,data_analysis_type,cor_fun,varargin_table);
cluster_main_effects_fname = IBS_update_stat_fname(cluster_main_effects_fname,data_analysis_type,cor_fun,varargin_table);

%% cluster based

if exist(cluster_stats_fname,'file')
    
    cur_analysis_type = data_analysis_type;
    load(cluster_stats_fname,'stat_main_effects','stat_interaction','anova_cond','data_analysis_type','analysis','cor_fun','test_freq','f_name');
    assert(strcmp(cur_analysis_type,data_analysis_type) ==1);
    
else
    
    [correlations_cell,cond,f_name] = cor_fun(data_analysis_type,varargin_cell{:});
    
    combined_correlations = cat(1,correlations_cell{:});
    anova_cond = {'FaOcc','FaNoOcc','NeOcc', 'NeNoOcc' };
    cond_nos = [1,2];
    test_freq = 1:95;
    levels = [1 1 2 2;1 2 1 2];
    [stat_main_effects,stat_interaction] = IBS_cluster_anova(combined_correlations,cond,anova_cond,cond_nos,test_freq,levels);
    
    save(cluster_stats_fname,'stat_main_effects','stat_interaction','anova_cond','data_analysis_type','analysis','test_freq','f_name','cor_fun');
end
cellfun(@(x,y) IBS_cluster_plot(x,y,[],varargin_table.plot_type),stat_main_effects,cluster_main_effects_fname)

IBS_cluster_plot(stat_interaction,cluster_interaction_fname,[],varargin_table.plot_type)
close all
%% point wise anova

% analysis_type = 'no_aggressive_trialwise_CAR';
% analysis_type = 'no_aggressive_ASR_clean_trialwise_CAR';
% analysis_type = 'no_aggressive_ASR_8_clean_trialwise_CAR';

% save_dir = IBS_get_params_analysis_type(data_analysis_type).save_dir{1,1};
% save_dir = [save_dir 'figures\\'];

% [correlations_cell,cond] = IBS_tf_correlations(data_analysis_type);

% [correlations_cell,conditions] = IBS_tf_correlations_trialwise(2);
% combined_correlations = cat(1,correlations_cell{:});

% anova_cond = {'FaOcc','FaNoOcc','NeOcc', 'NeNoOcc' };
% 1st trial of F is main effect of Occ,
% 2nd trial of F is main effect of Distance,
% pointwise_anova_fname = IBS_get_params_analysis_type(data_analysis_type).pointwise_anova_fname{1,1};
% if exist(pointwise_anova_fname,'file')
%     cur_analysis_type = data_analysis_type;
%     load(pointwise_anova_fname,'F','P','anova_cond','data_analysis_type');
%     assert(strcmp(cur_analysis_type,analysis_type) ==1);
% else
% [F,P] = IBS_pointwise_anova(combined_correlations,cond,anova_cond);
% 
% save(pointwise_anova_fname,'F','P','anova_cond','data_analysis_type');
% end
% F_limits = [-6 6];
% correlation_aggressive_ICA_baseline_normchange_0_120s_NoCAR
% plot_type = 'images';
% contrasts = {'F value main Occ','F value main Dist','F value Interaction'};
% cellfun(@(x,y) IBS_plot_correlation_map(x,['corr ' y ' ' data_analysis_type],plot_type,'F_value',data_analysis_type,[],save_dir),F.trial,contrasts)
% close all
% cellfun(@(x) IBS_plot_correlation_map(x,'F_value main Occ','movie_topoplot','F_value',data_analysis_type,F_limits,save_dir),F.trial(1,1))
% cellfun(@(x) IBS_plot_correlation_map(x,'F_value main Dist','movie_topoplot','F_value',data_analysis_type,F_limits,save_dir),F.trial(1,2))
% cellfun(@(x) IBS_plot_correlation_map(x,'F_value interaction','movie_topoplot','F_value',data_analysis_type,F_limits,save_dir),F.trial(1,3))
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
