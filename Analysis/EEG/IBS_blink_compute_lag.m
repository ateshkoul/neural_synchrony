function [results] = IBS_blink_compute_lag(blinks_start_time_eye_tracker,blink_data_diff_time_EEG)
%% Atesh Koul
% 15-02-2021

lag_blinks = [];

for blink_start_timepoint = 1:length(blinks_start_time_eye_tracker)
    
    lag_blinks(:,blink_start_timepoint) = blink_data_diff_time_EEG - blinks_start_time_eye_tracker(blink_start_timepoint);
    
end

%%
[value,loc] = min(abs(lag_blinks));
loc_sign = arrayfun(@(x,y) sign(lag_blinks(x,y)),loc,1:size(lag_blinks,2));

for lag_no = 1:length(value)
    cur_value = loc_sign(lag_no).*value(lag_no);
    %         cur_corrected_seq = all_timepoints(find(blinks_start_time_eye_tracker)) + cur_value;
    cur_corrected_seq = blinks_start_time_eye_tracker+ cur_value;
    
    
    if length(cur_corrected_seq) > length(blink_data_diff_time_EEG)
        cur_corresp = IBS_find_corresponding_time_points(cur_corrected_seq,blink_data_diff_time_EEG);
        cur_delay(lag_no) =  rms(cur_corrected_seq(cur_corresp) - blink_data_diff_time_EEG);
    else
        cur_corresp = IBS_find_corresponding_time_points(blink_data_diff_time_EEG, cur_corrected_seq);
        cur_delay(lag_no) =  rms(blink_data_diff_time_EEG(cur_corresp) - cur_corrected_seq);
    end
end

actual_delays = loc_sign.*value;
delay_rms = actual_delays(find(cur_delay == min(cur_delay)));
deviance_delay_rms = min(cur_delay);
%%
%             delay = median(min(abs(lag)));
%%
[value,loc] = min(abs(lag_blinks));
loc_sign = arrayfun(@(x,y) sign(lag_blinks(x,y)),loc,1:size(lag_blinks,2));

delay = loc_sign.*min(abs(lag_blinks));

pos_delay = median(delay(delay>0));
neg_delay = median(delay(delay<0));
%%
if ~isnan(pos_delay)
    %         cur_corrected_seq_median_pos = all_timepoints(find(s_start)) + pos_delay;
    cur_corrected_seq_median_pos = blinks_start_time_eye_tracker + pos_delay;
    cur_corresp_median_pos = IBS_find_corresponding_time_points(blink_data_diff_time_EEG, cur_corrected_seq_median_pos);
    cur_delay_median_pos=  rms(blink_data_diff_time_EEG(cur_corresp_median_pos) - cur_corrected_seq_median_pos);
else
    cur_delay_median_pos = nan;
end
if ~isnan(neg_delay)
    %         cur_corrected_seq_median_neg = all_timepoints(find(s_start)) + neg_delay;
    cur_corrected_seq_median_neg = blinks_start_time_eye_tracker + neg_delay;
    cur_corresp_median_neg = IBS_find_corresponding_time_points(blink_data_diff_time_EEG, cur_corrected_seq_median_neg);
    cur_delay_median_neg=  rms(blink_data_diff_time_EEG(cur_corresp_median_neg) - cur_corrected_seq_median_neg);
else
    cur_delay_median_neg = nan;
    
end

%%
%             if sum(loc_sign)<0
%
%                 delay = -delay;
%             end
%

%             figure
%                     plot(blinks_EEG_times,blinks_EEG.signalData(max_blink_chan(1)).signal)
% %             plot(blinks_EEG_times,blinks_EEG.signalData(min_blink_chan(1)).signal)
%
%             hold on;
%             plot(blinks_EEG_times,blink_data*500,'g')
%
%             plot(all_timepoints+pos_delay,s_start*500,'r')
%             plot(all_timepoints+neg_delay,s_start*500,'y')

%             pause(2)

results.loc_sign = sum(loc_sign);
results.loc_sign_frac = sum(loc_sign)/length(loc_sign);
%     results.blinks_EEG_times = blinks_EEG_times;
%     results.blinks_EEG = blinks_EEG;
%     results.blink_data = blink_data;
results.actual_delays = actual_delays;
results.pos_delay = pos_delay;
results.neg_delay = neg_delay;
%     results.s_start = s_start;

%     results.all_timepoints = all_timepoints;
results.delay_rms = delay_rms;

results.cur_delay_median_pos = cur_delay_median_pos;
results.cur_delay_median_neg = cur_delay_median_neg;
results.cur_delay = cur_delay;
results.deviance_delay_rms = deviance_delay_rms;


end