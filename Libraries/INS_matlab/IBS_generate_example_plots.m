


%% plot example
Dyad_no = 1;
condition_FaNoOcc = 'FaNoOcc_1';
condition_NeNoOcc = {'NeNoOcc_1'};
% condition_NeOcc = 'NeOcc_1';
condition_no_FaNoOcc_1 = 3;
condition_no_NeNoOcc_1 = 5;
% condition_no_NeOcc_1 = 4;

% data_analysis_type = 'no_aggressive_trialwise_CAR';
data_analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
% analysis_type = {'no_aggressive_CAR_ASR_5_ICA_appended_trials'};


xlimits = [710 810];
analysis_sub_type ='_insta_corr_avg_freqwise';
% data_analysis_type = 'no_aggressive_trialwise_CAR';
analysis_type_params = IBS_get_params_analysis_type(data_analysis_type);
figure_save_dir = 'Y:\\Inter-brain synchrony\\Paper\\Figures\\Resources\\';
ylimits = [-3 3];
%%


behav_analysis = 'joint';
output_data = 'all';

%%
behavior = 'Smile_auto';
behavior_data_smile_NeNoOcc = IBS_load_behavior_data(behavior,data_analysis_type,Dyad_no,condition_NeNoOcc,behav_analysis,analysis_sub_type,output_data);
plot(behavior_data_smile_NeNoOcc{1, 1}{1, 1}.mouth_size_0)
hold on
plot(behavior_data_smile_NeNoOcc{1, 2}{1, 1}.mouth_size_1)
xlim(xlimits)
ylim(ylimits)
yline(0)
figure_save_dir = 'Y:\\Inter-brain synchrony\\Paper\\Figures\\Resources\\';
exportgraphics(gcf,[figure_save_dir '\\Dyad_1_smile.eps'],'BackgroundColor','none','ContentType','vector')

figure
plot(behavior_data_smile_NeNoOcc{1, 3}{1, 1}.mouth_size_joint,'blue')
xlim(xlimits)
ylim(ylimits)
yline(0)
% exactly the same as behavior_data_body_mov_NeNoOcc{1, 3}{1, 1}.ALL_joint
% body_insta = normalize(IBS_compute_vector_angle(behavior_data_body_mov_NeNoOcc{1, 1}{1, 1}.ALL_0,behavior_data_body_mov_NeNoOcc{1, 2}{1, 1}.ALL_1));
exportgraphics(gcf,[figure_save_dir '\\Dyad_1_smile_insta.eps'],'BackgroundColor','none','ContentType','vector')


%%
behavior = 'Gaze_nose_dist';
behavior_data_eye_contact_NeNoOcc = IBS_load_behavior_data(behavior,data_analysis_type,Dyad_no,condition_NeNoOcc,behav_analysis,analysis_sub_type,output_data);

plot(behavior_data_eye_contact_NeNoOcc{1, 1}{1, 1}.eye_gaze_distance_0)
hold on
plot(behavior_data_eye_contact_NeNoOcc{1, 2}{1, 1}.eye_gaze_distance_1)
xlim(xlimits)

%%
behavior = 'video_openpose_landmarks_manual_cleaned';
behavior_data_body_mov_NeNoOcc = IBS_load_behavior_data(behavior,data_analysis_type,Dyad_no,condition_NeNoOcc,behav_analysis,analysis_sub_type,output_data);
figure
plot(behavior_data_body_mov_NeNoOcc{1, 1}{1, 1}.ALL_0)
hold on
plot(behavior_data_body_mov_NeNoOcc{1, 2}{1, 1}.ALL_1)
xlim(xlimits)
ylim(ylimits)
yline(0)
exportgraphics(gcf,[figure_save_dir '\\Dyad_1_body_movements.eps'],'BackgroundColor','none','ContentType','vector')
figure
plot(behavior_data_body_mov_NeNoOcc{1, 3}{1, 1}.ALL_joint,'blue')
xlim(xlimits)
ylim(ylimits)
yline(0)
% exactly the same as behavior_data_body_mov_NeNoOcc{1, 3}{1, 1}.ALL_joint
% body_insta = normalize(IBS_compute_vector_angle(behavior_data_body_mov_NeNoOcc{1, 1}{1, 1}.ALL_0,behavior_data_body_mov_NeNoOcc{1, 2}{1, 1}.ALL_1));
exportgraphics(gcf,[figure_save_dir '\\Dyad_1_body_movements_insta.eps'],'BackgroundColor','none','ContentType','vector')
%%

