function [ft_struct] = IBS_apply_fun_ft_struct(ft_struct,fun,varargin)


if nargin <2
   fun = @(x) fft(x,[],1); 
end


processed_trials = cellfun(@(x) fun(x,varargin{:}),ft_struct.trial,'UniformOutput',false); 

% wrong
% ft_struct.trial = asr_cleaned_trials;
% assume that the function is just reducing the columns not shortening the time tange
min_time = min(ft_struct.time{1,1});
max_time = max(ft_struct.time{1,1});

nTrials = numel(ft_struct.trial);
for trial = 1:nTrials
    
    ft_struct.trial{1,trial} = processed_trials{trial};
    ft_struct.time{1,trial} = linspace(min_time,max_time,size(processed_trials{trial},2));
end

end