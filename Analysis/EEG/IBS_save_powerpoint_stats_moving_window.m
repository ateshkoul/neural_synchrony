
function ppt = IBS_save_powerpoint_stats_moving_window(analysis_types,ppt,select_string,cor_fun,varargin_table)

analysis = 'Moving_window';
anova_conditions = {'main_effects_Occ','main_effects_Dist','interaction'};
% cluster_plot_IBS_save_dyad_tf_moving_corr_5_window_1_95_interaction_no_aggressive_trialwise_CAR__F_value_images_all_dyads
for i = 1:numel(select_string)

select_string_main = [select_string{i} '_' func2str(cor_fun)];

for j = 1:numel(analysis_types)
save_dir = IBS_get_params_analysis_type(analysis_types{j},analysis).analysis_save_dir_figures{1,1};

IBS_powerpoint_plots_moving_window(ppt,save_dir,select_string_main,analysis_types{j},anova_conditions);


end


end