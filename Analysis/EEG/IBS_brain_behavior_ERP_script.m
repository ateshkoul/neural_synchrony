clear
analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
behaviors = {'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned'};
% conditions = {{'NeNoOcc_1' 'NeNoOcc_2' 'NeNoOcc_3'} {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3'}};
conditions = {{'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'}};

analysis_sub_type = '_insta';
analysis_sub_type = '_insta_corr_avg_freqwise';

cellfun(@(z) cellfun(@(y) IBS_brain_behavior_behav_crosscorr(analysis_type,y,z,analysis_sub_type),behaviors),conditions)

%%
clear
analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
analysis_sub_type = {'_insta_abs_detrend'};
% analysis_sub_type = {'_insta_abs_detrend','_insta_abs_detrend_corr_avg_freqwise'};
% analysis_sub_type = {'_insta_abs_detrend_corr_avg_freqwise'};
analysis_sub_type = {'_insta_abs_detrend_gamma_200avg_lowess'};
analysis_sub_type = {'_insta_abs_detrend_lowess_variable'};% 

% conditions = {{'NeNoOcc_1' 'NeNoOcc_2' 'NeNoOcc_3'} {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3'}};
conditions = {{'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'}};

behaviors = {'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned'};
behaviors = {'Smile_auto'};
% behaviors = {'video_openpose_landmarks_manual_cleaned'};
% behaviors = {'Gaze_nose_dist'};
% cellfun(@(t) cellfun(@(z) cellfun(@(y) arrayfun(@(x) IBS_brain_behavior_crosscorr(analysis_type,y,x,z,t,'glm'),1:3),behaviors),conditions),analysis_sub_type);
cellfun(@(t) cellfun(@(z) cellfun(@(y) arrayfun(@(x) IBS_brain_behavior_crosscorr(analysis_type,y,x,z,t,'glm'),2),behaviors),conditions),analysis_sub_type);

% behaviors = {'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned',...
%         'Gaze_nose_dist-Smile_auto','Gaze_nose_dist-video_openpose_landmarks_manual_cleaned'};
% cellfun(@(t) cellfun(@(z) cellfun(@(y) arrayfun(@(x) IBS_brain_behavior_crosscorr(analysis_type,y,x,z,t,'glm_mod'),1:3),behaviors),conditions),analysis_sub_type);

%%

clear
analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
% analysis_sub_type = {'_insta_abs_detrend_mov_1s'};
% analysis_sub_type = {'_insta_abs_detrend','_insta_abs_detrend_corr_avg_freqwise'};
% analysis_sub_type = {'_insta_abs_detrend_corr_avg_freqwise'};
analysis_sub_type = {'_insta_abs_detrend'};


% conditions = {{'NeNoOcc_1' 'NeNoOcc_2' 'NeNoOcc_3'} {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3'}};
conditions = {{'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'}};

behaviors = {'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned'};
behaviors = {'Smile_auto'};
% behaviors = {'video_openpose_landmarks_manual_cleaned'};
% behaviors = {'Gaze_nose_dist'};
% cellfun(@(t) cellfun(@(z) cellfun(@(y) arrayfun(@(x) IBS_brain_behavior_crosscorr(analysis_type,y,x,z,t,'glm'),1:3),behaviors),conditions),analysis_sub_type);
cellfun(@(t) cellfun(@(z) cellfun(@(y) arrayfun(@(x) IBS_brain_behavior_crosscorr(analysis_type,y,x,z,t,'glm'),2),behaviors),conditions),analysis_sub_type);

% behaviors = {'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned',...
%         'Gaze_nose_dist-Smile_auto','Gaze_nose_dist-video_openpose_landmarks_manual_cleaned'};
% cellfun(@(t) cellfun(@(z) cellfun(@(y) arrayfun(@(x) IBS_brain_behavior_crosscorr(analysis_type,y,x,z,t,'glm_mod'),1:3),behaviors),conditions),analysis_sub_type);

%%
clear
analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
behaviors = {'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned'};
behaviors = {'Eye_tracker_pupil','Smile_auto','video_openpose_landmarks_manual_cleaned'};

% behaviors = {'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned',...
%         'Gaze_nose_dist-Smile_auto','Gaze_nose_dist-video_openpose_landmarks_manual_cleaned'};
% behaviors = {'Gaze_nose_dist-video_openpose_landmarks_manual_cleaned'};
% analysis_sub_type = '_insta';
% analysis_sub_type = '_insta_20_data_smoothed';
% analysis_sub_type = {'_insta_avg_freqwise','_insta_20_data_smoothed','_insta','_insta_20','_insta_50','_IBS_moving_win'};
% analysis_sub_type = {'_insta_avg_freqwise','_insta_20_data_smoothed','_insta','_insta_20'};

% analysis_sub_type = {'_insta'};
% analysis_sub_type = {'_insta_corr_avg_freqwise'};
% analysis_sub_type = {'_insta_abs_behav_corr_avg_freqwise'};
% analysis_sub_type = {'_insta_abs_no_detrend_behav_corr_avg_freqwise'};
% analysis_sub_type = {'_insta_abs_detrend_corr_avg_freqwise'};
analysis_sub_type = {'_insta_abs_detrend'};

% analysis_sub_type = {'_insta_abs_no_detrend'};
% analysis_sub_type = {'_insta_abs_corr_avg_freqwise','_insta_abs_behav_corr_avg_freqwise','_insta_abs_no_detrend_behav_corr_avg_freqwise'};


% conditions = {{'NeNoOcc_1' 'NeNoOcc_2' 'NeNoOcc_3'} {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3'}};
conditions = {{'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'}};
cellfun(@(t) cellfun(@(z) cellfun(@(y) arrayfun(@(x) IBS_brain_behavior_crosscorr(analysis_type,y,x,z,t,'glm'),2),behaviors),conditions),analysis_sub_type);

%%

analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
behaviors = {'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned'};

% analysis_sub_type = '_insta_corr_avg_freqwise';
% analysis_sub_type = '_insta_abs_behav_corr_avg_freqwise';
% analysis_sub_type = '_insta_abs_detrend_behav_corr_avg_freqwise';
% analysis_sub_type = '_insta_abs_no_detrend_behav_corr_avg_freqwise';
% analysis_sub_type = '_insta_abs_corr_avg_freqwise';
% analysis_sub_type = '_insta_abs_behav_neg_corr_avg_freqwise';
% analysis_sub_type = '_insta_abs_detrend_corr_avg_freqwise';
analysis_sub_type = '_insta_abs_detrend';
% analysis_sub_type = '_insta_abs_no_detrend';
conditions = {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'};

IBS_brain_behavior_crosscorr(analysis_type,'Gaze_nose_dist',1,conditions,analysis_sub_type)

IBS_brain_behavior_crosscorr(analysis_type,'Gaze_nose_dist',2,conditions,analysis_sub_type)

IBS_brain_behavior_crosscorr(analysis_type,'video_openpose_landmarks_manual_cleaned',1,conditions,analysis_sub_type)

IBS_brain_behavior_crosscorr(analysis_type,'video_openpose_landmarks_manual_cleaned',2,conditions,analysis_sub_type)
IBS_brain_behavior_crosscorr(analysis_type,'Smile_auto',1,conditions,analysis_sub_type)

IBS_brain_behavior_crosscorr(analysis_type,'Smile_auto',2,conditions,analysis_sub_type)

IBS_brain_behavior_crosscorr(analysis_type,'Gaze_nose_dist',3,conditions,analysis_sub_type)

IBS_brain_behavior_crosscorr(analysis_type,'video_openpose_landmarks_manual_cleaned',3,conditions,analysis_sub_type)

IBS_brain_behavior_crosscorr(analysis_type,'Smile_auto',3,conditions,analysis_sub_type)



%%
conditions = {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'};
analysis_sub_type = '_insta_abs_detrend';

IBS_brain_behavior_crosscorr('no_aggressive_CAR_ASR_10_ICA_appended_trials','EDA',1,conditions,analysis_sub_type,'physio')
%%
analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
analysis = 'Brain_behavior_glm_power_freqwise';
conditions = {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'};
analysis_sub_type = '_insta_corr_avg_freqwise';
[glm_result_AND,glm_result_XOR] = IBS_brain_behavior_glm_binary(analysis_type,analysis,conditions,analysis_sub_type,'no_plots');
cluster_no = 1;
glm_data_AND = glm_result_AND.stats_cell{cluster_no}.Variables;
glm_data_XOR = glm_result_XOR.stats_cell{cluster_no}.Variables;

%%
func = @(x) 0.5*log((1 + x)/(1 - x));
xcf_mouth_joint_mat = arrayfun(@(x) func(x),xcf_mouth_joint_mat);

% xcf_mouth_joint_mat_ftrans = arrayfun(@(x) arrayfun(@(y) func(xcf_mouth_joint_mat(x,y)),1:size(xcf_mouth_joint_mat,2)),1:size(xcf_mouth_joint_mat,1),'UniformOutput',false);
% 
% xcf_mouth_joint_mat_ftrans = cat(1,xcf_mouth_joint_mat_ftrans{:});


for i = 1:(size(xcf_mouth_joint_mat,2)-1)/2-1
[h,p] = ttest(xcf_mouth_joint_mat(:,(size(xcf_mouth_joint_mat,2)-1)/2-i),xcf_mouth_joint_mat(:,(size(xcf_mouth_joint_mat,2)-1)/2+i));
p_all(i) = p;
end
figure;plot(p_all)

[p_fdr, p_masked] = fdr( p_all, 0.05);

%%
[h,p] = ttest(mean(xcf_mouth_joint_mat(:,1:(size(xcf_mouth_joint_mat,2)-1)/2),2),...
    mean(xcf_mouth_joint_mat(:,(size(xcf_mouth_joint_mat,2)-1)/2+2:size(xcf_mouth_joint_mat,2)),2));


%% kind of for phase reset
clear
behavior = 'Smile_auto';
behav_analysis = 'joint_XOR';
output_data = 'all';
analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
Dyads = 1;
conditions = {'NeNoOcc_1'};
analysis_sub_type = '_insta';
mouth_size = IBS_load_behavior_data(behavior,analysis_type,Dyads,conditions,behav_analysis,analysis_sub_type,output_data);
minwindow = 10;
analysis_type_params = IBS_get_params_analysis_type(analysis_type);
data_dir = analysis_type_params.data_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';

for dyd_no = 1:length(Dyads)
    dyad_str = sprintf('Dyad_%0.2d',Dyads(dyd_no));
    data = IBS_load_clean_IBS_data(Dyads(dyd_no),analysis_type,data_dir);
    s1 = IBS_compute_sudden_changes(double(mouth_size{1, 1}{1, Dyads(dyd_no)}.Fun_mouth_size_0),minwindow,'all');
    s2 = IBS_compute_sudden_changes(double(mouth_size{1, 2}{1, Dyads(dyd_no)}.Fun_mouth_size_1),minwindow,'all');
    
    
    
    data.data_ica_clean_S1{1,2}.trial{1,3}
    
end

cfg_select.trials = 3;
cur_data = ft_selectdata(cfg_select,data.data_ica_clean_S1{1,2});

cur_data = IBS_resampledata(cur_data,10);

cfg.latency = [0 120];
cur_data = ft_selectdata(cfg,cur_data);

smile_spike = zeros(1,length(cur_data.trial{1,1}));

smile_spike(s1.increase{1,1}) = 1;

cur_data.trial{1,1}(65,:) = smile_spike;
cur_data.label{65} = 'smile';

cfg              = [];
cfg.method       = 'mtmfft';
cfg.foilim       = [72 95]; % cfg.timwin determines spacing
cfg.timwin       = [-0.05 0.05]; % time window of 100 msec
cfg.taper        = 'hanning';
cfg.spikechannel = 'smile';
cfg.channel      = cur_data.label;
stsFFT           = ft_spiketriggeredspectrum(cfg, cur_data);



%%
cfg           = [];
cfg.method    = 'mtmconvol';
cfg.foi       = 72:95;
cfg.t_ftimwin = 5./cfg.foi; % 5 cycles per frequency
cfg.taper     = 'hanning';
stsConvol     = ft_spiketriggeredspectrum(cfg, cur_data);

param = 'plv'; % set the desired parameter
for k = 1:length(stsConvol.label)
    cfg                = [];
    cfg.method         = param;
    excludeChan        = 65; % this gives us the electrode number of the unit
    chan = true(1,4);
    chan(excludeChan)  = false;
    cfg.spikechannel   = stsConvol.label{k};
    cfg.channel        = stsConvol.lfplabel(chan);
    cfg.avgoverchan    = 'unweighted';
    cfg.winstepsize    = 0.01; % step size of the window that we slide over time
    cfg.timwin         = 0.5; % duration of sliding window
    statSts            = ft_spiketriggeredspectrum_stat(cfg,stsConvol);
    
    statSts.(param) = permute(conv2(squeeze(statSts.(param)), ones(1,20)./20, 'same'),[3 1 2]); % apply some smoothing over 0.2 sec
    
    figure
    cfg            = [];
    cfg.parameter  = param;
    cfg.refchannel = statSts.labelcmb{1,1};
    cfg.channel    = statSts.labelcmb{1,2};
    cfg.xlim       = [-1 2];
    ft_singleplotTFR(cfg, statSts)
end
%% phase reset contd

Dyads = 1;%1:23
conditions = {'NeNoOcc_1' };
% conditions = {'FaNoOcc_1' };
behavior = 'Smile_auto';
% behavior = 'video_openpose_landmarks_manual_cleaned';
% behavior = 'Gaze_nose_dist';
behav_analysis = 'joint_XOR'; % it doesn't matter whether it is XOR or AND
output_data = 'all';
analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
lag_no = [];
% analysis_sub_type = '_insta';
% analysis_sub_type = '_insta_avg_freqwise';
% analysis_sub_type = '_insta_20_data_smoothed';,'Smile_auto',
analysis_sub_type = '_insta_20';
mouth_size = IBS_load_behavior_data('Smile_auto',analysis_type,Dyads,conditions,behav_analysis,analysis_sub_type,output_data);
gaze_nose = IBS_load_behavior_data('Eye_tracker_gaze',analysis_type,Dyads,conditions,behav_analysis,analysis_sub_type,output_data);
all_mov = IBS_load_behavior_data('video_openpose_landmarks_manual_cleaned',analysis_type,Dyads,conditions,behav_analysis,analysis_sub_type,output_data);

%%
dyd_no = 1;
analysis_type_params = IBS_get_params_analysis_type(analysis_type);
data_dir = analysis_type_params.data_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
data = IBS_load_clean_IBS_tf_data(Dyads(dyd_no),analysis_type,data_dir);
%%
s1 = squeeze(data.data_ica_clean_S1_tf{1, 5}.powspctrm(1,:,:,:));
s2 = squeeze(data.data_ica_clean_S2_tf{1, 5}.powspctrm(1,:,:,:));

s1 = IBS_compute_freqwise('no_aggressive_CAR_ASR_10_ICA_appended_trials',s1);
s2 = IBS_compute_freqwise('no_aggressive_CAR_ASR_10_ICA_appended_trials',s2);


mapObj = containers.Map({'Eye_tracker_gaze','Smile_auto','video_openpose_landmarks_manual_cleaned'},...
    {'Fun_eyeface','Fun_mouth_size','Fun_ALL'});
chan_no =60;
freq_range = 12:14;

subplot(2,1,1)
plot(double(mouth_size{1, 1}{1, Dyads(dyd_no)}.Fun_mouth_size_0)-1)
hold on
% plot(double(gaze_nose{1, 1}{1, Dyads(dyd_no)}.([mapObj('Eye_tracker_gaze') '_0']) )-1)
% plot(double(all_mov{1, 1}{1, Dyads(dyd_no)}.([mapObj('video_openpose_landmarks_manual_cleaned') '_0']))-1)


plot(normalize(mean(squeeze(s1(chan_no,freq_range,:)))'))



subplot(2,1,2)
plot(double(mouth_size{1, 2}{1, Dyads(dyd_no)}.Fun_mouth_size_1)-1)
hold on
plot(normalize(mean(squeeze(s2(chan_no,freq_range,:)))'))
%%
plot(normalize(ft_preproc_hilbert(nanmean(squeeze(s1(chan_no,freq_range,1:1200))),'angle')))
hold on
plot(double(mouth_size{1, 1}{1, Dyads(dyd_no)}.Fun_mouth_size_0)-1)


plot(normalize(ft_preproc_hilbert(nanmean(squeeze(s2(chan_no,freq_range,1:1200))),'angle')))
hold on
plot(double(mouth_size{1, 2}{1, Dyads(dyd_no)}.Fun_mouth_size_1)-1)

%%


plot(gaze_nose{1, 1}{1, Dyads(dyd_no)}.([mapObj('Eye_tracker_gaze') '_0']))
plot(all_mov{1, 1}{1, Dyads(dyd_no)}.([mapObj('video_openpose_landmarks_manual_cleaned') '_0']))


plot(normalize(mean(squeeze(s1(chan_no,35:95,:)))'))


%% what happens to power freq when someone else smiles?

%% load smile events
clear
Dyads = 1;%1:23
conditions = {'NeNoOcc_1' };
% conditions = {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'};

% conditions = {'FaNoOcc_1' };
behavior = 'Smile_auto';
% behavior = 'video_openpose_landmarks_manual_cleaned';
% behavior = 'Gaze_nose_dist';
behav_analysis = 'joint'; % it doesn't matter whether it is XOR or AND
output_data = 'all';
analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
lag_no = [];
% analysis_sub_type = '_insta';
% analysis_sub_type = '_insta_avg_freqwise';
% analysis_sub_type = '_insta_20_data_smoothed';
analysis_sub_type = '_insta_20';
mouth_size = IBS_load_behavior_data(behavior,analysis_type,Dyads,conditions,behav_analysis,analysis_sub_type,output_data);
dyd_no = 1;
mapObj = containers.Map({'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned'},...
    {'eye_gaze_distance','mouth_size','ALL'});
figure;
plot(mouth_size{1, 1}{1, Dyads(dyd_no)}.([mapObj(behavior) '_0']))
hold on
plot(mouth_size{1, 2}{1, Dyads(dyd_no)}.([mapObj(behavior) '_1']))

% plot(smoothdata(mouth_size{1, 1}{1, Dyads(dyd_no)}.([mapObj(behavior) '_0']),'movmean',20))
% hold on
% plot(smoothdata(mouth_size{1, 2}{1, Dyads(dyd_no)}.([mapObj(behavior) '_1']),'movmean',20))


plot(mouth_size{1, 3}{1, Dyads(dyd_no)}.([mapObj(behavior) '_joint']))

%%
clear
Dyads = 1;%1:23
conditions = {'NeNoOcc_1' };
% conditions = {'FaNoOcc_1' };
behav_analysis = 'joint'; % it doesn't matter whether it is XOR or AND
output_data = 'all';
analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
% behavior = 'video_openpose_landmarks_manual_cleaned';
% behavior = 'Gaze_nose_dist';
analysis_sub_type = '_insta';
mapObj = containers.Map({'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned'},...
    {'eye_gaze_distance','mouth_size','ALL'});
mouth_size = IBS_load_behavior_data('Smile_auto',analysis_type,Dyads,conditions,behav_analysis,analysis_sub_type,output_data);
gaze_nose = IBS_load_behavior_data('Gaze_nose_dist',analysis_type,Dyads,conditions,behav_analysis,analysis_sub_type,output_data);
all_mov = IBS_load_behavior_data('video_openpose_landmarks_manual_cleaned',analysis_type,Dyads,conditions,behav_analysis,analysis_sub_type,output_data);

dyd_no = 1;

s_mouth = mouth_size{1, 1}{1, Dyads(dyd_no)}.([mapObj('Smile_auto') '_0']);
s_gaze = gaze_nose{1, 1}{1, Dyads(dyd_no)}.([mapObj('Gaze_nose_dist') '_0']);
s_mov = all_mov{1, 1}{1, Dyads(dyd_no)}.([mapObj('video_openpose_landmarks_manual_cleaned') '_0']);

s_mouth(isnan(s_mouth)) = 0;
s_gaze(isnan(s_gaze)) = 0;

plot(xcov(s_gaze,s_mouth,200,'coeff'))
xline(200)
figure;
plot(mouth_size{1, 1}{1, Dyads(dyd_no)}.([mapObj('Smile_auto') '_0']))
hold on
plot(mouth_size{1, 2}{1, Dyads(dyd_no)}.([mapObj('Smile_auto') '_1']))
figure;
plot(gaze_nose{1, 1}{1, Dyads(dyd_no)}.([mapObj('Gaze_nose_dist') '_0']))
hold on
plot(gaze_nose{1, 2}{1, Dyads(dyd_no)}.([mapObj('Gaze_nose_dist') '_1']))

figure;
plot(all_mov{1, 1}{1, Dyads(dyd_no)}.([mapObj('video_openpose_landmarks_manual_cleaned') '_0']))
hold on
plot(all_mov{1, 2}{1, Dyads(dyd_no)}.([mapObj('video_openpose_landmarks_manual_cleaned') '_1']))

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
analysis_sub_type = '_insta';
cur_behav = 'Smile_auto';
behav_data = IBS_load_behavior_data('Smile_auto',analysis_type,Dyads,conditions,behav_analysis,analysis_sub_type,output_data);
% gaze_nose = IBS_load_behavior_data('Eye_tracker_gaze',analysis_type,Dyads,conditions,behav_analysis,analysis_sub_type,output_data);
% all_mov = IBS_load_behavior_data('video_openpose_landmarks_manual_cleaned',analysis_type,Dyads,conditions,behav_analysis,analysis_sub_type,output_data);


%% load time-freq data

% this overall doesn't work well because phase reset probably is different
% across different individual 
analysis_type_params = IBS_get_params_analysis_type(analysis_type);
data_dir = analysis_type_params.data_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
minwindow = 10;
mapObj = containers.Map({'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned'},...
    {'Fun_eye_gaze_distance','Fun_mouth_size','Fun_ALL_joint'});
condition_starts = [0 1201 1201*2 1201*3 1201*4 1201*5 1201*6 1201*7];
pre_samples = 49;
post_samples = 50;
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
behav_1_pre_post_combined_cond = cell(length(Dyads),length(conditions));
behav_2_pre_post_combined_cond = cell(length(Dyads),length(conditions));

for dyd_no = 1:length(Dyads)
    data = IBS_load_clean_IBS_tf_data(Dyads(dyd_no),analysis_type,data_dir);
    
    S1_value = behav_data{1}{Dyads(dyd_no)};
    S2_value = behav_data{2}{Dyads(dyd_no)};
         cur_behav_1 = S1_value.([mapObj(cur_behav) '_0']);
      cur_behav_2 = S2_value.([mapObj(cur_behav) '_1']);

      
    for cond = 1:length(conditions)

      cur_cond_behav_1 = cur_behav_1((condition_starts(cond)+1):condition_starts(cond+1));
      
      cur_cond_behav_2 = cur_behav_2((condition_starts(cond)+1):condition_starts(cond+1));
      
%     s1 = IBS_compute_sudden_changes(double(mouth_size{1, 1}{1, Dyads(dyd_no)}.Fun_mouth_size_0),minwindow,'all');
%     s2 = IBS_compute_sudden_changes(double(mouth_size{1, 2}{1, Dyads(dyd_no)}.Fun_mouth_size_1),minwindow,'all');
    
    s1 = IBS_compute_sudden_changes(double(cur_cond_behav_1),minwindow,'all');
    s2 = IBS_compute_sudden_changes(double(cur_cond_behav_2),minwindow,'all');

    %         local_max = sort([s1.increase{1,1}' s2.increase{1,1}']);
    
    s1_increase = s1.increase{1,1};
    s2_increase = s2.increase{1,1};
    
    
    behav_1_pre_post = cell(1,100);
    behav_2_pre_post = cell(1,100);
    behav_coh_pre_post = cell(1,100);
    
    
%     cur_data_S1 = squeeze(data.data_ica_clean_S1_tf{1, 5}.powspctrm(1,:,:,:));
%     cur_data_S2 = squeeze(data.data_ica_clean_S2_tf{1, 5}.powspctrm(1,:,:,:));
%     
    cur_data_S1 = squeeze(data.data_ica_clean_S1_tf{1,condition_nos(cond)}.powspctrm(block_nos(cond),:,:,:));
    cur_data_S2 = squeeze(data.data_ica_clean_S2_tf{1, condition_nos(cond)}.powspctrm(block_nos(cond),:,:,:));
    
    
    cur_data_S1 = arrayfun(@(x) ft_preproc_hilbert(squeeze(cur_data_S1(:,x,1:1201-5)),'angle'),1:95,'UniformOutput',0);
    cur_data_S2 = arrayfun(@(x) ft_preproc_hilbert(squeeze(cur_data_S2(:,x,1:1201-5)),'angle'),1:95,'UniformOutput',0);
    
    
    cur_data_S1 = cat(3,cur_data_S1{:});
    
    cur_data_S2= cat(3,cur_data_S2{:});
    
    %% do circular average instead 
    
    cur_data_S1 =permute(cur_data_S1,[1 3 2]);cur_data_S2 =permute(cur_data_S2,[1 3 2]);
    cur_data_S1 = IBS_compute_freqwise('no_aggressive_CAR_ASR_10_ICA_appended_trials',cur_data_S1);
    cur_data_S2 = IBS_compute_freqwise('no_aggressive_CAR_ASR_10_ICA_appended_trials',cur_data_S2);
    
    cur_data_S1 = cur_data_S1 .* repmat(stat_cluster{1,2},1,1,size(cur_data_S1,3));
    cur_data_S2 = cur_data_S2 .* repmat(stat_cluster{1,2},1,1,size(cur_data_S2,3));
    
    cur_data_S1 = squeeze(nanmean(nanmean(cur_data_S1(:,:,:))));
    cur_data_S2 = squeeze(nanmean(nanmean(cur_data_S2(:,:,:))));
    
%     s_increase = unique([s1_increase;s2_increase]);
%     
%     for max_value = 1:length(s_increase)
%         cur_max = s_increase(max_value);
%         
%         if (cur_max-pre_samples)>0 && (cur_max+post_samples)<length(cur_data_S1)
%             
%             %                 behav_1_pre_post{max_value} = cur_data_S1(:,:,cur_max-pre_samples:cur_max+post_samples)';
%             behav_1_pre_post{max_value} = cur_data_S1(cur_max-pre_samples:cur_max+post_samples)';
%             behav_2_pre_post{max_value} = cur_data_S2(cur_max-pre_samples:cur_max+post_samples)';
% 
%             behav_coh_pre_post{max_value} = mscohere(behav_1_pre_post{max_value},behav_2_pre_post{max_value},10,0.5,100);
%         end
%         behav_1_pre_post_combined{dyd_no} = nanmean(cat(1,behav_1_pre_post{:}),1);
%         behav_2_pre_post_combined{dyd_no} = nanmean(cat(1,behav_2_pre_post{:}),1);
% 
% %         behav_coh_pre_post_combined{dyd_no} = nanmean(cat(1,behav_coh_pre_post{:}),1);
%     end
%     
    
    for max_value = 1:length(s1_increase)
        cur_max = s1_increase(max_value);
        
        if (cur_max-pre_samples)>0 && (cur_max+post_samples)<length(cur_data_S1)
            
            %                 behav_1_pre_post{max_value} = cur_data_S1(:,:,cur_max-pre_samples:cur_max+post_samples)';
            behav_1_pre_post{max_value} = cur_data_S1(cur_max-pre_samples:cur_max+post_samples)';
            
            
        end
        behav_1_pre_post_combined_cond{Dyads(dyd_no),cond} = mean(cat(1,behav_1_pre_post{:}),1);
        
    end
    
    
    for max_value_s2 = 1:length(s2_increase)
        cur_max_s2 = s2_increase(max_value_s2);
        
        if (cur_max_s2-pre_samples)>0 && (cur_max_s2+post_samples)<length(cur_data_S2)
            
            %                 behav_1_pre_post{max_value} = cur_data_S1(:,:,cur_max-pre_samples:cur_max+post_samples)';
            behav_2_pre_post{max_value_s2} = cur_data_S2(cur_max_s2-pre_samples:cur_max_s2+post_samples)';
            
            
        end
        behav_2_pre_post_combined_cond{Dyads(dyd_no),cond} = mean(cat(1,behav_2_pre_post{:}),1);
        
    end
    
    
    end
    behav_1_pre_post_combined{Dyads(dyd_no)} = nanmean(cat(1,behav_1_pre_post_combined_cond{Dyads(dyd_no),:}),1);
    behav_2_pre_post_combined{Dyads(dyd_no)} = nanmean(cat(1,behav_2_pre_post_combined_cond{Dyads(dyd_no),:}),1);

end

behav = cat(1,behav_1_pre_post_combined{:},behav_2_pre_post_combined{:});

plot(nanmean(behav),'--rs','LineWidth',4)
hold on
plot(behav')
xline(50)


sem = @(x,dim) nanstd( x,0,dim ) / sqrt( size( x,dim ));
yu = nanmean(behav) + sem(behav,1);
yl = nanmean(behav) - sem(behav,1);
x = 1:length(behav);
fill([x fliplr(x)], [yu fliplr(yl)], [.9 .9 .9], 'linestyle', 'none')
hold all
plot(nanmean(behav),'--rs','LineWidth',2)
xline(50)

%%
behav_2_pre_post_combined{1,3} = nan(1,99);
pre_post_s1 = cat(1,behav_1_pre_post_combined{:});
pre_post_s2 = cat(1,behav_2_pre_post_combined{:});
Dyads = [1:2 4:23]; % dyad 3 S2 doesn't smile
for dyd_no = 1:length(Dyads)
    coherence_value(dyd_no,:) = mscohere(pre_post_s1(Dyads(dyd_no),:),pre_post_s2(Dyads(dyd_no),:),10,0.5,100);
end
%%
p= squeeze(s1(60,:,1:1200-5));

k = arrayfun(@(x) ft_preproc_hilbert(p(x,:),'angle'),1:size(p,1),'UniformOutput',false);
k = cat(1,k{:});
% p = ft_preproc_hilbert(squeeze(s1(60,:,1:1200-5)),'angle');

k = reshape(k,[1 size(k)]);






k = IBS_compute_freqwise('no_aggressive_CAR_ASR_10_ICA_appended_trials',k);
subplot(2,1,1)
plot(normalize(nanmean(squeeze(k(1,12:14,:)))))
hold on
plot(double(mouth_size{1, 1}{1, Dyads(dyd_no)}.Fun_mouth_size_0)-1)



p2= squeeze(s2(60,:,1:1200-5));

k2 = arrayfun(@(x) ft_preproc_hilbert(p2(x,:),'angle'),1:size(p2,1),'UniformOutput',false);
k2 = cat(1,k2{:});
% p = ft_preproc_hilbert(squeeze(s1(60,:,1:1200-5)),'angle');

k2 = reshape(k2,[1 size(k2)]);






k2 = IBS_compute_freqwise('no_aggressive_CAR_ASR_10_ICA_appended_trials',k2);



subplot(2,1,2)
plot(normalize(nanmean(squeeze(k2(1,12:14,:)))))
hold on
plot(double(mouth_size{1, 2}{1, Dyads(dyd_no)}.Fun_mouth_size_1)-1)
subplot(3,1,1)
plot(ft_preproc_hilbert(squeeze(s2(chan_no,12,1:1200-5))','angle'))
hold on
plot(double(mouth_size{1, 1}{1, Dyads(dyd_no)}.Fun_mouth_size_0)-1)



subplot(3,1,2)
plot(ft_preproc_hilbert(squeeze(s2(chan_no,13,1:1200))','angle'))
hold on
plot(double(mouth_size{1, 1}{1, Dyads(dyd_no)}.Fun_mouth_size_0)-1)



subplot(3,1,3)
% plot(ft_preproc_hilbert((squeeze(s2(chan_no,14,1:1200))','angle'))
hold on
plot(double(mouth_size{1, 1}{1, Dyads(dyd_no)}.Fun_mouth_size_0)-1)

%%


cur_data_S1 = IBS_compute_freqwise(analysis_type,cur_data_S1);
    
stat_cluster = IBS_get_stat_cluster(analysis_type,'Brain_behavior_glm_power_freqwise');
cur_data_S1 = cur_data_S1.*repmat(stat_cluster{2},1,1,size(cur_data_S1,3));
% S2
cur_data_S2 = IBS_compute_freqwise(analysis_type,cur_data_S2);
    
cur_data_S2 = cur_data_S2.*repmat(stat_cluster{2},1,1,size(cur_data_S2,3));

%%

brain_data_sub = IBS_load_dyad_tf_insta_corr(analysis_type,1,conditions);




brain_data_sub = permute(brain_data_sub{1},[1 3 2]);
brain_data_sub = IBS_compute_freqwise(analysis_type,brain_data_sub);
    
stat_cluster = IBS_get_stat_cluster(analysis_type,'Brain_behavior_glm_power_freqwise');
brain_data_sub = brain_data_sub.*repmat(stat_cluster{2},1,1,size(brain_data_sub,3));

plot(normalize(squeeze(nanmean(nanmean(brain_data_sub)))))
% plot(squeeze(nanmean(nanmean(brain_data_sub)))-0.5)
% 
% hold on
plot(normalize(abs(squeeze(nanmean(nanmean(brain_data_sub)))-0.5)))
hold on
plot(normalize(squeeze(nanmean(nanmean(cur_data_S1)))))
hold on
plot(normalize(squeeze(nanmean(nanmean(cur_data_S2)))))
% plot(normalize(squeeze(nanmean(nanmean(s)))))

% plot(squeeze(nanmean(nanmean(brain_data_sub)))-0.5)
plot(normalize(squeeze(nanmean(nanmean(brain_data_sub)))-0.5))



plot(normalize(mouth_size{1, 1}{1, Dyads(dyd_no)}.Fun_mouth_size_0))
plot(normalize(mouth_size{1, 2}{1, Dyads(dyd_no)}.Fun_mouth_size_1))


figure;
plot(mouth_size{1, 1}{1, Dyads(dyd_no)}.mouth_size_0)
hold on
plot(mouth_size{1, 2}{1, Dyads(dyd_no)}.mouth_size_1)
plot(mouth_size{1, 3}{1, Dyads(dyd_no)}.mouth_size_joint)

joint_fun = @nancorr;

s_mouth = IBS_behav_moving_correlation(mouth_size{1, 1}{1, Dyads(dyd_no)}.mouth_size_0,mouth_size{1, 2}{1, Dyads(dyd_no)}.mouth_size_1,50,joint_fun,nan)

s_angle = IBS_compute_vector_angle(mouth_size{1, 1}{1, Dyads(dyd_no)}.mouth_size_0,mouth_size{1, 2}{1, Dyads(dyd_no)}.mouth_size_1);


s = IBS_moving_correlation(cur_data_S1,cur_data_S2,1:14,50);
s = permute(s,[1 3 2]);

s_angle2 = IBS_compute_vector_angle(mouth_size{1, 2}{1, Dyads(dyd_no)}.mouth_size_1,mouth_size{1, 1}{1, Dyads(dyd_no)}.mouth_size_0);
s_angle = IBS_compute_vector_angle(mouth_size{1, 1}{1, Dyads(dyd_no)}.mouth_size_0,mouth_size{1, 2}{1, Dyads(dyd_no)}.mouth_size_1);
figure
plot(normalize(s_angle));hold on;plot(normalize(s_angle2))

plot(s_angle);hold on;plot(s_angle2)
%%



p = IBS_compute_instantaneous_angle_tf(data.data_ica_clean_S1_tf{1, 5},data.data_ica_clean_S2_tf{1, 5});

p = squeeze(p(1,:,:,:));


p_freqwise = IBS_compute_freqwise(analysis_type,p);
    
stat_cluster = IBS_get_stat_cluster(analysis_type,'Brain_behavior_glm_power_freqwise');
p_freqwise = p_freqwise.*repmat(stat_cluster{2},1,1,size(p_freqwise,3));

plot(normalize(squeeze(nanmean(nanmean(p_freqwise)))))
plot(smoothdata(normalize(squeeze(nanmean(nanmean(p_freqwise)))),'movmean',50))
plot(smoothdata(squeeze(nanmean(nanmean(p_freqwise))),'movmean',50))

%%
clear
load('E:\Projects\IBS\Results\EEG\Brain_behavior_glm_power_freqwise\no_aggressive_CAR_ASR_10_ICA_appended_trials\Brain_behavior_glm_power_freqwiseno_aggressive_CAR_ASR_10_ICA_appended_trials_avg_sig_cluster_interaction_delay_insta_auto_joint.mat')
% load('E:\Projects\IBS\Results\EEG\Brain_behavior_glm_power_freqwise\no_aggressive_CAR_ASR_10_ICA_appended_trials\avg_sig_cluster_interaction_delay_insta_auto_joint_xor_joint_and_merged_cond.mat')
cluster_no = 1;
glm_data = glm_result.stats_cell{cluster_no}.Variables;


conditions = {'NeNoOcc_1' };
Dyads = 1:23;
xcf_mouth_joint_mat = [];
xcf_mouth_S1_mat = [];
xcf_mouth_S2_mat = [];
lag_no = [];
pre_samples = 24;
post_samples = 24;

%%


%%



h2 = figure('units','normalized','outerposition',[0 0 1 1]);
minwindow = 10;
for dyd_no = 1:length(Dyads)
    dyad_str = sprintf('Dyad_%0.2d',Dyads(dyd_no));
    sub_data = glm_data(strcmpi(cellstr(glm_data.Dyad_no_Gaze_nose_dist), dyad_str),:);
    cur_cond = [];
    for cond = 1:length(conditions)
        
        
        cur_cond = sub_data(strcmpi(cellstr(sub_data.condition_Gaze_nose_dist), conditions{cond}),:);
%         local_max = find(islocalmax(cur_cond.mouth_size_joint,'MinSeparation',50));
%         S1_value = mouth_size{1}{Dyads(dyd_no)}.Fun_mouth_size_0;
%         S2_value = mouth_size{2}{Dyads(dyd_no)}.Fun_mouth_size_1;

        s1 = IBS_compute_sudden_changes(double(mouth_size{1, 1}{1, Dyads(dyd_no)}.Fun_mouth_size_0),minwindow,'all');
        s2 = IBS_compute_sudden_changes(double(mouth_size{1, 2}{1, Dyads(dyd_no)}.Fun_mouth_size_1),minwindow,'all');


        smile_spike = zeros(1,size(cur_cond,1));

        smile_spike(s1.increase{1,1}) = 1;
        local_max = sort([s1.increase{1,1}' s2.increase{1,1}']);

        behav_1_pre_post = cell(1,50);
        for max_value = 1:length(local_max)
            cur_max = local_max(max_value);
            
            if (cur_max-pre_samples)>0 && (cur_max+post_samples)<length(cur_cond.chan_freq_data)
                
                behav_1_pre_post{max_value} = cur_cond.chan_freq_data(cur_max-pre_samples:cur_max+post_samples)';
                
                
            end
            behav_1_pre_post_combined{dyd_no} = nanmean(cat(1,behav_1_pre_post{:}),1);
            
        end
        
        
    end
%     figure(h2)
%     subplot(3,6,dyd_no)
%     plot(behav_1_pre_post_combined{dyd_no},'r')
%     xline(pre_samples+1)
%     title([ 'Dyad_no ' num2str(dyd_no)],'Interpreter','none')
    
end

s = cat(1,behav_1_pre_post_combined{:});
plot(s')

hold on
help plot
plot(mean(s),'--rs','LineWidth',2)
xline((length(s)-1)/2)
% title(['smile_corr_EEG_crosscorr_cluster_' num2str(cluster_no)],'Interpreter','none')

% saveas(gcf,[analysis_save_dir_figures 'smile_corr_EEG_crosscorr_cluster_' num2str(cluster_no) '_.tif'])
%% what happens to IBS when someone smiles
clear
load('E:\Projects\IBS\Results\EEG\Brain_behavior_glm_power_freqwise\no_aggressive_CAR_ASR_10_ICA_appended_trials\Brain_behavior_glm_power_freqwiseno_aggressive_CAR_ASR_10_ICA_appended_trials_avg_sig_cluster_interaction_delay_insta_auto_joint.mat')
% load('E:\Projects\IBS\Results\EEG\Brain_behavior_glm_power_freqwise\no_aggressive_CAR_ASR_10_ICA_appended_trials\avg_sig_cluster_interaction_delay_insta_auto_joint_xor_joint_and_merged_cond.mat')
cluster_no = 1;
glm_data = glm_result.stats_cell{cluster_no}.Variables;


conditions = {'NeNoOcc_1' };
Dyads = 1:23;
xcf_mouth_joint_mat = [];
xcf_mouth_S1_mat = [];
xcf_mouth_S2_mat = [];
lag_no = [];
pre_samples = 24;
post_samples = 24;

%%
behavior = 'Smile_auto';
behav_analysis = 'joint_XOR'; % it doesn't matter whether it is XOR or AND
output_data = 'all';
analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
lag_no = [];
mouth_size = IBS_load_behavior_data(behavior,analysis_type,Dyads,conditions,behav_analysis,output_data);

%%



h2 = figure('units','normalized','outerposition',[0 0 1 1]);
minwindow = 10;
for dyd_no = 1:length(Dyads)
    dyad_str = sprintf('Dyad_%0.2d',Dyads(dyd_no));
    sub_data = glm_data(strcmpi(cellstr(glm_data.Dyad_no_Gaze_nose_dist), dyad_str),:);
    cur_cond = [];
    for cond = 1:length(conditions)
        
        
        cur_cond = sub_data(strcmpi(cellstr(sub_data.condition_Gaze_nose_dist), conditions{cond}),:);
%         local_max = find(islocalmax(cur_cond.mouth_size_joint,'MinSeparation',50));
%         S1_value = mouth_size{1}{Dyads(dyd_no)}.Fun_mouth_size_0;
%         S2_value = mouth_size{2}{Dyads(dyd_no)}.Fun_mouth_size_1;

        s1 = IBS_compute_sudden_changes(double(mouth_size{1, 1}{1, Dyads(dyd_no)}.Fun_mouth_size_0),minwindow,'all');
        s2 = IBS_compute_sudden_changes(double(mouth_size{1, 2}{1, Dyads(dyd_no)}.Fun_mouth_size_1),minwindow,'all');


        smile_spike = zeros(1,size(cur_cond,1));

        smile_spike(s1.increase{1,1}) = 1;
        local_max = sort([s1.increase{1,1}' s2.increase{1,1}']);

        behav_1_pre_post = cell(1,50);
        for max_value = 1:length(local_max)
            cur_max = local_max(max_value);
            
            if (cur_max-pre_samples)>0 && (cur_max+post_samples)<length(cur_cond.chan_freq_data)
                
                behav_1_pre_post{max_value} = cur_cond.chan_freq_data(cur_max-pre_samples:cur_max+post_samples)';
                
                
            end
            behav_1_pre_post_combined{dyd_no} = nanmean(cat(1,behav_1_pre_post{:}),1);
            
        end
        
        
    end
%     figure(h2)
%     subplot(3,6,dyd_no)
%     plot(behav_1_pre_post_combined{dyd_no},'r')
%     xline(pre_samples+1)
%     title([ 'Dyad_no ' num2str(dyd_no)],'Interpreter','none')
    
end

s = cat(1,behav_1_pre_post_combined{:});
plot(s')

hold on
help plot
plot(mean(s),'--rs','LineWidth',2)
xline((length(s)-1)/2)
% title(['smile_corr_EEG_crosscorr_cluster_' num2str(cluster_no)],'Interpreter','none')

% saveas(gcf,[analysis_save_dir_figures 'smile_corr_EEG_crosscorr_cluster_' num2str(cluster_no) '_.tif'])
