function data_tf = IBS_tf_within(dataset,trial_nos,foi,toi,baseline)
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


cfg                     = [];
cfg.method              = 'mtmconvol';
cfg.taper               = 'hanning';     %default = 'dpss' (freek's?)   'hanning'
cfg.output              = 'pow';
cfg.foi                 = foi;
cfg.toi                 = toi;
cfg.pad                 = 'maxperlen';   % provisory should speed up
cfg.t_ftimwin           = ones(length(cfg.foi),1) .* linspace(.5,.1,95)';%ones(size(cfg.foi)) * 0.5;.*0.25;% length of time window ||  WAS :.*[linspace(.4,.1,40)]
cfg.polyremoval         = 0;
cfg.keeptrials          = 'yes';%'no';
cfg.trials              = ismember(dataset.trialinfo,trial_nos);
cfg.usegpu              = true; 
data_tf                 = ft_freqanalysis(cfg, dataset);


% cfg                     = [];
% cfg.baselinetype        = 'normchange';%'normchange';%;%'relative';%'normchange';%'absolute';(1:10) % relative is bad
% [data_tf_bc]            = IBS_tf_compute_joint_baseline(cfg, data_tf);


% 
% cfg                     = [];
% cfg.baseline            = baseline;
% cfg.baselinetype        = 'normchange';%'normchange';%;%'relative';%'normchange';%'absolute';(1:10) % relative is bad
% [data_tf_bc]            = ft_freqbaseline(cfg, data_tf);



end