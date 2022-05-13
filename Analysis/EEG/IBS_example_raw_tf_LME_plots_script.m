Dyad_no = 1;
condition_FaNoOcc = 'FaNoOcc_1';
condition_NeNoOcc = 'NeNoOcc_1';
condition_no_FaNoOcc_1 = 3;
condition_no_NeNoOcc_1 = 5;
chan_no = 62;


% data_analysis_type = 'no_aggressive_trialwise_CAR';
data_analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
% analysis_type = {'no_aggressive_CAR_ASR_5_ICA_appended_trials'};
%%

raw_data = IBS_load_clean_IBS_data(Dyad_no,data_analysis_type);

%%
analysis_params = IBS_get_params_analysis_type(data_analysis_type);
save_fig_dir = analysis_params.analysis_save_dir_figures{1,1};
%%
sel_time = (2048*21):(2048*22);
figure('units','normalized','outerposition',[0 0 1 1])
plot(raw_data.data_ica_clean_S1{1, 2}.time{1, 3}(sel_time),raw_data.data_ica_clean_S1{1, 2}.trial{1, 3}(chan_no,sel_time))
ylim([-45,45])
ax = gca;

exportgraphics(ax,[save_fig_dir 'raw_data_S1.eps'],'BackgroundColor','none','ContentType','vector')

%%
sel_time = (2048*21):(2048*22);
figure('units','normalized','outerposition',[0 0 1 1])
plot(raw_data.data_ica_clean_S1{1, 2}.time{1, 1}(sel_time),raw_data.data_ica_clean_S1{1, 2}.trial{1, 1}(chan_no,sel_time))
ylim([-45,45])
ax = gca;

exportgraphics(ax,[save_fig_dir 'raw_data_S1_FaNoOcc.eps'],'BackgroundColor','none','ContentType','vector')

sel_time = (2048*21):(2048*22);
figure('units','normalized','outerposition',[0 0 1 1])
plot(raw_data.data_ica_clean_S1{1, 2}.time{1, 2}(sel_time),raw_data.data_ica_clean_S1{1, 2}.trial{1, 2}(chan_no,sel_time))
ylim([-45,45])
ax = gca;

exportgraphics(ax,[save_fig_dir 'raw_data_S1_FaOcc.eps'],'BackgroundColor','none','ContentType','vector')

sel_time = (2048*21):(2048*22);
figure('units','normalized','outerposition',[0 0 1 1])
plot(raw_data.data_ica_clean_S1{1, 2}.time{1, 4}(sel_time),raw_data.data_ica_clean_S1{1, 2}.trial{1, 4}(chan_no,sel_time))
ylim([-45,45])
ax = gca;

exportgraphics(ax,[save_fig_dir 'raw_data_S1_NeOcc.eps'],'BackgroundColor','none','ContentType','vector')






%%
%%
sel_time = (2048*21):(2048*22);
figure('units','normalized','outerposition',[0 0 1 1])
plot(raw_data.data_ica_clean_S1{1, 2}.time{1, 3}(sel_time),raw_data.data_ica_clean_S1{1, 2}.trial{1, 3}(chan_no,sel_time))
hold on
plot(raw_data.data_ica_clean_S2{1, 2}.time{1, 3}(sel_time),raw_data.data_ica_clean_S2{1, 2}.trial{1, 3}(chan_no,sel_time))
ylim([-45,45])
ax = gca;


exportgraphics(ax,[save_fig_dir 'raw_data_S1_S2.eps'],'BackgroundColor','none','ContentType','vector')


%%
tf_data = IBS_load_clean_IBS_tf_data(Dyad_no,data_analysis_type);

data_ica_clean_S1_tf = tf_data.data_ica_clean_S1_tf;
data_ica_clean_S2_tf = tf_data.data_ica_clean_S2_tf;

%%
t_o_i = [19.9 21.1];

IBS_plot_tf(data_ica_clean_S1_tf{1, 5},'IBS_S1_layout_64.mat',chan_no,t_o_i)
colormap(flipud(brewermap(64,'RdBu')));
ax = gca;
exportgraphics(ax,[save_fig_dir 'tf_S1_NeNoOcc.eps'],'BackgroundColor','none','ContentType','vector')


IBS_plot_tf(data_ica_clean_S2_tf{1, 5},'IBS_S2_layout_64.mat',chan_no,t_o_i)
colormap(flipud(brewermap(64,'RdBu')));
ax = gca;
exportgraphics(ax,[save_fig_dir 'tf_S2_NeNoOcc.eps'],'BackgroundColor','none','ContentType','vector')
%%
figure('units','normalized','outerposition',[0 0 1 1])
s1 = squeeze(data_ica_clean_S1_tf{1, 5}.powspctrm(1,chan_no,:,:));
time = 0:0.1:120;
freq_values = [1 5 10 19 52];
sel_time = 1:300;
for freq = 1:length(freq_values)
%     subplot(length(freq_values),1,freq)
    plot(time(sel_time),s1(freq_values(freq),sel_time)+freq_values(freq)+2,'b')
    hold on
    
end

ax = gca;
exportgraphics(ax,[save_fig_dir 'tf_S1_NeNoOcc_5_freq.eps'],'BackgroundColor','none','ContentType','vector')

close all
s2 = squeeze(data_ica_clean_S2_tf{1, 5}.powspctrm(1,chan_no,:,:));
time = 0:0.1:120;
freq_values = [1 5 10 19 52];
figure('units','normalized','outerposition',[0 0 1 1])
sel_time = 1:300;
for freq = 1:length(freq_values)
%     subplot(length(freq_values),1,freq)
    plot(time(sel_time),s2(freq_values(freq),sel_time)+freq_values(freq)+2,'r')

