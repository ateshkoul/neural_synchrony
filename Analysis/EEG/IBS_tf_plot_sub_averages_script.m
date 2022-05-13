analysis_type = {'no_aggressive_CAR_ASR_10_ICA_appended_trials'};
% analysis_type = {'aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};

cor_fun = @IBS_tf_correlations;
% cor_fun = @IBS_test_correlation_dyad_specific;

% cor_fun = @IBS_tf_mutual_info;
varargin_table.cor_fun_args = table();
varargin_table.cor_fun_args.Dyads = 1:23;
x = cellfun(@(x) IBS_tf_correlations(x),analysis_type,'UniformOutput',false);

%%
% x = cellfun(@(x) IBS_tf_correlations(x),x,'UniformOutput',false);
data_analysis_type = analysis_type{1,1};
[data_tf_freqwise] = IBS_convert_freqwise(x{1,1},data_analysis_type);


stat_cluster = IBS_get_stat_cluster(data_analysis_type,'Power_correlation_analysis_freqwise');



data_tf_freqwise_cluster_1 = cell2mat(cellfun(@(x) nanmean(nanmean(x.*stat_cluster{1,1})),data_tf_freqwise,'UniformOutput',false));
data_tf_freqwise_cluster_2 = cell2mat(cellfun(@(x) nanmean(nanmean(x.*stat_cluster{1,2})),data_tf_freqwise,'UniformOutput',false));
data_tf_freqwise_cluster_3 = cell2mat(cellfun(@(x) nanmean(nanmean(x.*stat_cluster{1,3})),data_tf_freqwise,'UniformOutput',false));

data_tf_freqwise_cluster_1 = cell2mat(cellfun(@(x) nanmean(nanmedian(x.*stat_cluster{1,1})),data_tf_freqwise,'UniformOutput',false));
data_tf_freqwise_cluster_2 = cell2mat(cellfun(@(x) nanmedian(nanmedian(x.*stat_cluster{1,2})),data_tf_freqwise,'UniformOutput',false));
data_tf_freqwise_cluster_3 = cell2mat(cellfun(@(x) nanmean(nanmean(x.*stat_cluster{1,3})),data_tf_freqwise,'UniformOutput',false));

data_tf_freqwise_cluster_2 = cell2mat(cellfun(@(x) nanmean(nanmean(normalize(x).*stat_cluster{1,2})),data_tf_freqwise,'UniformOutput',false));

data_tf_freqwise_cluster_2 = cell2mat(cellfun(@(x) nanmean(nanmean(x.*stat_cluster{1,2},2)),data_tf_freqwise,'UniformOutput',false));

%%
% stat_cluster{1,2}(:,[12 13]) = nan;
% data_tf_freqwise_cluster_2 = cell2mat(cellfun(@(x) nanmean(nanmean(x.*stat_cluster{1,2})),data_tf_freqwise,'UniformOutput',false));


% 'FaOcc','FaNoOcc','NeOcc','NeNoOcc'
% for i = 2:5
% subplot(1,4,i-1)
% boxplot([data_tf_freqwise_cluster_1(:,i) data_tf_freqwise_cluster_2(:,i) data_tf_freqwise_cluster_3(:,i)])
% ylim([-0.08 0.08])
% end

%%
analysis_params = IBS_get_params_analysis_type(data_analysis_type);
save_fig_dir = analysis_params.analysis_save_dir_figures{1,1};

%%
data = data_tf_freqwise_cluster_1(:,2:5);


% data = data(1:22,:);
data = data(:);
data_names = repmat({'FaOcc','FaNoOcc','NeOcc','NeNoOcc'},23,1);
% data_names = repmat({'FaOcc','FaNoOcc','NeOcc','NeNoOcc'},22,1);

data_names = data_names(:);
figure;
violinplot(data,data_names,'EdgeColor',[0 0 0],'ViolinAlpha',0.5,...
    'GroupOrder',{'FaOcc','NeOcc','FaNoOcc','NeNoOcc'})
ylim([-0.12 0.12])
exportgraphics(gcf,[save_fig_dir 'sub_avg_cluster_1.eps'],'BackgroundColor','none','ContentType','vector')
writetable(array2table(cat(2,num2cell(data(:)),data_names),'VariableNames',{'data_values','conditions'}),[save_fig_dir 'new_data_cluster_1.csv'])

%%
data = data_tf_freqwise_cluster_2(:,2:5);


% data = data(1:22,:);
data = data(:);
data_names = repmat({'FaOcc','FaNoOcc','NeOcc','NeNoOcc'},23,1);
% data_names = repmat({'FaOcc','FaNoOcc','NeOcc','NeNoOcc'},22,1);

data_names = data_names(:);
figure;
violinplot(data,data_names,'EdgeColor',[0 0 0],'ViolinAlpha',0.5,...
    'GroupOrder',{'FaOcc','NeOcc','FaNoOcc','NeNoOcc'})
ylim([-0.12 0.12])
exportgraphics(gcf,[save_fig_dir 'sub_avg_cluster_2.eps'],'BackgroundColor','none','ContentType','vector')
writetable(array2table(cat(2,num2cell(data(:)),data_names),'VariableNames',{'data_values','conditions'}),[save_fig_dir 'new_data_cluster_2.csv'])
%%
data = data_tf_freqwise_cluster_3(:,2:5);


% data = data(1:22,:);
data = data(:);
data_names = repmat({'FaOcc','FaNoOcc','NeOcc','NeNoOcc'},23,1);
% data_names = repmat({'FaOcc','FaNoOcc','NeOcc','NeNoOcc'},22,1);

data_names = data_names(:);
figure;
violinplot(data,data_names,'EdgeColor',[0 0 0],'ViolinAlpha',0.5,...
    'GroupOrder',{'FaOcc','NeOcc','FaNoOcc','NeNoOcc'})
ylim([-0.12 0.12])
exportgraphics(gcf,[save_fig_dir 'sub_avg_cluster_3.eps'],'BackgroundColor','none','ContentType','vector')

writetable(array2table(cat(2,num2cell(data(:)),data_names),'VariableNames',{'data_values','conditions'}),[save_fig_dir 'new_data_cluster_3.csv'])
