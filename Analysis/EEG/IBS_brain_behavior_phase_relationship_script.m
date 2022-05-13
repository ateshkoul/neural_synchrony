%% what happens to power freq phase when someone performs a behavior

clear
Dyads = 1:23;
% conditions = {'NeNoOcc_1' };
conditions = {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'};
% behavior = 'Smile_auto';
% behavior = 'video_openpose_landmarks_manual_cleaned';
% behavior = 'Gaze_nose_dist';
behav_analysis = 'joint_XOR'; % it doesn't matter whether it is XOR or AND
output_data = 'all';
analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
% analysis_sub_type = '_insta';% analysis_sub_type = '_insta_avg_freqwise';% analysis_sub_type = '_insta_20_data_smoothed';,'Smile_auto',
analysis_sub_type = '_insta_avg_freqwise';
cur_behav = 'Smile_auto';
behav_data = IBS_load_behavior_data(cur_behav,analysis_type,Dyads,conditions,behav_analysis,analysis_sub_type,output_data);
% gaze_nose = IBS_load_behavior_data('Eye_tracker_gaze',analysis_type,Dyads,conditions,behav_analysis,analysis_sub_type,output_data);
% all_mov = IBS_load_behavior_data('video_openpose_landmarks_manual_cleaned',analysis_type,Dyads,conditions,behav_analysis,analysis_sub_type,output_data);


% load time-freq data

% this overall doesn't work well because phase reset probably is different
% across different individual
analysis_type_params = IBS_get_params_analysis_type(analysis_type,'Brain_behavior_glm_power_freqwise');
data_dir = analysis_type_params.data_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
minwindow = 10; % determines how big the behavior has to be to be detected as change -
% the bigger this value is, the more sustained the behav has to be


mapObj = containers.Map({'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned'},...
    {'Fun_eye_gaze_distance','Fun_mouth_size','Fun_ALL_joint'});
condition_starts = [0 1201 1201*2 1201*3 1201*4 1201*5 1201*6 1201*7];




stat_cluster = IBS_get_stat_cluster(analysis_type,'Brain_behavior_glm_power_freqwise');
behav_1_pre_post_combined = cell(1,length(Dyads));
behav_2_pre_post_combined  = cell(1,length(Dyads));

ori_conditions = {'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'};

condition_split = cellfun(@(x) strsplit(x,'_'),conditions,'UniformOutput',false);
condition_names = cellfun(@(x) x(1),condition_split,'UniformOutput',false);
block_nos = cell2mat(cellfun(@(x) str2num(x{2}),condition_split,'UniformOutput',false));
condition_nos = cell2mat(cellfun(@(x) find(ismember(ori_conditions,x)),condition_names,'UniformOutput',false));
% condition_nos = unique(cell2mat(cellfun(@(x) find(ismember(conditions,x)),condition_names,'UniformOutput',false)));

unique_conds = unique(condition_nos);



bands = table2array(analysis_type_params.cluster_freq_table);
cluster_no = 2;
common_chan = find(sum(stat_cluster{1,cluster_no},2,'omitnan')==3); % select channels that are common to all subbands
% this is probably better so that we could calculate not only for gamma but
% also for other bands to say that this doesn't happen in other bands.

% alternatively one could just focus on gamma subbands and choose 'its'
% channels depending upon which subband was band passed.
pre_post_sec_windows_starts = [0.1 0.5 3 4 5];
frame_rate = 10;

behav_pre_combined_cond = nan(length(pre_post_sec_windows_starts),length(Dyads),length(bands),length(conditions));
behav_post_combined_cond = nan(length(pre_post_sec_windows_starts),length(Dyads),length(bands),length(conditions));

for pre_post_sec_window = 1:length(pre_post_sec_windows_starts)
    pre_post_sec_duration = 1;
    % pre_samples = (pre_post_sec*2048)-1;
    % post_samples = pre_post_sec*2048;
    
    
    pre_samples = (pre_post_sec_duration*frame_rate)-1;
    post_samples = pre_post_sec_duration*frame_rate;
    
    for dyd_no = 1:length(Dyads)
        data = IBS_load_clean_IBS_tf_data(Dyads(dyd_no),analysis_type,data_dir);
        %     data = IBS_load_clean_IBS_data(Dyads(dyd_no),analysis_type,data_dir);
        
        %     [data_S1,data_S2] = IBS_raw_to_condwise(data.data_ica_clean_S1,data.data_ica_clean_S2,conditions);
        
        
        %     corresp_indices = IBS_find_corresponding_time_points(data_S1{1,1}.time{1,1},linspace(0,120,1201));
        
        
        
        S1_value = behav_data{1}{Dyads(dyd_no)};
        S2_value = behav_data{2}{Dyads(dyd_no)};
        S_joint_value = behav_data{3}{Dyads(dyd_no)};
        cur_behav_1 = S1_value.([mapObj(cur_behav) '_0']);
        cur_behav_2 = S2_value.([mapObj(cur_behav) '_1']);
        cur_behav_joint = S_joint_value.([mapObj(cur_behav) '_joint']);
        
        for sub_band = 1:length(bands)
            filter_order = 3;
            for cond = 1:length(conditions)
                
                cur_cond_behav_1 = cur_behav_1((condition_starts(cond)+1):condition_starts(cond+1));
                
                cur_cond_behav_2 = cur_behav_2((condition_starts(cond)+1):condition_starts(cond+1));
                cur_cond_behav_joint = cur_behav_joint((condition_starts(cond)+1):condition_starts(cond+1));
                s1 = IBS_compute_sudden_changes(double(cur_cond_behav_1),minwindow,'all');
                s2 = IBS_compute_sudden_changes(double(cur_cond_behav_2),minwindow,'all');
                
                s1_increase = s1.increase{1,1};
                s2_increase = s2.increase{1,1};
                
                %
                %             cur_data_S1 = data_S1{cond};
                %             cur_data_S2 = data_S2{cond};
                
                cur_data_S1 = squeeze(data.data_ica_clean_S1_tf{1,condition_nos(cond)}.powspctrm(block_nos(cond),:,:,:));
                cur_data_S2 = squeeze(data.data_ica_clean_S2_tf{1, condition_nos(cond)}.powspctrm(block_nos(cond),:,:,:));
                
                
                cur_data_S1 = IBS_compute_freqwise(analysis_type,cur_data_S1);
                
                cur_data_S2 = IBS_compute_freqwise(analysis_type,cur_data_S2);
                
                %
                %             cur_sub_band_data_S1 = ft_preproc_bandpassfilter(cur_data_S1.trial{1,1},cur_data_S1.fsample,bands{sub_band},filter_order);
                %             cur_sub_band_data_S2 = ft_preproc_bandpassfilter(cur_data_S2.trial{1,1},cur_data_S2.fsample,bands{sub_band},filter_order);
                
                %             cur_sub_band_data_S1_angle = ft_preproc_hilbert(cur_sub_band_data_S1,'angle');
                %             cur_sub_band_data_S2_angle = ft_preproc_hilbert(cur_sub_band_data_S2,'angle');
                
                
                %              cur_sub_band_data_S1_angle = ft_preproc_hilbert(cur_sub_band_data_S1,'abs');
                %             cur_sub_band_data_S2_angle = ft_preproc_hilbert(cur_sub_band_data_S2,'abs');
                
                
                % combined for the 2 subjects
                s_increase = unique([s1_increase;s2_increase]);
                plv_pre = nan(1,length(s_increase));
                plv_post = nan(1,length(s_increase));
                
                for max_value = 1:length(s_increase)
                    %                 cur_max_behav = s_increase(max_value)
                    cur_max_behav = s_increase(max_value);
                    cur_max_pre_behav = cur_max_behav - pre_post_sec_windows_starts(pre_post_sec_window) * frame_rate;
                    
                    cur_max_post_behav = cur_max_behav + pre_post_sec_windows_starts(pre_post_sec_window)*frame_rate;
                    %                 cur_max_raw_index = corresp_indices(cur_max_behav);
                    %                 if (cur_max_raw_index-pre_samples)>0 && (cur_max_raw_index+post_samples)<size(cur_sub_band_data_S1_angle,2)
                    if (cur_max_pre_behav-pre_samples)>0 && (cur_max_post_behav+post_samples)<size(cur_data_S1,3)
                        
                        data_chan_pre_1 = squeeze(cur_data_S1(common_chan,sub_band,cur_max_pre_behav-pre_samples:cur_max_pre_behav));
                        data_chan_pre_2 = squeeze(cur_data_S2(common_chan,sub_band,cur_max_pre_behav-pre_samples:cur_max_pre_behav));
                        
                        
                        %                     plv_pre(max_value) = mean(abs(mean(exp(1i*(data_chan_pre_1 -data_chan_pre_2)),2)));
                        data_chan_post_1 = squeeze(cur_data_S1(common_chan,sub_band,cur_max_post_behav:cur_max_post_behav+post_samples));
                        data_chan_post_2 = squeeze(cur_data_S2(common_chan,sub_band,cur_max_post_behav:cur_max_post_behav+post_samples));
                        %
                        
                        %
                        %                     data_chan_pre_1 = cur_sub_band_data_S1_angle(common_chan,cur_max_raw_index-pre_samples:cur_max_raw_index);
                        %                     data_chan_pre_2 = cur_sub_band_data_S2_angle(common_chan,cur_max_raw_index-pre_samples:cur_max_raw_index);
                        %
                        %
                        % %                     plv_pre(max_value) = mean(abs(mean(exp(1i*(data_chan_pre_1 -data_chan_pre_2)),2)));
                        %                     data_chan_post_1 = cur_sub_band_data_S1_angle(common_chan,cur_max_raw_index:cur_max_raw_index+post_samples);
                        %                     data_chan_post_2 = cur_sub_band_data_S2_angle(common_chan,cur_max_raw_index:cur_max_raw_index+post_samples);
                        %                     plv_post(max_value) = mean(abs(mean(exp(1i*(data_chan_post_1 -data_chan_post_2)),2)));
                        %                     subset = @(x) x(1,2);
                        %                     plv_pre(max_value) = mean(cell2mat(arrayfun(@(x) subset(corrcoef(data_chan_pre_1(x,:),data_chan_pre_2(x,:))),1:size(data_chan_pre_1,1),'UniformOutput',false)));
                        %                     plv_post(max_value) = mean(cell2mat(arrayfun(@(x) subset(corrcoef(data_chan_post_1(x,:),data_chan_post_2(x,:))),1:size(data_chan_post_1,1),'UniformOutput',false)));
                        plv_pre(max_value) = nanmean(cell2mat(arrayfun(@(x) IBS_compute_vector_angle(data_chan_pre_1(x,:),data_chan_pre_2(x,:)),1:size(data_chan_pre_1,1),'UniformOutput',false)));
                        
                        plv_post(max_value) = nanmean(cell2mat(arrayfun(@(x) IBS_compute_vector_angle(data_chan_post_1(x,:),data_chan_post_2(x,:)),1:size(data_chan_post_1,1),'UniformOutput',false)));
                        
                        
                    end
                    
                end
                behav_pre_combined_cond(pre_post_sec_window,dyd_no,sub_band,cond) = nanmean(plv_pre);
                behav_post_combined_cond(pre_post_sec_window,dyd_no,sub_band,cond) = nanmean(plv_post);
                
            end
           
        end
         clear cur_data_S1 cur_data_S2 cur_cond_behav_1 cur_cond_behav_2
    end
    clear data
end
%
%
analysis_save_dir = analysis_type_params.analysis_save_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
% get cond name
subset = @(x) x{1};

cond_name = cellfun(@(x) subset(strsplit(x,'_')),conditions,'UniformOutput',0);
cond_name = strjoin(unique(cond_name),'_');
save([analysis_save_dir 'tf_' cond_name '_' cur_behav ...
    'pre_post_window_100_ms_cluster_' num2str(cluster_no) '.mat'],'behav_pre_combined_cond','behav_post_combined_cond')

%%
lim = [0.37 0.4];
imagesc(squeeze(mean(mean(behav_pre_combined_cond,4,'omitnan'),2))',lim)
ax = gca;
ax.YDir = 'normal';
figure;
imagesc(squeeze(mean(mean(behav_post_combined_cond,4,'omitnan'),2))',lim)
ax = gca;
ax.YDir = 'normal';


imagesc(squeeze(mean(mean(behav_post_combined_cond,4,'omitnan'),2))' - squeeze(mean(mean(behav_pre_combined_cond,4,'omitnan'),2))',[-0.006 0.006])
ax = gca();
ax.YDir = 'normal';
ax.XTick = 1:5;
ax.XTickLabel = pre_post_sec_windows_starts;
ax.YTick = 1:14;
ax.YTickLabel = cellfun(@(x) num2str(x),bands,'UniformOutput',0);

plot(squeeze(mean(mean(behav_post_combined_cond,4,'omitnan'),2)) - squeeze(mean(mean(behav_pre_combined_cond,4,'omitnan'),2)))

%%
plot(nanmean(nanmean(behav_pre_combined_cond,3)))
hold on
plot(nanmean(nanmean(behav_post_combined_cond,3)))
analysis_save_dir_figures = analysis_type_params.analysis_save_dir_figures{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';

saveas(gcf,[analysis_save_dir_figures cond_name '_' cur_behav 'pre_post_sec' num2str(pre_post_sec) '_cluster_' num2str(cluster_no) '_.tif'])
%%

s1 = mean(behav_pre_combined_cond,3);

s2 = mean(behav_post_combined_cond,3);

[h,p]= ttest(s1,s2)

%%

% plotting single dyad
plot(data_S1{1,1}.time{1,1},cur_sub_band_data_S1(64,:))
hold on
plot(data_S1{1,1}.time{1,1},cur_sub_band_data_S1_angle(64,:))
% xline(data_S1{1,1}.time{1,1}(cur_max_raw_index))


plot(data_S1{1,1}.time{1,1},cur_sub_band_data_S2(64,:)+20)
hold on
plot(data_S1{1,1}.time{1,1},cur_sub_band_data_S2_angle(64,:)+20)

for max_value = 1:length(s_increase)
    cur_max_behav = s_increase(max_value);
    cur_max_raw_index = corresp_indices(cur_max_behav);
    xline(data_S1{1,1}.time{1,1}(cur_max_raw_index))
end
% plot(linspace(0,120,1201),double(cur_cond_behav_1)+5,'b')
% plot(linspace(0,120,1201),double(cur_cond_behav_2)+10,'r')

%%
load('E:\Projects\IBS\Results\EEG\Brain_behavior_glm_power_freqwise\no_aggressive_CAR_ASR_10_ICA_appended_trials\figures\FaNoOcc_NeNoOcc_Smile_autopre_post_sec_0.5_cluster_2.mat')
sem = @(x,dim) nanstd( x,0,dim ) / sqrt( size( x,dim ));
Y = [nanmean(mean(behav_pre_combined_cond,3));nanmean(mean(behav_post_combined_cond,3))]';

E = [sem(mean(behav_pre_combined_cond,3),1);sem(mean(behav_post_combined_cond,3),1)]';


bar([nanmean(mean(behav_pre_combined_cond,3));nanmean(mean(behav_post_combined_cond,3))]')

%%
b = bar(Y,'grouped');


hold on
% Calculate the number of groups and number of bars in each group
[ngroups,nbars] = size(Y);
% Get the x coordinate of the bars
x = nan(nbars, ngroups);
for i = 1:nbars
    x(i,:) = b(i).XEndPoints;
end
% Plot the errorbars
errorbar(x',Y,E,'k','linestyle','none');
hold off
ax = gca;

%%
hold on
errorbar(Y,E,'.')
title('PLV pre post 0.5 sec')

%%
% plot(nanmean(mean(behav_pre_combined_cond,3)),'--rs','LineWidth',2)
% hold on
% plot(nanmean(mean(behav_post_combined_cond,3)),'--bs','LineWidth',2)
%
% hold on
% plot(behav')
% xline(50)
%

sem = @(x,dim) nanstd( x,0,dim ) / sqrt( size( x,dim ));
yu = nanmean(behav) + sem(behav,1);
yl = nanmean(behav) - sem(behav,1);
x = 1:length(behav);
fill([x fliplr(x)], [yu fliplr(yl)], [.9 .9 .9], 'linestyle', 'none')
hold all
plot(nanmean(behav),'--rs','LineWidth',2)
xline(50)
