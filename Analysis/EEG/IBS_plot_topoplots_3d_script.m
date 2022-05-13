
data_analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
analysis = 'Power_correlation_analysis';
varargin_table = table();
varargin_table.measure = 'corr';
varargin_table.plot_type = 'no';
cor_fun = @IBS_tf_correlations;

[stat_main_effects,stat_interaction,cluster_stats_freqwise_fname] = IBS_power_stats_freqwise(data_analysis_type,analysis,cor_fun,varargin_table);

%%
data_to_plot = stat_main_effects{1, 2}.stat(:,[10 13]).*stat_main_effects{1, 2}.mask(:,[10 13]);
data_to_plot(:,3) = stat_interaction.stat(:,7).*stat_interaction.mask(:,7);
template_ft = IBS_template_ft_brainstorm(data_to_plot);
save('main_effects_interaction_ASR_10_brainstorm_zeros.mat','template_ft')
%%
data_to_plot = stat_main_effects{1, 2}.stat(:,[10 13]).*stat_main_effects{1, 2}.mask(:,[10 13]);
template_ft = IBS_template_ft_brainstorm(data_to_plot);
save('main_effects_Occ_ASR_10_brainstorm.mat','template_ft')

data_to_plot = stat_interaction.stat(:,7).*stat_interaction.mask(:,7);
template_ft = IBS_template_ft_brainstorm(data_to_plot);
save('interaction_ASR_10_brainstorm_zeros.mat','template_ft')
%%

analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';


[correlations,conditions]= IBS_tf_correlations(analysis_type);

freq_type = 'freqwise';
data_type = 'mean';
[~,mean_pwr_correlation] = IBS_process_pwr_correlations(correlations,data_type,analysis_type,freq_type);

data_to_plot = cat(3,mean_pwr_correlation{1,2:5});
data_to_plot = squeeze(data_to_plot(:,13,:));

data_to_plot(:,5) = (data_to_plot(:,2) + data_to_plot(:,4))-(data_to_plot(:,1) + data_to_plot(:,3));
template_ft = IBS_template_ft_brainstorm(data_to_plot);
save('individual_cond_corr_FaOcc_FaNoOcc_NeOcc_NeNoOcc_main_effect_Occ.mat','template_ft')
%%
varargin_table = table();


[root_dir,f_name] = fileparts(cluster_stats_freqwise_fname);
limits = [-6 6];
%%
varargin_table.data_col = 13;
title = ['main_effects_52_Hz_view_1'];
varargin_table.selChans = {find(stat_main_effects{1, 2}.mask(:,varargin_table.data_col)>0)};
data = stat_main_effects{1, 2}.stat;

IBS_plot_correlation_map(data,title,'topoplot_3d','F_value',data_analysis_type,limits,root_dir,varargin_table)
%%
varargin_table.data_col = 13;
varargin_table.view_angle = [360-62 15];
varargin_table.selChans = {find(stat_main_effects{1, 2}.mask(:,varargin_table.data_col)>0)};
data = stat_main_effects{1, 2}.stat;

title = ['main_effects_52_Hz_view_2'];

IBS_plot_correlation_map(data,title,'topoplot_3d','F_value',data_analysis_type,limits,root_dir,varargin_table)
%%
varargin_table.data_col = 10;
varargin_table.view_angle = [62 15];
varargin_table.selChans = {find(stat_main_effects{1, 2}.mask(:,varargin_table.data_col)>0)};
data = stat_main_effects{1, 2}.stat;

title = ['main_effects_19_Hz_view_1'];
IBS_plot_correlation_map(data,title,'topoplot_3d','F_value',data_analysis_type,limits,root_dir,varargin_table)


%%
varargin_table.data_col = 10;
varargin_table.view_angle = [360-62 15];
varargin_table.selChans = {find(stat_main_effects{1, 2}.mask(:,varargin_table.data_col)>0)};
data = stat_main_effects{1, 2}.stat;

title = ['main_effects_19_Hz_view_2'];
IBS_plot_correlation_map(data,title,'topoplot_3d','F_value',data_analysis_type,limits,root_dir,varargin_table)
%%
varargin_table.data_col = 7;
varargin_table.view_angle = [62 15];
varargin_table.selChans = {find(stat_interaction.mask(:,varargin_table.data_col)>0)};
data = stat_interaction.stat;

title = ['interaction_10_Hz_view_1'];
IBS_plot_correlation_map(data,title,'topoplot_3d','F_value',data_analysis_type,limits,root_dir,varargin_table)
%%
varargin_table.data_col = 7;
varargin_table.view_angle = [280 20];
varargin_table.selChans = {find(stat_interaction.mask(:,varargin_table.data_col)>0)};
data = stat_interaction.stat;

title = ['interaction_10_Hz_view_2'];
IBS_plot_correlation_map(data,title,'topoplot_3d','F_value',data_analysis_type,limits,root_dir,varargin_table)
%%
close all













