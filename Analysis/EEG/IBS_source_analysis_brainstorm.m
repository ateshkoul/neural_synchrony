data_to_plot = stat_main_effects{1, 2}.stat(:,[10 13]).*stat_main_effects{1, 2}.mask(:,[10 13]);
data_to_plot(:,3) = stat_interaction.stat(:,7).*stat_interaction.mask(:,7);
template_ft = IBS_template_ft_brainstorm(data_to_plot);
save('main_effects_interaction_ASR_10_brainstorm_zeros.mat','template_ft')


analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
analysis_type_params = IBS_get_params_analysis_type(analysis_type);
data_dir = analysis_type_params.data_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
data = IBS_load_clean_IBS_data(1,analysis_type,data_dir);


arrayfun(@(x) save(['test_Dyad_' num2str(x) 'S1_blocks.mat'],data.data_ica_clean_S1{1,x}),1:3,'UniformOutput',0)

cur_data = data.data_ica_clean_S1{1,2};
cur_data.label = lay.label;
save('test_Dyad_1_S1','cur_data')