% stat_clusters = IBS_get_stat_cluster(data_analysis_type,'Brain_behavior_glm_power_freqwise');


tf_data = IBS_load_clean_IBS_tf_data(Dyad_no,data_analysis_type);

data_ica_clean_S1_tf = tf_data.data_ica_clean_S1_tf;
data_ica_clean_S2_tf = tf_data.data_ica_clean_S2_tf;
% load([sprintf('E:\\Projects\\IBS\\Data\\Processed\\no_aggressive_trialwise_CAR\\Dyd_%0.2d',Dyad_no ) '_trialwise_time_freq_no_aggressive_trialwise_CAR.mat']);


% checked that this works
% s = squeeze(mean(squeeze(data_ica_clean_S2_tf{1, condition_no_NeNoOcc_1}.powspctrm(1,:,73:95,:)),2));
% p = squeeze(combined_correlations{2, 2}  (:,14,:));
% sum(nansum(s-p))

mean_col_mat = @(x,a,b) mean(x(:,a:b,:),2);
selData = {{squeeze(data_ica_clean_S1_tf{1, condition_no_FaNoOcc_1}.powspctrm(1,:,:,:)) ...
    squeeze(data_ica_clean_S1_tf{1, condition_no_NeNoOcc_1}.powspctrm(1,:,:,:))} ...
    {squeeze(data_ica_clean_S2_tf{1, condition_no_FaNoOcc_1}.powspctrm(1,:,:,:)) ...
    squeeze(data_ica_clean_S2_tf{1, condition_no_NeNoOcc_1}.powspctrm(1,:,:,:))}} ;

% selData = {{squeeze(data_ica_clean_S1_tf{1, condition_no_NeNoOcc_1}.powspctrm(1,:,:,:))} ...
%     {squeeze(data_ica_clean_S2_tf{1, condition_no_NeNoOcc_1}.powspctrm(1,:,:,:))}} ;

[data_tf_freqwise] = IBS_convert_freqwise(selData,data_analysis_type,mean_col_mat);
% 
% [nblocks,nChan,nFreq,nTimepoints] = size(data_ica_clean_S1_tf{1, condition_no_FaNoOcc_1}.powspctrm);
% cluster_no = 2;
% % checked that all but the stat_clusters{1,1} is nan
% data_tf_freqwise = cellfun(@(x) x.*repmat(stat_clusters{1,cluster_no},[1 1 nTimepoints]),data_tf_freqwise,'UniformOutput',0);

%%
analysis_sub_type ='_insta_corr_avg_freqwise';
brain_data_sub = IBS_load_dyad_tf_insta_corr_avg_freqwise(data_analysis_type,Dyad_no,condition_NeNoOcc,analysis_sub_type);


%%
plot(squeeze(data_tf_freqwise{1,2}(61,14,:)))
hold on
plot(squeeze(data_tf_freqwise{2,2}(61,14,:)))
xlim(xlimits)
ylim(ylimits)
yline(0)
figure_save_dir = 'Y:\\Inter-brain synchrony\\Paper\\Figures\\Resources\\';
exportgraphics(gcf,[figure_save_dir '\\Dyad_1_tf_chan61_freq_14.eps'],'BackgroundColor','none','ContentType','vector')
figure
plot(normalize(squeeze(brain_data_sub{1,1}(61,:,14))),'blue')
xlim(xlimits)
ylim(ylimits)
yline(0)
exportgraphics(gcf,[figure_save_dir '\\Dyad_1_tf_chan61_freq_14_insta.eps'],'BackgroundColor','none','ContentType','vector')


%% old
%% plot example
Dyad_no = 1;
condition_FaNoOcc = 'FaNoOcc_1';
condition_NeNoOcc = 'NeNoOcc_1';
condition_NeOcc = 'NeOcc_1';
condition_no_FaNoOcc_1 = 3;
condition_no_NeNoOcc_1 = 5;
condition_no_NeOcc_1 = 4;



% data_analysis_type = 'no_aggressive_trialwise_CAR';
data_analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
% analysis_type = {'no_aggressive_CAR_ASR_5_ICA_appended_trials'};

