function data_tf_bc = IBS_tf_fourier(dataset,trial_nos,foi,toi,baseline)

if nargin <3
    foi = 1:1:95;
    toi = 0:0.1:120;
    baseline = [0 120];
end


if nargin <4
    toi = 0:0.1:120;
    baseline = [0 120];
end

if nargin <5
    baseline = [0 120];
end

cfg            = [];
cfg.output     = 'fourier';
cfg.method     = 'mtmfft';
cfg.foi        = foi;
cfg.tapsmofrq  = 5;
cfg.keeptrials = 'yes';
cfg.trials     = ismember(dataset.trialinfo,trial_nos);

% cfg.channel    = {'MEG' 'EMGlft' 'EMGrgt'};
freqfourier    = ft_freqanalysis(cfg, dataset);

end