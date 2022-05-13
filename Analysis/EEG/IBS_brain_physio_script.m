% analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
% analysis_type = {'no_aggressive_trialwise_CAR'};
analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
% conditions = {'FaNoOcc_3','NeNoOcc_3'};
% conditions = {{'FaNoOcc_1'},{'NeNoOcc_1'}};
% conditions = {{'NeNoOcc_1'}};
% conditions = {{'FaNoOcc_1'}};
conditions = {'NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'};


% If you believe that comparing AICs is a good way to choose a model then it
% would still be the case that the (algebraically) lower AIC is preferred not
% the one with the lowest absolute AIC value. To reiterate you want the most 
% negative number in your example.


analysis = 'Brain_behavior_glm_power_freqwise';

Dyads = [1:6 8:11 14:18 20:23];
[brain_data,brain_data_sub] = IBS_brain_behavior_get_brain_data(analysis_type,analysis,Dyads,conditions);
brain_stat_data = cellfun(@(x) IBS_brain_behavior_get_stat_cluster_data(analysis_type,analysis,x),brain_data_sub,...
    'UniformOutput',0);


%%

behav_analysis = 'joint_OR';
behavior = 'ECG';

behavior_data_ECG = IBS_load_behavior_data(behavior,analysis_type,Dyads,conditions,behav_analysis,'all');


behavior_data_combined = cat(1,behavior_data{1, 3}{:});

% 
% Dyad_7 = ismember(behavior_data_combined.Dyad_no_ECG,{'Dyad_07'}) & ismember(behavior_data_combined.condition_ECG,{'FaNoOcc_3'});
% Dyad_13 = ismember(behavior_data_combined.Dyad_no_ECG,{'Dyad_13'}) & ismember(behavior_data_combined.condition_ECG,{'FaNoOcc_2'});
% 
% behavior_data_combined_sel = behavior_data_combined(~(Dyad_7+Dyad_13),:);

behav_sub_joint = IBS_remove_empty_dyads(behavior_data{1,3});

behav_sub_1 = IBS_remove_empty_dyads(behavior_data{1,1});

behav_sub_2 = IBS_remove_empty_dyads(behavior_data{1,2});
s = cell2mat(cellfun(@(x,y) nancorr(x.ECG_Rate_joint,y{1,3}),behav_sub_joint,brain_stat_data,'UniformOutput',0))
s2 = cell2mat(cellfun(@(x,y) max(crosscorr(x.ECG_Rate_0(1:1201-41,:),y.ECG_Rate_1(1:1201-41,:),'NumLags',60)),...
    behav_sub_1,behav_sub_2,'UniformOutput',0))

s2 = cell2mat(cellfun(@(x,y) max(crosscorr(x.ECG_Rate_0(1:1201-41,:),y.ECG_Rate_1(1:1201-41,:),'NumLags',60)),...
    behav_sub_1,behav_sub_2,'UniformOutput',0))

IBS_brain_physio_plot_stat_brain_behav(brain_stat_data,behavior_data,5,1)
IBS_brain_physio_plot_stat_brain_behav(brain_stat_data,behavior_data,5,1,'ECG',1:1201,1)
IBS_brain_physio_plot_stat_brain_behav(brain_stat_data,behavior_data_ECG,5,1,'ECG_Phase_Completion_Ventricular',1:1201,2)

%%

behav_analysis = 'joint_OR';
behavior = 'EDA';

behavior_data_EDA = IBS_load_behavior_data(behavior,analysis_type,Dyads,conditions,behav_analysis,'all');
IBS_brain_physio_plot_stat_brain_behav(brain_stat_data,behavior_data_EDA,5,1,'EDA_Tonic',1:1201,1)


%%
behav_analysis = 'joint_OR';
behavior = 'Eye_tracker_pupil';

behavior_data_pupil = IBS_load_behavior_data(behavior,analysis_type,Dyads,conditions,behav_analysis,'all');

IBS_brain_physio_plot_stat_brain_behav(brain_stat_data,behavior_data_pupil,5,1)


%%
Dyad_no = 2;
cluster_no = 1;
figure
subplot(3,1,1)

varargin_table = table();
varargin_table.rows = 1201:1201*2;
varargin_table.smooth = 1;
IBS_brain_physio_plot_stat_brain_behav(brain_stat_data,behavior_data_pupil,Dyad_no,cluster_no,'pupil diameter',varargin_table)
subplot(3,1,2)
varargin_table.smooth = 0;
IBS_brain_physio_plot_stat_brain_behav(brain_stat_data,behavior_data_ECG,Dyad_no,cluster_no,'ECG',varargin_table)

subplot(3,1,3)
IBS_brain_physio_plot_stat_brain_behav(brain_stat_data,behavior_data_EDA,Dyad_no,cluster_no,'EDA_Tonic',varargin_table)



%%
behav_sub_1 = IBS_remove_empty_dyads(behavior_data_ECG{1,1});

behav_sub_2 = IBS_remove_empty_dyads(behavior_data_ECG{1,2});


behav_sub_1_EDA = IBS_remove_empty_dyads(behavior_data_EDA{1,1});

behav_sub_2_EDA = IBS_remove_empty_dyads(behavior_data_EDA{1,2});

behav_sub_1_pupil = IBS_remove_empty_dyads(behavior_data_pupil{1,1});