%
% load('C:\Users\Atesh\OneDrive - Fondazione Istituto Italiano Tecnologia\Research projects 2020\Inter-brain synchrony\Results\Eye_tracking\Labeling\Dyad_05\FIVE_NearNoOcc_1_LABELS.mat')
Sub_no = [1 2];
sub_behav_table = table();
% sub_behav_table.behav_analysis = 'joint_XOR';
sub_behav_table.behav_analysis = 'joint';
sub_behav_table.analysis_sub_type ='_insta_corr_avg_freqwise';
% data_analysis_type = 'no_aggressive_trialwise_CAR';
analysis_type_params = IBS_get_params_analysis_type(data_analysis_type);

raw_data_dir = analysis_type_params.raw_data_dir{1,1};
% behavior_data_video_manual_NeNoOcc_1 = IBS_load_video_manual_labelled(Dyad_no,Sub_no,'NeNoOcc_1');
% behavior_data_video_manual_FaNoOcc_1 = IBS_load_video_manual_labelled(Dyad_no,Sub_no,'FaNoOcc_1');


behavior = 'Smile_auto';
behavior_data_smile_FaNoOcc_0 = IBS_get_sub_behavior_data(behavior,Dyad_no,0,condition_FaNoOcc,raw_data_dir,sub_behav_table);
behavior_data_smile_FaNoOcc_1 = IBS_get_sub_behavior_data(behavior,Dyad_no,1,condition_FaNoOcc,raw_data_dir,sub_behav_table);

behavior_data_smile_NeNoOcc_0 = IBS_get_sub_behavior_data(behavior,Dyad_no,0,condition_NeNoOcc,raw_data_dir,sub_behav_table);
behavior_data_smile_NeNoOcc_1 = IBS_get_sub_behavior_data(behavior,Dyad_no,1,condition_NeNoOcc,raw_data_dir,sub_behav_table);



behavior_data_smile_FaNoOcc_0 = IBS_interpolate_behavior_data(behavior_data_smile_FaNoOcc_0,'binary');
behavior_data_smile_FaNoOcc_1 = IBS_interpolate_behavior_data(behavior_data_smile_FaNoOcc_1,'binary');

behavior_data_smile_NeNoOcc_0 = IBS_interpolate_behavior_data(behavior_data_smile_NeNoOcc_0,'binary');
behavior_data_smile_NeNoOcc_1 = IBS_interpolate_behavior_data(behavior_data_smile_NeNoOcc_1,'binary');


% behavior = 'Eye_tracker_gaze';
behavior = 'Gaze-Gaze_nose_dist';
behavior_data_eye_face_FaNoOcc_0 = IBS_get_sub_behavior_data(behavior,Dyad_no,0,condition_FaNoOcc,raw_data_dir,sub_behav_table);
behavior_data_eye_face_FaNoOcc_1 = IBS_get_sub_behavior_data(behavior,Dyad_no,1,condition_FaNoOcc,raw_data_dir,sub_behav_table);

behavior_data_eye_face_NeNoOcc_0 = IBS_get_sub_behavior_data(behavior,Dyad_no,0,condition_NeNoOcc,raw_data_dir,sub_behav_table);
behavior_data_eye_face_NeNoOcc_1 = IBS_get_sub_behavior_data(behavior,Dyad_no,1,condition_NeNoOcc,raw_data_dir,sub_behav_table);



behavior_data_eye_face_FaNoOcc_0 = IBS_interpolate_behavior_data(behavior_data_eye_face_FaNoOcc_0,'binary');
behavior_data_eye_face_FaNoOcc_1 = IBS_interpolate_behavior_data(behavior_data_eye_face_FaNoOcc_1,'binary');

behavior_data_eye_face_NeNoOcc_0 = IBS_interpolate_behavior_data(behavior_data_eye_face_NeNoOcc_0,'binary');
behavior_data_eye_face_NeNoOcc_1 = IBS_interpolate_behavior_data(behavior_data_eye_face_NeNoOcc_1,'binary');


%%
behavior = 'video_openpose_landmarks_manual_cleaned';
% data_analysis_type = 'no_aggressive_trialwise_CAR';


analysis_type_params = IBS_get_params_analysis_type(data_analysis_type);

raw_data_dir = analysis_type_params.raw_data_dir{1,1};
behavior_data_movement_FaNoOcc_0 = IBS_get_sub_behavior_data(behavior,Dyad_no,0,condition_FaNoOcc,raw_data_dir,sub_behav_table);
behavior_data_movement_FaNoOcc_1 = IBS_get_sub_behavior_data(behavior,Dyad_no,1,condition_FaNoOcc,raw_data_dir,sub_behav_table);

