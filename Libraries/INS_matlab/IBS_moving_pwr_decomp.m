function [moving_correlation] = IBS_moving_pwr_decomp(data_struct_1,windowSize)

k1 = data_struct_1.powspctrm;

windowSize_cols = windowSize*(length(data_struct_1.time)-1)/data_struct_1.time(end);
nTrials = size(k1,1);


stepSize_cols =  (windowSize/2)*(length(data_struct_1.time)-1)/data_struct_1.time(end);
% stepSize_cols =  (windowSize)*(length(data_struct_1.time)-1)/data_struct_1.time(end);
% stepSize_cols = 1;
moving_correlation = arrayfun(@(x) IBS_moving_apply_fun(squeeze(k1(x,:,:,:)),...
    windowSize_cols,stepSize_cols),1:nTrials,'UniformOutput',false);
end