behav_sub_2_pupil = IBS_remove_empty_dyads(behavior_data_pupil{1,2});
% attempt to do a timelocked version
Dyads = [1:18];
cluster_no =1;
% Dyad_no = 5;
pre_samples = 24;
post_samples = 24;
rows = 1:1201; %1:1201;
% h1 = figure('units','normalized','outerposition',[0 0 1 1]);
h2 = figure('units','normalized','outerposition',[0 0 1 1]);
variable_name = 'pupil smoothed';
for Dyad_no = 1:length(Dyads)
behav_1_pre_post = {};
behav_2_pre_post = {};
local_max = find(islocalmax(brain_stat_data{1, Dyad_no}{1, cluster_no}(rows,:),'MinSeparation',100));

% figure(h1)
% subplot(3,6,Dyad_no)
% plot(brain_stat_data{1, Dyad_no}{1, cluster_no}(rows,:))
% hold on
% plot(islocalmax(brain_stat_data{1, Dyad_no}{1, cluster_no}(rows,:),'MinSeparation',100),'r')

behav_sub_1_pupil{1, Dyad_no}.diameter_0 = smoothdata(behav_sub_1_pupil{1, Dyad_no}.diameter_0,'movmean',50);
behav_sub_2_pupil{1, Dyad_no}.diameter_1 = smoothdata(behav_sub_2_pupil{1, Dyad_no}.diameter_1,'movmean',50);

for max_value = 1:length(local_max)
        cur_max = local_max(max_value);

    if (cur_max-pre_samples)>0 && (cur_max+post_samples)<length(behav_sub_1{1, Dyad_no}.ECG_Rate_0(rows,:))
%     behav_1_pre_post{Dyad_no,max_value} = behav_sub_1{1, 1}{1, Dyad_no}.ECG_Rate_0(cur_max-pre_samples:cur_max+post_samples);
%     behav_2_pre_post{Dyad_no,max_value} = behav_sub_2{1, 2}{1, Dyad_no}.ECG_Rate_1(cur_max-pre_samples:cur_max+post_samples);
%     behav_1_pre_post{Dyad_no,max_value} = behav_sub_1{1, Dyad_no}.ECG_Rate_0(cur_max-pre_samples:cur_max+post_samples);
%     behav_2_pre_post{Dyad_no,max_value} = behav_sub_2{1, Dyad_no}.ECG_Rate_1(cur_max-pre_samples:cur_max+post_samples);

%     behav_1_pre_post{max_value} = behav_sub_1{1, Dyad_no}.ECG_Rate_0(cur_max-pre_samples:cur_max+post_samples)';
%     behav_2_pre_post{max_value} = behav_sub_2{1, Dyad_no}.ECG_Rate_1(cur_max-pre_samples:cur_max+post_samples)';
    
    behav_1_pre_post{max_value} = behav_sub_1_EDA{1, Dyad_no}.EDA_Tonic_0(cur_max-pre_samples:cur_max+post_samples)';
    behav_2_pre_post{max_value} = behav_sub_2_EDA{1, Dyad_no}.EDA_Tonic_1(cur_max-pre_samples:cur_max+post_samples)';
    
    
%     behav_1_pre_post{max_value} = behav_sub_1_pupil{1, Dyad_no}.diameter_0(cur_max-pre_samples:cur_max+post_samples)';
%     behav_2_pre_post{max_value} = behav_sub_2_pupil{1, Dyad_no}.diameter_1(cur_max-pre_samples:cur_max+post_samples)';
%     
    end
    behav_1_pre_post_combined{Dyad_no} = nanmean(cat(1,behav_1_pre_post{:}),1);
    behav_2_pre_post_combined{Dyad_no} = nanmean(cat(1,behav_2_pre_post{:}),1);
    
end
figure(h2)
subplot(3,6,Dyad_no)
% plot(behav_1_pre_post_combined{Dyad_no}')
% hold on
% plot(behav_2_pre_post_combined{Dyad_no}')
% plot(abs(behav_1_pre_post_combined{Dyad_no}' - behav_2_pre_post_combined{Dyad_no}'))
% hold on

plot(behav_1_pre_post_combined{Dyad_no}' - behav_2_pre_post_combined{Dyad_no}','r')

%     plot(behav_2_pre_post_combined{Dyad_no}' - behav_1_pre_post_combined{Dyad_no}','g')

% plot(behav_2_pre_post_combined{Dyad_no}' - behav_1_pre_post_combined{Dyad_no}','g')
xline(pre_samples+1)
title([ 'Dyad_no ' num2str(Dyad_no) ' cluster_no ' num2str(cluster_no)],'Interpreter','none')
end
sgtitle(variable_name)
save_dir = 'E:\\Projects\\IBS\\Results\\EEG\\Brain_physio\\';
% saveas(gcf,[save_dir 'dyads_' variable_name '_cluster_no ' num2str(cluster_no) '.tif'])
% behav_1_pre_post_all_sub = cat(1,behav_1_pre_post_combined{:});
% behav_2_pre_post_all_sub = cat(1,behav_2_pre_post_combined{:});
% figure
% plot(behav_1_pre_post_all_sub')
% hold on
% plot(behav_2_pre_post_all_sub')
% xline(pre_samples+1)

%%
figure
plot(mean(behav_1_pre_post_all_sub))
hold on
plot(mean(behav_2_pre_post_all_sub))
xline(pre_samples+1)


