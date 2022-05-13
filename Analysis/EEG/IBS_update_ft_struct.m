function [ft_struct] = IBS_update_ft_struct(ft_struct,varargin)

%% update time
time_range = strcmp(varargin,'time_range');
if sum(time_range)>0
    
    time_range_value = varargin{find(time_range)+1};
    min_time = time_range_value(1);
    max_time = time_range_value(2);

% min_time = min(ft_struct.time{1,1});
% max_time = max(ft_struct.time{1,1});
end
nTrials = numel(ft_struct.trial);
for trial = 1:nTrials
    
%     ft_struct.trial{1,trial} = processed_trials{trial};
    ft_struct.time{1,trial} = linspace(min_time,max_time,size(ft_struct.trial{1,trial},2));
end


end