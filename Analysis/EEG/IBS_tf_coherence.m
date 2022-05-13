function data_tf_coh = IBS_tf_coherence(data_struct_S1,data_struct_S2,trial_nos,foi,varargin_table)


both_sub_cond_data = ft_appenddata([],data_struct_S1,data_struct_S2);



if nargin <4
    foi = 1:1:95;%[1 100]
end


cfg                 = [];
cfg.output          = 'fourier';%;%;%'powandcsd'
cfg.method          = 'mtmfft';
cfg.foi             = foi;
cfg.taper           = 'dpss';
cfg.tapsmofrq       = 2;
cfg.keeptrials      = 'yes';
% cfg.channelcmb      = cat(2,both_sub_cond_data.label(1:64),both_sub_cond_data.label(65:128));
cfg.trials          = ismember(both_sub_cond_data.trialinfo,trial_nos);

cfg.pad='nextpow2';
cfg.usegpu = false;
data_tf_coh    = ft_freqanalysis(cfg, both_sub_cond_data);
end