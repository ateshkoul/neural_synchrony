function [P2_filt_1,P2_filt_2,f2] = IBS_fft_plot(data_trial,electrode_nos_1,electrode_nos_2)

% data_fft_1 = fft(transpose(data_trial(electrode_nos_1,:))); % 29
% data_fft_1 = transpose(data_fft_1);
% 
% data_fft_2 = fft(transpose(data_trial(electrode_nos_2,:))); %101
% data_fft_2 = transpose(data_fft_2);

data_fft = fft(transpose(data_trial));
data_fft = transpose(data_fft);
k_filt_1 = mean(data_fft(electrode_nos_1,:),1);
k_filt_2 = mean(data_fft(electrode_nos_2,:),1);

% k_filt_1 = mean(data_fft(1:64,:),1);
% k_filt_1 = data_fft_1(1,:);
% k_filt_2 = data_fft_2(1,:);

L = length(data_fft);
Fs = 2048;

% Y_filt = fft(k_filt);
% 
% Y = fft(k);
% P2 = abs(Y/L);
P2_filt_1 = abs(k_filt_1/L);
P2_filt_2 = abs(k_filt_2/L);


f2 = Fs*(0:(L-1))/L;






end