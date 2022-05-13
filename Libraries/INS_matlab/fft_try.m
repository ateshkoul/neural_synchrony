
P2_cond_1 = [];
P2_cond_2 = [];

Dyads = [1 2];
for dyad_no = 1:length(Dyads)
    hp_filter = 0.3;
dataset = load_raw_sub_IBS_data(Dyads(dyad_no),'baseline_1');
dataset_filt_baseline_1 = filter_raw_data_IBS(dataset,hp_filter);

dataset = load_raw_sub_IBS_data(Dyads(dyad_no),'blocks');
dataset_filt_task = filter_raw_data_IBS(dataset,hp_filter);

dataset = load_raw_sub_IBS_data(Dyads(dyad_no),'baseline_2');
dataset_filt_baseline_2 = filter_raw_data_IBS(dataset,hp_filter);


mapObj = containers.Map({11,12,13,21,22,23,31,32,33,41,42,43,51,52,53,61,62,63,71,72,73}, ...
    {'Baseline start','Baseline start','Baseline start',...
    'FaOcc','FaOcc','FaOcc','FaNoOcc','FaNoOcc','FaNoOcc','NeOcc','NeOcc','NeOcc','NeNoOcc','NeNoOcc','NeNoOcc',...
    'Task','Task','Task','Baseline end','Baseline end','Baseline end'});
 
baseline_start = 1:3;
FaOcc = find(ismember(dataset_filt_task.trialinfo,[21 22 23]))';
FaNoOcc = find(ismember(dataset_filt_task.trialinfo,[31 32 33]))';
NeOcc = find(ismember(dataset_filt_task.trialinfo,[41 42 43]))';
NeNoOcc = find(ismember(dataset_filt_task.trialinfo,[51 52 53]))';
Task = find(ismember(dataset_filt_task.trialinfo,[61 62 63]))';
baseline_end = 1:3;


trial_nos = {baseline_start, FaOcc,FaNoOcc, NeOcc, NeNoOcc, Task, baseline_end};
for trial_no = 1:numel(trial_nos)

P2_sub_1 = [];
P2_sub_2 = [];
freq = [];

electrode_nos_1 = 1:64;
electrode_nos_2 = 73:136;

    for condition = 1:numel(trial_nos{trial_no})
    switch(trial_no)
        case 1
                data_trial = dataset_filt_baseline_1.trial{1,trial_nos{trial_no}(condition)}; 
                plot_title = mapObj(dataset_filt_baseline_1.trialinfo(trial_nos{trial_no}(condition)));
        case {2,3,4,5,6}
                data_trial = dataset_filt_task.trial{1,trial_nos{trial_no}(condition)};   
                plot_title = mapObj(dataset_filt_task.trialinfo(trial_nos{trial_no}(condition)));

        case 7
                data_trial = dataset_filt_baseline_2.trial{1,trial_nos{trial_no}(condition)};  
                 plot_title = mapObj(dataset_filt_baseline_2.trialinfo(trial_nos{trial_no}(condition)));

    end 
    
    
%     if trial_no == 1
%         data_trial = dataset_filt_baseline_1.trial{1,1};
%         plot_title = mapObj(dataset_filt_baseline_1.trialinfo(1));
%     elseif trial_no >6
%             data_trial = dataset_filt_baseline_2.trial{1,1};
%             plot_title = mapObj(dataset_filt_baseline_2.trialinfo(1));
%         else
%             data_trial = dataset_filt_task.trial{1,trial_no-1};
%             plot_title = mapObj(dataset_filt_task.trialinfo(trial_no-1));
%     end
[P2_filt_1,P2_filt_2,f2] = IBS_fft_plot(data_trial,electrode_nos_1,electrode_nos_2);
P2_sub_1(condition,1:length(P2_filt_1)) = P2_filt_1;
P2_sub_2(condition,1:length(P2_filt_2)) = P2_filt_2;
freq(condition,1:length(f2)) = f2;
    end
    
    
    P2_cond_1(:,trial_no,dyad_no) = mean(P2_sub_1,1);
    P2_cond_2(:,trial_no,dyad_no) = mean(P2_sub_2,1);
    
    
end

end

