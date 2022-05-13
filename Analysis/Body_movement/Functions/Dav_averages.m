function [grand_avg, grand_std] = Dav_averages(data, method)

% DAV_AVERAGES calculates the grand_avg and grand_std for input method across all time series (i.e. all trials!!) of data struct
% The data must have default FIELDTRIP structure (trials, labels, time)

% Input   :   data --> struct containing all data
%                   trials. rows   = channels.  
%                   trials.columns = time points
% 
% Analysis:   method 
%                 --> 'std'  calculates the std for each trial 
%                 --> 'mean' calculates the mean for each trial 

% Output  : grand_avg and grand_std


% Initialising empty std_array which contains stds for all trials 
std_array     = nan(1,   length(data.trial).* length(data.label));   
std_array(:)  = 1000;    %can't use nan because data has nan too


for tr = 1 : length(data.trial)

    indy_start = find((std_array==1000), 1, 'first');
    indy_end   = (indy_start + length(data.label) -1);
    
    switch method 
        case 'std' 
    std_array(indy_start : indy_end)  = nanstd(data.trial{tr}, [], 2)'; 
    
        case 'mean'
    std_array(indy_start : indy_end)  = nanmean(data.trial{tr}, [], 2)';  
    end
    
end


% Taking mean and std of all trails stds 
grand_avg = nanmean(std_array);
grand_std = nanstd(std_array);
end