behavior_data_movement_NeNoOcc_0 = IBS_get_sub_behavior_data(behavior,Dyad_no,0,condition_NeNoOcc,raw_data_dir,sub_behav_table);
behavior_data_movement_NeNoOcc_1 = IBS_get_sub_behavior_data(behavior,Dyad_no,1,condition_NeNoOcc,raw_data_dir,sub_behav_table);


behavior_data_movement_FaNoOcc_0 = IBS_interpolate_behavior_data(behavior_data_movement_FaNoOcc_0,'binary');
behavior_data_movement_FaNoOcc_1 = IBS_interpolate_behavior_data(behavior_data_movement_FaNoOcc_1,'binary');

behavior_data_movement_NeNoOcc_0 = IBS_interpolate_behavior_data(behavior_data_movement_NeNoOcc_0,'binary');
behavior_data_movement_NeNoOcc_1 = IBS_interpolate_behavior_data(behavior_data_movement_NeNoOcc_1,'binary');



%
%% load brain data


stat_clusters = IBS_get_stat_cluster(data_analysis_type,'Brain_behavior_glm_power_freqwise');


tf_data = IBS_load_clean_IBS_tf_data(Dyad_no,data_analysis_type);

data_ica_clean_S1_tf = tf_data.data_ica_clean_S1_tf;
data_ica_clean_S2_tf = tf_data.data_ica_clean_S2_tf;
% load([sprintf('E:\\Projects\\IBS\\Data\\Processed\\no_aggressive_trialwise_CAR\\Dyd_%0.2d',Dyad_no ) '_trialwise_time_freq_no_aggressive_trialwise_CAR.mat']);


% checked that this works
% s = squeeze(mean(squeeze(data_ica_clean_S2_tf{1, condition_no_NeNoOcc_1}.powspctrm(1,:,73:95,:)),2));
% p = squeeze(combined_correlations{2, 2}  (:,14,:));
% sum(nansum(s-p))

mean_col_mat = @(x,a,b) mean(x(:,a:b,:),2);
% selData = {{squeeze(data_ica_clean_S1_tf{1, condition_no_FaNoOcc_1}.powspctrm(1,:,:,:)) ...
%     squeeze(data_ica_clean_S1_tf{1, condition_no_NeNoOcc_1}.powspctrm(1,:,:,:))} ...
%     {squeeze(data_ica_clean_S2_tf{1, condition_no_FaNoOcc_1}.powspctrm(1,:,:,:)) ...
%     squeeze(data_ica_clean_S2_tf{1, condition_no_NeNoOcc_1}.powspctrm(1,:,:,:))}} ;

selData = {{squeeze(data_ica_clean_S1_tf{1, condition_no_FaNoOcc_1}.powspctrm(1,:,:,:)) ...
    squeeze(data_ica_clean_S1_tf{1, condition_no_NeNoOcc_1}.powspctrm(1,:,:,:)) ...
    squeeze(data_ica_clean_S1_tf{1, condition_no_NeOcc_1}.powspctrm(1,:,:,:))} ...
    {squeeze(data_ica_clean_S2_tf{1, condition_no_FaNoOcc_1}.powspctrm(1,:,:,:)) ...
    squeeze(data_ica_clean_S2_tf{1, condition_no_NeNoOcc_1}.powspctrm(1,:,:,:)) ...
    squeeze(data_ica_clean_S2_tf{1, condition_no_NeOcc_1}.powspctrm(1,:,:,:))}} ;

[data_tf_freqwise] = IBS_convert_freqwise(selData,data_analysis_type,mean_col_mat);

[nblocks,nChan,nFreq,nTimepoints] = size(data_ica_clean_S1_tf{1, condition_no_FaNoOcc_1}.powspctrm);
cluster_no = 2;
% checked that all but the stat_clusters{1,1} is nan
data_tf_freqwise = cellfun(@(x) x.*repmat(stat_clusters{1,cluster_no},[1 1 nTimepoints]),data_tf_freqwise,'UniformOutput',0);

[chans,freqs] = find(~isnan(stat_clusters{1,cluster_no}));


%%



%%
analysis_sub_type ='_insta_corr_avg_freqwise';
brain_insta_corr_sub_FaNoOcc = IBS_load_dyad_tf_insta_corr(data_analysis_type,Dyad_no,{condition_FaNoOcc},analysis_sub_type);

