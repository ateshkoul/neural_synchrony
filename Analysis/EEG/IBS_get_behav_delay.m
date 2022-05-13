function delay = IBS_get_behav_delay(Dyad_no,Sub,condition,behavior)
%% Atesh Koul
% 02-03-2021
if nargin <4
behavior = "Eye_tracker";
end
fname = 'correct_delays_EEG_eye_tracker.mat';
load(fname)
all_conditions = {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'};
condition_no = find(contains(all_conditions,condition));
switch(Sub)
case 0

delay = S1_delay_min_dev(Dyad_no,condition_no);
case 1
delay = S2_delay_min_dev(Dyad_no,condition_no);
end

if isnan(delay)
    delay = 0;
end
end
