function [eye_delay_struct] = IBS_blink_subs_empty_delays(eye_delay_struct)
%% Atesh Koul
% 24-02-2021

nan_indicies = cell2mat(cellfun(@(x) isempty(x),eye_delay_struct,'UniformOutput',0));


[nan_rows,nan_cols] = find(nan_indicies);

nan_table = table();
nan_table.delay_rms = nan;
% done after reanalysis of task condition% 06-07-21
nan_table.deviance_delay_rms = nan;
for nan_sub = 1:length(nan_rows)
    eye_delay_struct{nan_rows(nan_sub),nan_cols(nan_sub)} = nan_table;
end


end