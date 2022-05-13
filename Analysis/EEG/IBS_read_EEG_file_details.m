function [dataset_details] = IBS_read_EEG_file_details(Dyad_no,block)
%% Atesh Koul
% 19-02-2021


% [event_table,eventvalue] = IBS_get_eventtable(Dyad_no,block);

% find where the first status is present
% events = cat(2,{event_table.type});
% status_loc = find(contains(events,'STATUS'));
% first_status_loc = status_loc(1,1);


% dataset_details = table();

% dataset_details.first_cond_trigger = event_table(first_status_loc).sample;
% dataset_details.first_cond_event_value = event_table(first_status_loc).value;


% for IBS_load_raw_sub_data
dataset = IBS_load_raw_sub_data(Dyad_no,block);
dataset_details = table();

% dataset_details.first_cond_trigger = dataset.cfg.trl(1,1);
dataset_details.nSamples =  dataset.hdr.nSamples;
dataset_details.last_trigger = dataset.cfg.trl(end,1);
dataset_details.first_trigger = dataset.cfg.trl(1,1);


end