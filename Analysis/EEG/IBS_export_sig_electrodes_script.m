 
analysis = 'Power_correlation_analysis';
data_analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
varargin_table = table();
varargin_table.plot_type = 'no';
varargin_table.measure = 'corr';
cor_fun = @IBS_tf_correlations;
[stat_main_effects,stat_interaction] = IBS_power_stats_freqwise(data_analysis_type,analysis,cor_fun,varargin_table);



% [sig_rows,sig_c] = find(stat_main_effects{1, 2}.mask);
[sig_rows,sig_c,t_value] = find(stat_main_effects{1, 2}.stat.* stat_main_effects{1, 2}.mask)

sig_mat = [sig_rows sig_c t_value];
sig_sub_bands = unique(sig_mat(:,2));
sig_chans = cell(3,length(sig_sub_bands));
for sub_band = 1:length(sig_sub_bands)
   cur_band =  sig_sub_bands(sub_band);
   cur_sig_chan_rows = sig_mat(:,2) == cur_band; 
   
   cur_sig_chans = sig_mat(cur_sig_chan_rows,1);
   sig_chans{1,sub_band} = stat_main_effects{1, 2}.label(cur_sig_chans);
   sig_chans{2,sub_band} = cur_band;
   sig_chans{3,sub_band} = sig_mat(cur_sig_chan_rows,3);
end


%%
[sig_rows,sig_c,t_value] = find(stat_interaction.stat.* stat_interaction.mask)

sig_mat = [sig_rows sig_c t_value];
sig_sub_bands = unique(sig_mat(:,2));
sig_chans = cell(3,length(sig_sub_bands));
for sub_band = 1:length(sig_sub_bands)
   cur_band =  sig_sub_bands(sub_band);
   cur_sig_chan_rows = sig_mat(:,2) == cur_band; 
   
   cur_sig_chans = sig_mat(cur_sig_chan_rows,1);
   sig_chans{1,sub_band} = stat_main_effects{1, 2}.label(cur_sig_chans);
   sig_chans{2,sub_band} = cur_band;
   sig_chans{3,sub_band} = -sig_mat(cur_sig_chan_rows,3);
end