brain_insta_corr_sub_NeNoOcc = IBS_load_dyad_tf_insta_corr(data_analysis_type,Dyad_no,{condition_NeNoOcc},analysis_sub_type);
Dyad_no = 1;
brain_insta_corr_sub_FaNoOcc = brain_insta_corr_sub_FaNoOcc{Dyad_no};
brain_insta_corr_sub_NeNoOcc = brain_insta_corr_sub_NeNoOcc{Dyad_no};

brain_data_sub_FaNoOcc_time = 0:0.1:120;

brain_data_sub_NeNoOcc_time = 0:0.1:120;
%
cluster_no =2;
[chans,freqs] = find(~isnan(stat_clusters{1,cluster_no}));

chans = unique(chans);
% chan_no = chans(27);
chan_no = 15;% good ones with dyad 5 and chan 15,17,52
freq = unique(freqs);
freq_no = 12:14;

analysis = 'Brain_behavior_glm';


freq_bands = 1:95;
windowSize = 5;


% brain_data_sub_FaNoOcc = IBS_load_dyad_tf_moving_corr(data_analysis_type,freq_bands,windowSize,Dyad_no,{condition_FaNoOcc});
%
% brain_data_sub_NeNoOcc = IBS_load_dyad_tf_moving_corr(data_analysis_type,freq_bands,windowSize,Dyad_no,{condition_NeNoOcc});




freq_gamma = [31:95];

band_freq = 14;



%%
% combined plots more behaviors plus moving window
% smile = 1;eye_face= 1;band_passed = 1;movement = 0;all_freq= 0;
smile = 1;eye_face= 1;band_passed =0;movement = 1;all_freq= 1;

alpha_value =0.5;
figure('units','normalized','outerposition',[0 0 1 1])
subplot(4,2,1,'position',[0.13 0.85 0.37 0.05])

if smile
    
    %     area(seconds(behavior_data_video_manual_FaNoOcc_1.Time),behavior_data_video_manual_FaNoOcc_1.Smile_S1,'FaceColor','b','FaceAlpha',alpha)
    area(brain_data_sub_FaNoOcc_time,behavior_data_smile_FaNoOcc_0.mouth_size_0,'FaceColor','b','FaceAlpha',alpha_value)
    
    hold on
    area(brain_data_sub_FaNoOcc_time,behavior_data_smile_FaNoOcc_1.mouth_size_1,'FaceColor','r','FaceAlpha',alpha_value)
    yticks([0 1])
    
end
title({'FaNoOcc';'Smile'})
subplot(4,2,3,'position',[0.13 0.75 0.37 0.05])

if eye_face
    
    area(brain_data_sub_FaNoOcc_time,behavior_data_eye_face_FaNoOcc_0.eyeface_0,'FaceColor','b','FaceAlpha',alpha_value)
    hold on
    area(brain_data_sub_FaNoOcc_time,behavior_data_eye_face_FaNoOcc_1.eyeface_1,'FaceColor','r','FaceAlpha',alpha_value)
    yticks([0 1])
end
title('Eye-Face')
subplot(4,2,3,'position',[0.13 0.66 0.37 0.05])

if movement
    area(brain_data_sub_FaNoOcc_time,behavior_data_movement_FaNoOcc_0.ALL_0,'FaceColor','b','FaceAlpha',alpha_value)
    hold on
    area(brain_data_sub_FaNoOcc_time,behavior_data_movement_FaNoOcc_1.ALL_1,'FaceColor','r','FaceAlpha',alpha_value)
    
    
end
title('Movement')
subplot(4,2,5,'position',[0.13 0.38 0.37 0.25])
if all_freq
    
    h1 = plot(brain_data_sub_FaNoOcc_time,smoothdata(squeeze(nanmean(data_tf_freqwise{1,1}(chan_no,:,:))),'movmean',50));
    
    hold on
    h2 = plot(brain_data_sub_FaNoOcc_time,smoothdata(squeeze(nanmean(data_tf_freqwise{2,1}(chan_no,:,:))),'movmean',50));
    
    
%     ylabel(['channel pwr at' num2str(freq_no)])
    h1.Color(4) = alpha_value;
    h2.Color(4) = alpha_value;
end

subplot(4,2,7,'position',[0.13 0.15 0.37 0.2])

