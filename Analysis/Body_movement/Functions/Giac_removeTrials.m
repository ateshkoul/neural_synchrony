function [data_output] = Giac_removeTrials(data,trials_number_to_remove,method)
%%
% Removes the trials specified (trials_number_to_remove) from the FieldTrip structure
% 'data'. Method specifies whether to substitute data with nan ('nan') or
% reject the whole trial ('reject').
%
%% Giacomo Novembre

if iscell(data.trial) == 1  
    tr_nr = length(data.trial);   
elseif iscell(data.trial) == 0 && strcmp('rpt_chan_time',data.dimord) == 1;
    tr_nr = size(data.trial,1);   
end

switch method
    case 'reject'
        all_trials                          = 1 : tr_nr;
        all_trials(trials_number_to_remove) = [];
            cfg                     = [];    
            cfg.trials              = all_trials;
            data_output             = ft_redefinetrial(cfg, data);
                display(['GIAC: removed ' num2str(length(trials_number_to_remove)) ' trials']);    
    
    case 'nan'
        data_output = data;       
        for special_tr = 1:length(trials_number_to_remove)
            tmp_tr = trials_number_to_remove(special_tr);
                data_output.trial{tmp_tr} = nan(size(data_output.trial{tmp_tr}));
        end
            display(['GIAC: replaced ' num2str(length(trials_number_to_remove)) ' trials with NaNs']);    
end           
end