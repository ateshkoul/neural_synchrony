f = 10;
% t = (-1000:1:1000)/1000;
t = (0:(1/2048):40);
s = cos(2*pi*f*t); % random phase

S = [zeros(1,length(t)-1) s zeros(1,length(t)-1)];

T = 0:(1/2048):120;


analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
analysis_type_params = IBS_get_params_analysis_type(analysis_type,'Brain_behavior_glm_power_freqwise');
data_dir = analysis_type_params.data_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';

% data = IBS_load_clean_IBS_data(1,analysis_type,data_dir);

% temp = data.data_ica_clean_S1{1, 1};clear data
load('IBS_data_empty_template.mat','temp')
temp.trial{1,1} = S;
temp.label(2:end) = [];
temp.time(2:end) = [];
temp.trial(2:end) = [];
temp.time{1,1} = T;

s = IBS_tf(temp,11);

p = squeeze(s.powspctrm);
plot(T,S)
hold on
plot(0:0.1:120,p(f,:))

xlabel('time (in s)');
ylabel('power and relative power');


imagesc(p)
ax = gca;
ax.XAxis.TickLabels = s.time(ax.XAxis.TickValues);
ax.YDir = 'normal';
ylabel('Hz');
xlabel('time (in s)');



k = IBS_filter_raw_data(temp);
plot(k.time{1,1},k.trial{1,1});
ylabel('Raw EEG data')
xlabel('time (in s)')


