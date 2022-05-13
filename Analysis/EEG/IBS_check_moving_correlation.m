

%%
% windowSize = [1 2 3 4 5 10 15 20 25 30];
% windowSize = [15 20 30];
% windowSize = [60 90 120];
% freq_bands = {[1:95]};
analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};

analysis_type_params = IBS_get_params_analysis_type(analysis_type);
windowSize = analysis_type_params.windowSize;
freq_bands = analysis_type_params.freq_bands;

cellfun(@(x) arrayfun(@(y) IBS_tf_moving_correlations_trialwise(y,freq_bands),windowSize,...
    'UniformOutput',false),analysis_type,'UniformOutput',false)

%%
windowSize = [1 4 5];




%%
windowSize = [0.5];


%% save averaged moving windows
windowSizes = [1 2 3 4 5 10 15 20 25 30];
freq_bands = [1:95];
for window = 1:length(windowSizes)
load_fname = sprintf('D:\\Atesh\\IBS\\CAR\\trialwise_moving_centered_corr_%0.1d_window_%0.1d_%0.1d_1_11_13_18_20_23_dyads_baseline_normchange_0_120s_CAR.mat',windowSizes(window),freq_bands(1),freq_bands(end));
save_fname = sprintf('D:\\Atesh\\IBS\\CAR\\avg_trialwise_moving_corr_%0.1d_window_%0.1d_%0.1d_1_11_13_18_20_23_dyads_baseline_normchange_0_120s_CAR.mat',windowSizes(window),freq_bands(1),freq_bands(end));
load(load_fname)
data_type = 'mean';
[correlation_cond,mean_pwr_correlation] = IBS_process_pwr_correlations(moving_correlation,data_type,'moving_corr');

data_type = 't_value';
[correlation_cond,t_value_pwr_correlation] = IBS_process_pwr_correlations(moving_correlation,data_type,'moving_corr');


save(save_fname,'mean_pwr_correlation','t_value_pwr_correlation','conditions','correlation_cond','-v7.3');

end
%% for the [1:95] freq range
processed_dir = 'D:\\Experiments\\IBS\\Processed\\EEG\\';
windowSize = [1 2 3 4 5 10 15 20 25 30];
save_dir = 'Y:\\Inter-brain synchrony\\Results\\EEG\\power correlations\\moving_window\\';
for window = 1:length(windowSize)
    load([processed_dir sprintf('avg_trialwise_moving_corr_%0.1d_window_1_95_1_11_13_18_20_23_dyads_baseline_normchange_0_120s_CAR.mat',windowSize(window))]);
    analysis_type = sprintf('_no_aggressive_moving_corr_%0.1d_window_trialwise_CAR',windowSize(window));
    % plot_types = {'images','multiplot','movie_topoplot'};
    % plot_types = {'movie_topoplot'};
    % plot_types = {'multiplot'};
    plot_types = {'images'};
    data_type = 'mean';
    cellfun(@(z) cellfun(@(x,y) IBS_plot_correlation_map(x,[y ' window ' num2str(windowSize(window)) 's'],z,data_type,analysis_type,[-0.2 0.2],save_dir),mean_pwr_correlation,conditions),plot_types)
    close all
    data_type = 't_values';
    cellfun(@(z) cellfun(@(x,y) IBS_plot_correlation_map(x,[y ' window ' num2str(windowSize(window)) 's'],z,data_type,analysis_type,[-10 10],save_dir),t_value_pwr_correlation,conditions),plot_types)
    close all
end
%%
processed_dir = 'D:\\Experiments\\IBS\\Processed\\EEG\\';

save_dir = 'Y:\\Inter-brain synchrony\\Results\\EEG\\power correlations\\moving_window\\';
% root_dir = 'Y:\\Research projects 2020\\Inter-brain synchrony\\Results\\EEG\\power correlations\\';
windowSize = [1 2 3 4 5 10 15 20 25 30];

% data_type = 'mean';
for window = 1:length(windowSize)
    import mlreportgen.ppt.*
plot_types = {'images'};
data_type = 't_values';
analysis_type = sprintf('_no_aggressive_moving_corr_%0.1d_window_trialwise_CAR',windowSize(window));
load([processed_dir sprintf('avg_trialwise_moving_corr_%0.1d_window_1_95_1_11_13_18_20_23_dyads_baseline_normchange_0_120s_CAR.mat',windowSize(window))]);

