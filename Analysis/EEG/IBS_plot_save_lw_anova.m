function IBS_plot_save_lw_anova(analysis_type)

analysis_type_params = IBS_get_params_analysis_type(analysis_type);
within_save_dir = analysis_type_params.within_save_dir{1,1};
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




% switch analysis_type
%     
%     case 'no_aggressive'
%         lw_anova_fname = 'anova_F_values_Occ_Dist_2x2';
%         data_dir = 'E:\\Projects\\IBS\\Data\\Processed\\no_aggressive\\fft_lw_120\\';
%         F_value = load([data_dir lw_anova_fname]);
%         contrasts = {'F_value main Occ','F_value main Dist','F_value Interaction'};
%         F_value = squeeze(F_value.data);
%         freq = repmat(1:95,[2 1]);
%         frequencies = table(freq(:),'VariableNames',{'freq'});
%         
% end

