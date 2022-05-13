function [moving_value] = IBS_moving_apply_fun(data_trial,windowSize_cols,stepSize,apply_fun)
if nargin <3
stepSize =1;
end

if nargin <4
apply_fun = @(x) mean(x,2,'omitnan');
end
nChan = size(data_trial,1);
data_trial = padarray(data_trial,[0 0 windowSize_cols/2],NaN);% 1 10 100


for chan = 1:nChan
    
    [N,M] = size(squeeze(data_trial(chan,:,:)));
    %             for t = (windowSize_cols/2)+1:(M-(windowSize_cols/2))
    moving_value{chan} = nan(M-windowSize_cols,N);
    for t = 1:stepSize:(M-windowSize_cols)
        
        C = apply_fun(squeeze(data_trial(chan,:,t:t+windowSize_cols-1)));
        
        % t+(windowSize_cols/2)-1 is ok because then I remove the first columns which effectively makes
        % this the central value
        % from the perspective of understanding t+(windowSize_cols/2)-1 makes sense
        % but practically just t makes sense
        %                 moving_correlation{chan}(t+(windowSize_cols/2)-1,:) = C;
        moving_value{chan}(t,:) = C;
        
    end
    
    % this has to be in combination with moving_correlation{chan}(t+(windowSize_cols/2)-1,:) = C;
    % however the parallel loop doesn't work with this.
    %                moving_correlation{chan} = moving_correlation{chan}((windowSize_cols/2):end,:);
    
end
moving_value = permute(cat(3,moving_value{:}),[3 1 2]);

end