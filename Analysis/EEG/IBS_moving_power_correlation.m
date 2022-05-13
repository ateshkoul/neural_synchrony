function [moving_correlation] = IBS_moving_power_correlation(data_struct_1,data_struct_2,freq_bands,windowSize)

k1 = data_struct_1.powspctrm;

k2 = data_struct_2.powspctrm;
windowSize_cols = windowSize*(length(data_struct_1.time)-1)/data_struct_1.time(end);
nTrials = size(k1,1);
moving_correlation = arrayfun(@(x) IBS_moving_correlation(squeeze(k1(x,:,:,:)),...
    squeeze(k2(x,:,:,:)),freq_bands,windowSize_cols,'centered'),1:nTrials,'UniformOutput',false);
end