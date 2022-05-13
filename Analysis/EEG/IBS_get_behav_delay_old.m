function delay = IBS_get_behav_delay(Dyad_no,Sub,condition,behavior)
%% Atesh Koul
% 02-03-2021
if nargin <4
behavior = "Eye_tracker";
end
fname = 'correct_delays_EEG_eye_tracker.mat';
all_conditions = {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'};
condition_no = find(contains(all_conditions,condition));
switch(Sub)
case 1
load(fname,'results_S1_F')
delay = results_S1_F{Dyad_no,condition_no};
case 2
load(fname,'results_S2_F')
delay = results_S2_F{Dyad_no,condition_no};
end

end