if all_freq
    %     freqs = band_freq;
    
    
    
    %     h1 = plot(data_ica_clean_S2_tf{1, 1}.time,mean(brain_data_sub_FaNoOcc_chan_all_freq(:,freqs),2)');
    %     h1 = plot(data_ica_clean_S2_tf{1, 1}.time,mean(brain_data_sub_FaNoOcc_chan_all_freq,2)');
    h1 = plot(brain_data_sub_FaNoOcc_time,mean(brain_insta_corr_sub_FaNoOcc(chan_no,:,freq_gamma),3));
    
    h1.Color(4) = alpha_value;
    yaxis([0 1]);
    %     yaxis([-0.5 0.5]);
    ylabel('power-correlation')
    xlabel('time in sec')
    % title(['mean power corr for ' num2str(band_freq) ' window ' num2str(windowSize) 's'])
    
end
% NeNoOcc
subplot(4,2,2,'position',[0.57 0.85 0.37 0.05])

if smile
    %     area(seconds(behavior_data_video_manual_NeNoOcc_1.Time),behavior_data_video_manual_NeNoOcc_1.Smile_S1,'FaceColor','b','FaceAlpha',alpha)
    area(brain_data_sub_FaNoOcc_time,behavior_data_smile_NeNoOcc_0.mouth_size_0,'FaceColor','b','FaceAlpha',alpha_value)
    
    hold on
    area(brain_data_sub_FaNoOcc_time,behavior_data_smile_NeNoOcc_1.mouth_size_1,'FaceColor','r','FaceAlpha',alpha_value)
    %     xlabel('time in sec')
    yticks([0 1])
end
title({'NeNoOcc';'Smile'})
subplot(4,2,4,'position',[0.57 0.75 0.37 0.05])

if eye_face
    area(brain_data_sub_FaNoOcc_time,behavior_data_eye_face_NeNoOcc_0.eyeface_0,'FaceColor','b','FaceAlpha',alpha_value)
    hold on
    area(brain_data_sub_FaNoOcc_time,behavior_data_eye_face_NeNoOcc_1.eyeface_1,'FaceColor','r','FaceAlpha',alpha_value)
    %     xlabel('time in sec')
    yticks([0 1])
end
title('Eye-Face')
subplot(4,2,4,'position',[0.57 0.66 0.37 0.05])
if movement
    area(brain_data_sub_FaNoOcc_time,behavior_data_movement_NeNoOcc_0.ALL_0,'FaceColor','b','FaceAlpha',alpha_value)
    hold on
    area(brain_data_sub_FaNoOcc_time,behavior_data_movement_NeNoOcc_1.ALL_1,'FaceColor','r','FaceAlpha',alpha_value)
    
    
end

title('Movement')

subplot(4,2,6,'position',[0.57 0.38 0.37 0.25])
if all_freq
    
    h1 = plot(brain_data_sub_FaNoOcc_time,smoothdata(squeeze(nanmean(data_tf_freqwise{1,2}(chan_no,:,:))),'movmean',50));
    
    hold on
    h2 = plot(brain_data_sub_FaNoOcc_time,smoothdata(squeeze(nanmean(data_tf_freqwise{2,2}(chan_no,:,:))),'movmean',50));
    
%         
%     h1 = plot(brain_data_sub_FaNoOcc_time,squeeze(nanmean(data_tf_freqwise{1,2}(chan_no,:,:)))));
%     
%     hold on
%     h2 = plot(brain_data_sub_FaNoOcc_time,squeeze(nanmean(data_tf_freqwise{2,2}(chan_no,:,:)))));
    
    
    
%     ylabel(['channel power at' num2str(freq_no)])
    %     xlabel('time in sec')
    h1.Color(4) = alpha_value;
    h2.Color(4) = alpha_value;
end




subplot(4,2,8,'position',[0.57 0.15 0.37 0.2])



if all_freq
    %     freqs = band_freq;
    alpha_value =0.5;
    
    %     h1 = plot(data_ica_clean_S2_tf{1, 1}.time,mean(brain_data_sub_NeNoOcc_chan_all_freq(:,freqs),2)');
    %     h1 = plot(data_ica_clean_S2_tf{1, 1}.time,mean(brain_data_sub_NeNoOcc_chan_all_freq,2)');
    
    h1 = plot(brain_data_sub_FaNoOcc_time,mean(brain_insta_corr_sub_NeNoOcc(chan_no,:,freq_gamma),3));
    
    h1.Color(4) = alpha_value;
    yaxis([0 1]);
    %     yaxis([-0.5 0.5]);
    
    ylabel('power correlation')
    xlabel('time in sec')
    % title(['mean power corr for ' num2str(band_freq) ' window ' num2str(windowSize) 's'])
    
end
