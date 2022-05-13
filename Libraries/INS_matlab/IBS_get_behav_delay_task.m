function delay = IBS_get_behav_delay_task(Dyad_no,Sub,condition,behavior)
%% Atesh Koul
% 09-07-2021
if nargin <4
    behavior = "Eye_tracker";
end
fname = 'Task_correct_delays_EEG_eye_tracker.mat';
load(fname)
all_conditions = {'Task_1','Task_2','Task_3'};
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
