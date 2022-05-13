analysis_type = {'no_aggressive_trialwise_CAR'};%,'aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
cor_fun = @IBS_save_dyad_tf_moving_corr;
analysis = 'Moving_window';



window_sizes = [5];%[5 10 15 20 25 30];
for window = 1:length(window_sizes)
varargin_table = table();
% the order is very important here:
varargin_table.freq_bands = 1:95;
varargin_table.windowSize = window_sizes(window);
varargin_table.Dyad_no = 1:23;
varargin_table.plot_type = 'images';

varargin_table.measure = 'corr';

cellfun(@(x) IBS_power_stats(x,analysis,cor_fun,varargin_table),analysis_type,'UniformOutput',false)

end