function IBS_monkey_plot_save_lw_anova(analysis_type,analysis)
%% Atesh Koul
analysis_type_params = IBS_monkey_get_params_analysis_type(analysis_type,analysis);
within_save_dir = analysis_type_params.analysis_save_dir{1,1};
lw_anova_fname = analysis_type_params.lw_anova_fname{1,1};
contrasts = analysis_type_params.contrasts;

F_value = load([within_save_dir lw_anova_fname]);


F_value = squeeze(F_value.data);
freq = repmat(1:95,[2 1]);
vidFrameRate = 1;
varargout_table = table();
varargout_table = addvars(varargout_table,{freq(:)},'NewVariableNames',{'freq'});
varargout_table = addvars(varargout_table,vidFrameRate);

within_save_dir = [within_save_dir 'figures\\'];

plot_type = 'movie_topoplot';
% plot_type = 'topoplot';
F_limits = [-10 10];
data_type = 'F_value'; % p_value
arrayfun(@(x) IBS_plot_correlation_map(squeeze(F_value(:,x,:)),[contrasts{x} ' ' analysis_type],plot_type,data_type,analysis_type,F_limits,within_save_dir,varargout_table),1:3)

end