function [correlation_cond,process_pwr_correlation] = IBS_process_pwr_correlations(correlations_cell,type,analysis_type,freq_type)
if nargin <4
    
   freq_type = 'all_freq'; 
end

switch (freq_type)
    case 'all_freq'
        % function checked
        s = cat(1,correlations_cell{:});
    case 'freqwise'
        s = IBS_convert_freqwise(correlations_cell,analysis_type);
end

nCond = size(s,2);
correlation_cond = cell([1 nCond]);

for cond = 1:nCond%length(conditions)
    correlation_cond{cond} = cat(3,s{:,cond});
end

% test for checking above computation is correct
% for cond = 1:7
% for Dyd_no=1:21
%    Cond{1,cond}(:,:,Dyd_no) = correlations_cell{1,Dyd_no}{1,cond};
%
% end
% end
% sum(sum(sum(correlation_cond{1,3} - Cond{1,3})))



switch(type)
    case 'mean'
        % this gives the mean of the conditions
        % checked that the mean is across the subjects for each frequency
        % and for each channel
        process_pwr_correlation = cellfun(@(x) mean(x,3),correlation_cond,'UniformOutput', false);
    case 't_value'
        process_pwr_correlation = cell([1 nCond]);
        [nChan,nFreq,~] = size(correlation_cond{1,1});
        % checked that the nCond, nChan and nFreq are correct
        for cond = 1:nCond
            for chan = 1:nChan
                for freq = 1:nFreq
                    [~,~,~,d] = ttest(correlation_cond{1,cond}(chan,freq,:));
                    process_pwr_correlation{1,cond}(chan,freq) = d.tstat;
                end
            end
        end
        
    case 't_test_NeNoOcc_Task'
        conditions = IBS_get_params_analysis_type(analysis_type).conditions;
        NeNoOcc_loc = strcmp(conditions,'NeNoOcc');
        Task_loc = strcmp(conditions,'Task');
        [nChan,nFreq,~] = size(correlation_cond{1,1});
        % checked that the nCond, nChan and nFreq are correct
        for chan = 1:nChan
            for freq = 1:nFreq
                [~,~,~,d] = ttest(correlation_cond{1,NeNoOcc_loc}(chan,freq,:),correlation_cond{1,Task_loc}(chan,freq,:));
                process_pwr_correlation(chan,freq) = d.tstat;
            end
        end
        
end
end