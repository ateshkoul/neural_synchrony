
%%

%%
data_analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
analysis_params = IBS_get_params_analysis_type(data_analysis_type);
save_fig_dir = analysis_params.analysis_save_dir_figures{1,1};

%%

close all

f = 2;
% t = (-1000:1:1000)/1000;
t = (0:1:2000)/1000;

% figure('units','normalized','outerposition',[0 0 1 1])
figure
for i=1:3:10 % repeat 10 times
s = nan(size(t));

s = cos(2*pi*f*t*i + 2*pi*rand(1)); % random phase
random_index_1 = randi(500,1);
random_index_2 = randi(500,1);

s(min(random_index_1,random_index_2):max(random_index_1,random_index_2)) = 5*s(min(random_index_1,random_index_2):max(random_index_1,random_index_2));
% s(t>=-50 & ) = 1.5*cos(2*pi*f*t(t>=-250)); % constant phase
s = 2*s+i*4+(rand(length(t),1)/5)';
d1_s1(i,:) = s; % remember the signal on each repetition
plot(t(1:500), s(1:500));
hold on;
end
ylim([-1,165])
ax = gca;

exportgraphics(ax,[save_fig_dir 'example_S1_power_graphs.eps'],'BackgroundColor','none','ContentType','vector')


% ylim([mean(mean(d,1))-1, mean(mean(d,1))+1])

%% second channel
for i=1:3:40 % repeat 10 times
s = nan(size(t));
s = cos(2*pi*f*t*i + 2*pi*rand(1)); % random phase
% s(t>=0) = cos(2*pi*f*t(t>=0)               ); % constant phase
s = 2*s+i*4+(rand(length(t),1)/5)';
d2_s1(i,:) = s; % remember the signal on each repetition

end


%% 3rd channel
for i=1:3:40 % repeat 10 times
s = nan(size(t));
s = cos(2*pi*f*t*i + 2*pi*rand(1)); % random phase
% s(t>=0) = cos(2*pi*f*t(t>=0)               ); % constant phase
s = 2*s+i*4+(rand(length(t),1)/5)';
d3_s1(i,:) = s; % remember the signal on each repetition

end

%% channels
figure;
plot(t, smoothdata(mean(d1_s1,1),'movmean',50))
hold on
plot(t, smoothdata(mean(d2_s1,1),'movmean',50)+0.5,'r')


plot(t, smoothdata(mean(d3_s1,1),'movmean',50)+1,'k')
ylim([min([mean(d1_s1),mean(d2_s1),mean(d3_s1)])-1, max([mean(d1_s1),mean(d2_s1),mean(d3_s1)])+1])
ax = gca;

exportgraphics(ax,[save_fig_dir 'example_S1_raw_eeg.eps'],'BackgroundColor','none','ContentType','vector')

%% subject 2
% figure('units','normalized','outerposition',[0 0 1 1])
figure
for i=1:3:40 % repeat 10 times
s = nan(size(t));
s = cos(2*pi*f*t*i + pi*rand(1)); % random phase
% s(t>=0) = cos(2*pi*f*t(t>=0)               ); % constant phase
s = 2*s+i*4+(rand(length(t),1)/5)';
d1_s2(i,:) = s; % remember the signal on each repetition
% plot(t, s);
plot(t(1:500), s(1:500));

hold on;
end
ax = gca;

exportgraphics(ax,[save_fig_dir 'example_S2_power_graphs.eps'],'BackgroundColor','none','ContentType','vector')


%% second channel
for i=1:3:40 % repeat 10 times
s = nan(size(t));
s = cos(2*pi*f*t*i + 2*pi*rand(1)); % random phase
% s(t>=0) = cos(2*pi*f*t(t>=0)               ); % constant phase
s = 2*s+i*4+(rand(length(t),1)/5)';
d2_s2(i,:) = s; % remember the signal on each repetition

end


%% 3rd channel
for i=1:3:40 % repeat 10 times
s = nan(size(t));
s = cos(2*pi*f*t*i + 2*pi*rand(1)); % random phase
% s(t>=0) = cos(2*pi*f*t(t>=0)               ); % constant phase
s = 2*s+i*4+(rand(length(t),1)/5)';
d3_s2(i,:) = s; % remember the signal on each repetition

end


figure;
plot(t, smoothdata(mean(d1_s2,1),'movmean',50))
hold on
plot(t, smoothdata(mean(d2_s2,1),'movmean',50)+0.5,'r')


plot(t, smoothdata(mean(d3_s2,1),'movmean',50)+1,'k')
ylim([min([mean(d1_s2),mean(d2_s2),mean(d3_s2)])-1, max([mean(d1_s2),mean(d2_s2),mean(d3_s2)])+1])
ax = gca;

exportgraphics(ax,[save_fig_dir 'example_S2_raw_eeg.eps'],'BackgroundColor','none','ContentType','vector')



%%
data_analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
analysis_params = IBS_get_params_analysis_type(data_analysis_type);
save_fig_dir = analysis_params.analysis_save_dir_figures{1,1};
%%

