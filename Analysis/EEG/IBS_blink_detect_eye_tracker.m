function [blinks_start_time,blinks_start_loc,all_timepoints] = IBS_blink_detect_eye_tracker(Dyad_no,Sub_no,condition,raw_data_dir)
%% Atesh Koul
% 15-02-2021
varargin_table = table();
varargin_table.analysis_sub_type = '_insta_corr_avg_freqwise';
varargin_table.behav_analysis = 'joint';
blinks_eye_tracker = IBS_get_sub_behavior_data('Eye_tracker_blink',Dyad_no,Sub_no,condition,raw_data_dir,varargin_table);

all_timepoints = round([0:0.0001:122],4);
% change 09-07-2021 after issues with just 1 blink in data for dyad 20 S2
% cond 3 task
if length(blinks_eye_tracker.start_timestamp) <2
    blinks_start_loc = all_timepoints == blinks_eye_tracker.start_timestamp;
else
blinks_start_loc = sum(all_timepoints == blinks_eye_tracker.start_timestamp);
end
% blinks.end_timestamp = round(blinks.end_timestamp - 31737.715057,2);
all_timepoints = round([0:0.0001:122],4);
blinks_end_loc = sum(all_timepoints == blinks_eye_tracker.end_timestamp);


blinks_start_time = all_timepoints(find(blinks_start_loc));

end