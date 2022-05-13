
%% A function to load the raw subject IBS dataset

function [dataset] = IBS_load_raw_sub_data(Dyd_no,block,pre_trig_time,post_trig_time,analysis_type)
%% Atesh Koul

if nargin <5
    
analysis_type = 'no_aggressive_trialwise_CAR';
end
analysis_type_params = IBS_get_params_analysis_type(analysis_type);

if nargin <3 || isempty(pre_trig_time) 

pre_trig_time = analysis_type_params.pre_trig_time;
end
if nargin <4 || isempty(post_trig_time) 
post_trig_time = analysis_type_params.post_trig_time;
end

% processed_dir = analysis_type_params.data_dir{1,1};


    
[event_table,eventvalue] = IBS_get_eventtable(Dyd_no,block);

cfg = [];
cfg.dataset = IBS_get_dataset_fname(Dyd_no,block);
cfg.trialdef.detectflank = 'up';
cfg.trialdef.eventtype = 'STATUS';
cfg.event = event_table;
cfg.trialdef.prestim = -pre_trig_time;
cfg.trialdef.poststim = post_trig_time;
cfg.trialdef.eventvalue = eventvalue;
cfg = ft_definetrial(cfg);




% cfg.processed_dir = processed_dir;
dataset = ft_preprocessing(cfg);

if Dyd_no == 12 && strcmp(block,'blocks') && numel(dataset.trial) < (analysis_type_params.Dyd_12_trials+1) % otherwise it's a recursive loop
    % the idea here is to add extra recording at the begining and end of the dataset.
    dataset = IBS_correct_Dyad_data(dataset,Dyd_no,block,analysis_type);

end



end

% cfg.trialdef.eventvalue = [21 31 41 51 61];
% cfg.trialdef.eventvalue = [21:10:61 22:10:62 23:10:63];
% cfg.trialdef.eventvalue = eventvalue;


% cfg.channel = {'CZ'};
% cfg.trl = k;
% this is needed for 'up-going flanks' error
% cfg.event = event;
% cfg.triallength = 120;
% cfg.trl(:,3) = - 1;





% if nargin <4
%     post_trig_time = 120;
% end
%
% if nargin <3
%     % checked that with -1 the data loaded is 61 sec long
%     pre_trig_time = -1;
%     post_trig_time = 120;
% end
%
% if nargin <4
%     % checked that with -1 the data loaded is 61 sec long
%     pre_trig_time = -1;
%     post_trig_time = 120;
%     processed_dir = 'D:\\Experiments\\IBS\\Processed\\EEG\\';
% end


% if Dyd_no == 12 && strcmp(block,'blocks')
%     % correct for the issue here. the dataset selects 120 seconds but takes
%     % the data after the end of the trial.
%     % the last sample where the code is sent (36) is 242243, converted to
%     % seconds is 242243/2048. which is 118.2827. so we lost around 1.7173s
%     % of trial. converted to samples this is 1.7173*2048 or 3.5170e+03
%     % samples
%
%     % adding this much NaNs at the begining and removing from the end of
%     % the trial
%     % I get 122.7173 because of this:
%     % 1.7173+(247808*(dataset.time{1,1}(1,2)-dataset.time{1,1}(1,1)))
%     % ideally should be 122.7173 but this leads to more values
%     dataset.time{1,1} = 1.7173:(dataset.time{1,1}(1,2)-dataset.time{1,1}(1,1)):122.7170;
% %     dataset.trial{1,1}(:,(247808-3517):247808) = [];
% %     dataset.trial{1,1}(:,(247808-3517):247808)
% %     dataset.trial{1,1}(:,(3517+1):247808) = dataset.trial{1,1}(:,1:(247808-3517));
% %     dataset.trial{1,1}(:,1:3517) = NaN(size(dataset.trial{1,1},1),3517);
% end

% if Dyd_no == 19 && strcmp(block,'baseline_2')
%     % this operation never happened. This is so that the dataset doesn't have an additional cfg.previous section
%     oriconfig = dataset.cfg;
%    cfg_select_trials.trials = [false false true true true];
%    dataset = ft_selectdata(cfg_select_trials,dataset);
%    dataset.cfg = oriconfig;
% end







