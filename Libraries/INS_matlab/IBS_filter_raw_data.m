function dataset_filt = IBS_filter_raw_data(dataset,hp_filter)
if nargin<2
    hp_filter = 0.3;
end

cfg = [];
% cfg.channel              = [1:144];
cfg.hpfilter             = 'yes';
cfg.hpfreq               = hp_filter;                  % CF. Massih and Mu-Iannetti was 1, but noticed the vertex wave is very low freq
cfg.hpfiltord            = 3;
cfg.hpfilttype           = 'but';
cfg.hpfiltdir            = 'twopass';
cfg.lpfilter             = 'yes';
cfg.lpfreq               = 95;                 % up to 100 Hz
cfg.lpfiltord            = 3;
cfg.lpfilttype           = 'but';
cfg.lpfiltdir            = 'twopass';
cfg.bsfilter             = 'yes';              % working as a NOTCH filter around 50Hz
cfg.bsfreq               = [47 53];            % or whatever you deem appropriate

dataset_filt =  ft_preprocessing(cfg, dataset);

end