%     plot(time(sel_time),s2(freq_values(freq),sel_time)*freq_values(freq),'r')
    hold on
    
end

ax = gca;
exportgraphics(ax,[save_fig_dir 'tf_S2_NeNoOcc_5_freq.eps'],'BackgroundColor','none','ContentType','vector')

%%







%%

t_o_i = [19.9 21.1];

IBS_plot_tf(data_ica_clean_S1_tf{1, 2},'IBS_S1_layout_64.mat',chan_no,t_o_i)
colormap(flipud(brewermap(64,'RdBu')));
ax = gca;
exportgraphics(ax,[save_fig_dir 'tf_S1_FaOcc.eps'],'BackgroundColor','none','ContentType','vector')

t_o_i = [19.9 21.1];

IBS_plot_tf(data_ica_clean_S1_tf{1, 3},'IBS_S1_layout_64.mat',chan_no,t_o_i)
colormap(flipud(brewermap(64,'RdBu')));
ax = gca;
exportgraphics(ax,[save_fig_dir 'tf_S1_FaNoOcc.eps'],'BackgroundColor','none','ContentType','vector')

t_o_i = [19.9 21.1];

IBS_plot_tf(data_ica_clean_S1_tf{1, 4},'IBS_S1_layout_64.mat',chan_no,t_o_i)
colormap(flipud(brewermap(64,'RdBu')));
ax = gca;
exportgraphics(ax,[save_fig_dir 'tf_S1_NeOcc.eps'],'BackgroundColor','none','ContentType','vector')

IBS_plot_tf(data_ica_clean_S1_tf{1, 5},'IBS_S1_layout_64.mat',chan_no,t_o_i)
colormap(flipud(brewermap(64,'RdBu')));
ax = gca;
exportgraphics(ax,[save_fig_dir 'tf_S1_NeNoOcc.eps'],'BackgroundColor','none','ContentType','vector')
%%

brain_insta_corr_sub_NeNoOcc = IBS_load_dyad_tf_insta_corr(data_analysis_type,Dyad_no,{condition_NeNoOcc});
s1 = smoothdata(mean(squeeze(brain_insta_corr_sub_NeNoOcc{1, 1}(chan_no,:,52:73)),2),'movmean',50);
figure('units','normalized','outerposition',[0 0 1 1])
time = 0:0.1:120;
plot(time,s1);

ax = gca;
exportgraphics(ax,[save_fig_dir 'insta_corr_NeNoOcc.eps'],'BackgroundColor','none','ContentType','vector')
%%

Dyad_no = 14;
% load('C:\Users\Atesh\OneDrive - Fondazione Istituto Italiano Tecnologia\Research projects 2020\Inter-brain synchrony\Results\Eye_tracking\Labeling\Dyad_05\FIVE_NearNoOcc_1_LABELS.mat')
Sub_no = [1 2];
sub_behav_table = table();
sub_behav_table.behav_analysis = 'joint';
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

behavior = 'Gaze_nose_dist';

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

%%
figure('units','normalized','outerposition',[0 0 1 1])
plot(time,smoothdata(behavior_data_smile_NeNoOcc_0.mouth_size_0,'movmean',50))
hold on

plot(time,smoothdata(behavior_data_smile_NeNoOcc_1.mouth_size_1,'movmean',50))
ax = gca;
exportgraphics(ax,[save_fig_dir 'mouth_sizes_NeNoOcc.eps'],'BackgroundColor','none','ContentType','vector')

%%

figure('units','normalized','outerposition',[0 0 1 1])
plot(time,smoothdata(behavior_data_eye_face_NeNoOcc_0.eye_gaze_distance_0,'movmean',50))
hold on
plot(time,smoothdata(behavior_data_eye_face_NeNoOcc_1.eye_gaze_distance_1,'movmean',50))
ax = gca;
exportgraphics(ax,[save_fig_dir 'gaze_nose_NeNoOcc.eps'],'BackgroundColor','none','ContentType','vector')

%%
figure('units','normalized','outerposition',[0 0 1 1])
plot(time,smoothdata(behavior_data_movement_NeNoOcc_0.ALL,'movmean',50))
hold on
plot(time,smoothdata(behavior_data_movement_NeNoOcc_1.ALL,'movmean',50))
ax = gca;
exportgraphics(ax,[save_fig_dir 'mov_all_NeNoOcc.eps'],'BackgroundColor','none','ContentType','vector')


%%


behaviors = {'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned'};

% behaviors = {'Smile_auto'};
behav_analysis = 'joint';
behavior_data = cellfun(@(x) IBS_load_behavior_data(x,data_analysis_type,Dyad_no,{condition_NeNoOcc},behav_analysis,'all'),...
    behaviors,'UniformOutput',false);



%%
figure('units','normalized','outerposition',[0 0 1 1])
plot(time,behavior_data{1, 1}{1, 3}{1,Dyad_no}.eye_gaze_distance_joint)    
ax = gca;
exportgraphics(ax,[save_fig_dir 'gaze_moving_corr.eps'],'BackgroundColor','none','ContentType','vector')


figure('units','normalized','outerposition',[0 0 1 1])
plot(time,behavior_data{1, 2}{1, 3}{1,Dyad_no}.mouth_size_joint)    
ax = gca;
exportgraphics(ax,[save_fig_dir 'mouth_moving_corr.eps'],'BackgroundColor','none','ContentType','vector')

figure('units','normalized','outerposition',[0 0 1 1])
plot(time,behavior_data{1, 3}{1, 3}{1,Dyad_no}.ALL)    
ax = gca;
exportgraphics(ax,[save_fig_dir 'all_mov_moving_corr.eps'],'BackgroundColor','none','ContentType','vector')
close all