for dyad_no = 1:length(Dyads)
    figure
    for trial_no = 1:numel(trial_nos)
    for condition = 1:numel(trial_nos{trial_no})
    switch(trial_no)
        case 1
                plot_title = mapObj(dataset_filt_baseline_1.trialinfo(trial_nos{trial_no}(condition)));
        case {2,3,4,5,6}
                plot_title = mapObj(dataset_filt_task.trialinfo(trial_nos{trial_no}(condition)));

        case 7
                 plot_title = mapObj(dataset_filt_baseline_2.trialinfo(trial_nos{trial_no}(condition)));

    end
    end
    P2_1 = P2_cond_1(:,trial_no,dyad_no);
    P2_2 = P2_cond_2(:,trial_no,dyad_no);
    
    
    freq_start = find(f2==1);
freq_stop = find(f2==60);
% figure;plot(f2(freq_start:freq_stop),smoothdata(P2_filt(freq_start:freq_stop),'movmean'))
% figure;
subplot(1,numel(trial_nos),trial_no)
plot(f2(freq_start:freq_stop),smoothdata(P2_1(freq_start:freq_stop),'gaussian',20),'b')
hold on;plot(f2(freq_start:freq_stop),smoothdata(P2_2(freq_start:freq_stop),'gaussian',20),'r')
ax = gca;
ax.YLim = [0 0.35];
title(plot_title)
    
    end
    
end
%  data_trial = dataset_filt_task.trial{1,15};
data_trial = data_ica_clean_S2{1,2}.trial{1,5};
[P2_filt_1,P2_filt_2,f2] = IBS_fft_plot_view(data_trial,electrode_nos_1,electrode_nos_2);




data_view_mat.trial{1,1} = smoothdata(P2_filt_1,2);
data_view_mat.time{1,1} = f2;
data_view_mat.cfg.trl = [0 size(P2_filt_1,2)-1];
data_view_mat.label = dataset_filt_baseline_1.label(1:64);
data_view_mat.trialinfo = [1];
data_view_mat.cfg.previous.trialdef.poststim = 2000;
IBS_plot_data(data_view_mat,1)



P2_1_mean = mean(P2_cond_1,3);
P2_2_mean = mean(P2_cond_2,3);
for trial_no = 1:numel(trial_nos)
    for condition = 1:numel(trial_nos{trial_no})
    switch(trial_no)
        case 1
                plot_title = mapObj(dataset_filt_baseline_1.trialinfo(trial_nos{trial_no}(condition)));
        case {2,3,4,5,6}
                plot_title = mapObj(dataset_filt_task.trialinfo(trial_nos{trial_no}(condition)));

        case 7
                 plot_title = mapObj(dataset_filt_baseline_2.trialinfo(trial_nos{trial_no}(condition)));

    end
    end
P2_1 = P2_1_mean(:,trial_no);
P2_2 = P2_2_mean(:,trial_no);
% figure;plot(1:L,k);
% figure;plot(f2,P2)
freq_start = find(f2==1);
freq_stop = find(f2==60);
% figure;plot(f2(freq_start:freq_stop),smoothdata(P2_filt(freq_start:freq_stop),'movmean'))
% figure;
subplot(1,numel(trial_nos),trial_no)
plot(f2(freq_start:freq_stop),smoothdata(P2_1(freq_start:freq_stop),'gaussian',20),'b')
hold on;plot(f2(freq_start:freq_stop),smoothdata(P2_2(freq_start:freq_stop),'gaussian',20),'r')
ax = gca;
ax.YLim = [0 0.35];
title(plot_title)


% plot(f2(freq_start:freq_stop),smoothdata(P2_filt_1(freq_start:freq_stop),'gaussian'),'b')
% hold on;plot(f2(freq_start:freq_stop),smoothdata(P2_filt_2(freq_start:freq_stop),'gaussian'),'r')
% 
% plot(f2(freq_start:freq_stop),smoothdata(P2_filt_1(freq_start:freq_stop),'lowess'),'b')
% hold on;plot(f2(freq_start:freq_stop),smoothdata(P2_filt_2(freq_start:freq_stop),'lowess'),'r')


% figure;plot(f2,P2_filt)

end