ppt = Presentation([save_dir 'results_power_correlation_' analysis_type   '_0_120s_' data_type '.pptx'],'C:\\Users\\Atesh\\Documents\\Custom Office Templates\\standard.potx');
conditions = cellfun(@(x) [x ' window ' num2str(windowSize(window)) 's'],conditions,'UniformOutput',false);
file_delimiter = [' window ' num2str(windowSize(window)) 's'];
cellfun(@(x) IBS_powerpoint_plots_tf_correlations(ppt,save_dir,data_type,x,analysis_type ,conditions,file_delimiter),plot_types)
close(ppt);

end



%%
Dyads = 1:11;
[moving_correlation,conditions]= IBS_tf_moving_correlations_trialwise(windowSize,freq_bands,Dyads);

%%

Dyads = [1:11 13:18 20:23];
for Dyd_no = [1 2 3 5 11 21]
   moving_correlation_sub = moving_correlation{1, Dyd_no}{1, 5}{1,1};
  save_fname = sprintf('D:\\Atesh\\IBS\\CAR\\Sub_Dyd_%0.2d_trialwise_moving_corr_NeNoOcc_1_window_30_45_1_11_13_18_20_23_dyads_baseline_normchange_0_120s_NoCAR.mat',Dyads(Dyd_no));
  save(save_fname,'moving_correlation_sub')
end




%%

load('D:\\Atesh\\IBS\\CAR\\trialwise_moving_correlations_1_11_13_18_20_23_dyads_baseline_normchange_0_120s_NoCAR.mat');

%% process pwr correlations
data_type = 'mean';
[~,mean_pwr_correlation] = IBS_process_pwr_correlations(moving_correlation,data_type);


%%

Dyads = [1:11 13:18 20:23];
Dyd_no = 11;
data = load(sprintf('D:\\Atesh\\IBS\\CAR\\Dyd_%0.2d_trialwise_time_freq_baseline_normchange_0_120s_CAR.mat',Dyads(Dyd_no)),...
        'data_ica_clean_S1_tf','data_ica_clean_S2_tf');
    
    
load(sprintf('D:\\Atesh\\IBS\\Dyd_%0.2d_ICA_func_clean_bp_03_95_120s.mat',Dyads(Dyd_no)));
[ ~, ~ ] = Giac_EEGplotNanTrials( data_ica_clean_S1{1,2}, {'all'}, [], 'IBS_S1_layout_64.mat',  'NoReject' );
[ ~, ~ ] = Giac_EEGplotNanTrials( data_ica_clean_S2{1,2}, {'all'}, [], 'IBS_S2_layout_64.mat',  'NoReject' );

%%
load('tf_ICA_template_struct.mat')
channels_interested = {'1-F1','1-F3','1-F5','1-FC1','1-FC3','1-FC5','1-C1','1-C3','1-C5'};
chan_no = cell2mat(cellfun(@(x) find(ismember(template_trial.label,x)),channels_interested,'UniformOutput',false));

%%
% moving_correlation{1,Dyd_no}{1,5}{1,1}

s = cat(4,moving_correlation{1, 11}{1, 5}{:});
p = nanmean(s,4);

sub = 1;
p = moving_correlation{1, sub}{1, 5}{1,1};
mean_across_freq = nanmean(p,3);


mean_across_freq_chan = mean(mean_across_freq(chan_no,:));
figure;plot(0:0.1:120,mean_across_freq_chan)
ylim([-0.3 0.3])
% figure;plot(0:0.1:120,mean_across_freq(1,:))



%%

p = moving_correlation{1, sub}{1, 4}{1,1};
mean_across_freq = nanmean(p,3);


mean_across_freq_chan = mean(mean_across_freq(chan_no,:));
hold on;plot(0:0.1:120,mean_across_freq_chan,'r')
ylim([-0.3 0.3])

%%
p = moving_correlation{1, sub}{1, 1}{1,1};
mean_across_freq = nanmean(p,3);


mean_across_freq_chan = mean(mean_across_freq(chan_no,:));
hold on;plot(0:0.1:120,mean_across_freq_chan,'g')
ylim([-0.3 0.3])

%%

load('tf_ICA_template_struct.mat')
template_trial.fsample = 10;
template_trial.time(2:end) = [];
template_trial.trial{1,1} = mean_across_freq;

[ ~, ~ ] = Giac_EEGplotNanTrials( template_trial, {'all'}, [], 'IBS_S1_layout_64.mat',  'NoReject' );


%% check
chan = 1;
time_point = 10;
n = nanmean([squeeze(moving_correlation{1, 11}{1, 5}{1,1}(chan,time_point,:))'; ...
    squeeze(moving_correlation{1, 11}{1, 5}{1,2}(chan,time_point,:))'; ...
    squeeze(moving_correlation{1, 11}{1, 5}{1,3}(chan,time_point,:))'])
sum(squeeze(p(chan,time_point,:))'-n)








