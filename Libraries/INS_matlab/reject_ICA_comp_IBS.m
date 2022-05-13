function data_ica_clean = reject_ICA_comp_IBS(data,eeg_channels,non_eeg_channels,cmp_nr,comps_to_reject)


%% from GIAC_toolbox

close all

% remove non-cortical data (as indixed by 'channels' above) in order to let 'ft_rejectcomponent' work properly (otherwise you get error messages)
cfg                 = [];
cfg.channel         = eeg_channels; % 'EEG'; only EEG channels are considered (non EEG should not enter into ICA)
data_onlyEEG        = ft_selectdata(cfg, data);

% isolate non-cortical data (useful for display)
% non_EEG_ch  = find(ismember(data.label,data_onlyEEG.label)==0);
non_EEG_ch  = non_eeg_channels;

cfg         = [];
cfg.channel = non_EEG_ch; %data.label(non_EEG_ch);
data_noEEG  = ft_selectdata(cfg, data);

%% ICA - Run ICA,
cfg                 = [];
cfg.method          = 'runica';
cfg.numcomponent    = cmp_nr;
cfg.channel         = eeg_channels; %'EEG';
% the random seem makes the analysis give the same result over and over
% again
cfg.randomseed      = 42;
comp                = ft_componentanalysis(cfg, data_onlyEEG);

% remove selected components
cfg                 = [];
cfg.component       = comps_to_reject;
[data_ica_clean]          = ft_rejectcomponent(cfg, comp, data_onlyEEG);


end