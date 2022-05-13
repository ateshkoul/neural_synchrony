function [correlation] = IBS_power_moving_correlation(data_pwr_struct1,data_pwr_struct2)


correlation = [];
nbands = size(data_pwr_struct1.powspctrm,3);
nchans = size(data_pwr_struct1.powspctrm,2);
nTrials = size(data_pwr_struct1.powspctrm,1);
for trial = 1:nTrials
for chan = 1:nchans
for band = 1:nbands
    correlation(chan,band,trial) =  diag(corr(squeeze(data_pwr_struct1.powspctrm(trial,chan,band,1:end-5)),squeeze(data_pwr_struct2.powspctrm(trial,chan,band,1:end-5))));
end
end
end
% figure();imagesc(correlation,[0,0.3]);

correlation = mean(correlation,3);
end