close all
freqs = [1 3 7 10 16 40 60 80];
freqs = [1 3 7 10 16];
figure('units','normalized','outerposition',[0 0 1 1])
for freq = 2:length(freqs)
f = freqs(freq);
t = (-2000:1:5000)/1000;

% figure
for i=2:10 % repeat 10 times

p = 2*pi*f*t; % linear phase increase
rand_time = rand(1);
p(t<-rand_time) = p(t<-rand_time) + 2*pi*rand(1); % random phase prior to TMS pulse
p(t>rand_time) = p(t>rand_time) + 2*pi*rand(1); % random phase prior to TMS pulse

rand_time = randi(4,1);
p(t<rand_time) = p(t<rand_time) + 2*pi*rand(1); % random phase prior to TMS pulse
p(t>rand_time) = p(t>rand_time) + 2*pi*rand(1); % random phase prior to TMS pulse


% rand_time = randi(1,1);
% p(t<-rand_time) = p(t<-rand_time) + 2*pi*rand(1); % random phase prior to TMS pulse
% p(t>rand_time) = p(t>rand_time) + 2*pi*rand(1); % random phase prior to TMS pulse
rand_time = round(rand(1));
p = p + cumsum(2*pi*(rand(size(p))-0.5)*0.001); % random walk
p = p - p(t==rand_time);

s = cos(p);
% s = sin(p);
% s = 1.5*s+i+f;
s = 2*s+i+f;

d(i,:) = s; % remember the signal on each repetition
% plot(t, s);
% hold on;
end
% axis auto
all_d(freq,:) = mean(d,1);
mean_d = mean(d,1);
% plot(t(1:5000),mean_d(1:5000))
% plot(t,mean_d)
% plot(t,smoothdata(mean_d,'movmean',50))
plot(t,smoothdata(all_d(freq,:),'movmean',50))

hold on
end
ax = gca;
ax.Box = 'off';
ylim([mean(mean(all_d,1))-8,mean(mean(all_d,1))+8])

ax = gca;

exportgraphics(ax,[save_fig_dir 'example_S1_power_modulation_graphs.eps'],'BackgroundColor','none','ContentType','vector')
figure;plot(t,envelope(smoothdata(all_d(3,:),'movmean',50)))
hold on
plot(t,smoothdata(all_d(3,:),'movmean',50))
ax = gca;

exportgraphics(ax,[save_fig_dir 'example_S1_power_modulation_envelope.eps'],'BackgroundColor','none','ContentType','vector')


%%
close all
freqs = [1 3 7 10 16 40 60 80];
freqs = [1 3 7 10 16];
figure('units','normalized','outerposition',[0 0 1 1])
for freq = 2:length(freqs)
f = freqs(freq);
t = (-2000:1:5000)/1000;

% figure
for i=1:10 % repeat 10 times

p = 2*pi*f*t; % linear phase increase
rand_time = rand(1);
p(t<-rand_time) = p(t<-rand_time) + 2*pi*rand(1); % random phase prior to TMS pulse
p(t>rand_time) = p(t>rand_time) + 2*pi*rand(1); % random phase prior to TMS pulse

rand_time = randi(4,1);
p(t<rand_time) = p(t<rand_time) + 2*pi*rand(1); % random phase prior to TMS pulse
p(t>rand_time) = p(t>rand_time) + 2*pi*rand(1); % random phase prior to TMS pulse


% rand_time = randi(1,1);
% p(t<-rand_time) = p(t<-rand_time) + 2*pi*rand(1); % random phase prior to TMS pulse
% p(t>rand_time) = p(t>rand_time) + 2*pi*rand(1); % random phase prior to TMS pulse
rand_time = round(rand(1));
p = p + cumsum(2*pi*(rand(size(p))-0.5)*0.001); % random walk
p = p - p(t==rand_time);

s = cos(p);
% s = sin(p);
% s = 1.5*s+i+f;
s = 2*s+i+f;

d(i,:) = s; % remember the signal on each repetition
% plot(t, s);
% hold on;
end
% axis auto
all_d(freq,:) = mean(d,1);
mean_d = mean(d,1);
% plot(t(1:5000),mean_d(1:5000))
% plot(t,smoothdata(mean_d,'movmean',50))
plot(t,smoothdata(all_d(freq,:),'movmean',50))

hold on
end
ax = gca;
ax.Box = 'off';
ylim([mean(mean(all_d,1))-8,mean(mean(all_d,1))+8])



ax = gca;

exportgraphics(ax,[save_fig_dir 'example_S2_power_modulation_graphs.eps'],'BackgroundColor','none','ContentType','vector')

figure;plot(t,envelope(smoothdata(all_d(3,:),'movmean',50)))
hold on
plot(t,smoothdata(all_d(3,:),'movmean',50))
ax = gca;

exportgraphics(ax,[save_fig_dir 'example_S2_power_modulation_envelope.eps'],'BackgroundColor','none','ContentType','vector')

