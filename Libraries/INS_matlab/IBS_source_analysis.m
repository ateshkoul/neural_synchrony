%%
ft_defaults
%%


analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
analysis_type_params = IBS_get_params_analysis_type(analysis_type);
data_dir = analysis_type_params.data_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
data = IBS_load_clean_IBS_data(1,analysis_type,data_dir);
%%
cfg_append = [];
data_S1_all = ft_appenddata(cfg_append,data.data_ica_clean_S1{:});

%%

cfg = [];
% cfg.channel      = {'1-C6','1-T8','1-TP8','1-CP6'};
cfg.method       = 'mtmconvol';
% cfg.taper        = 'dpss';
cfg.taper               = 'hanning';     %default = 'dpss' (freek's?)   'hanning'

cfg.output       = 'powandcsd';
cfg.keeptrials   = 'no';
cfg.foi          = 30:95;
% cfg.tapsmofrq    = 4;
cfg.t_ftimwin           = ones(length(cfg.foi),1) .* linspace(.5,.1,length(30:95))';%ones(size(cfg.foi)) * 0.5;.*0.25;% length of time window ||  WAS :.*[linspace(.4,.1,40)]
cfg.toi = 0:0.1:120;
cfg.pad='nextpow2';
% cfg.method       = 'mtmfft';
% cfg.taper        = 'dpss';
% cfg.pad          = 'nextpow2';
% cfg.output       = 'powandcsd';
% cfg.keeptrials   = 'no';
% cfg.foi          = 26:31;
% cfg.tapsmofrq    = 4;

% for common filter over conditions
powcsd_all     = ft_freqanalysis(cfg, data_S1_all);


%%

cfg = [];
% cfg.channel      = {'1-C6','1-T8','1-TP8','1-CP6'};
% cfg.method       = 'mtmfft';
cfg.method       = 'mtmconvol';

% cfg.taper        = 'dpss';
cfg.pad          = 'nextpow2';
cfg.output       = 'powandcsd';
cfg.keeptrials   = 'no';
cfg.foi          = 30:95;
cfg.taper               = 'hanning';     %default = 'dpss' (freek's?)   'hanning'

% cfg.tapsmofrq    = 4;
cfg.trials       = ismember(data.data_ica_clean_S1{1, 2}.trialinfo,[51 52 53]);
cfg.t_ftimwin           = ones(length(cfg.foi),1) .* linspace(.5,.1,length(30:95))';%ones(size(cfg.foi)) * 0.5;.*0.25;% length of time window ||  WAS :.*[linspace(.4,.1,40)]
cfg.toi = 0:0.1:120;
cfg.pad='nextpow2';
% for common filter over conditions
powcsd_NeNoOcc     = ft_freqanalysis(cfg, data.data_ica_clean_S1{1, 2});




% cfg = [];
% cfg.channel      = {'1-C6','1-T8','1-TP8','1-CP6'};
% cfg.method       = 'mtmfft';
% cfg.taper        = 'dpss';
% cfg.pad          = 'nextpow2';
% cfg.output       = 'powandcsd';
% cfg.keeptrials   = 'no';
% cfg.foi          = 26:31;
% cfg.tapsmofrq    = 4;
% 
% % for common filter over conditions
% powcsd_baseline    = ft_freqanalysis(cfg, data.data_ica_clean_S1{1, 1});

%%
% load vol;
% % Create source model with leadfields
% cfg                 = [];
% cfg.channel         = {'1-C6','1-T8','1-TP8','1-CP6'};
% cfg.grad            = powcsd_all.powspctrm;
% cfg.headmodel       = vol;
% cfg.dics.reducerank = 3;     % default for MEG is 2, for EEG is 3
% cfg.resolution      = 0.5;   % use a 3-D grid with a 0.5 cm resolution
% cfg.unit            = 'cm';
% cfg.tight           = 'yes';
% [grid] = ft_prepare_leadfield(cfg);
%%
% load dipoli headmodel vol
load vol;
mri = ft_read_mri('Subject01.mri');
nas=mri.hdr.fiducial.mri.nas;
lpa=mri.hdr.fiducial.mri.lpa;
rpa=mri.hdr.fiducial.mri.rpa;

transm=mri.transform;

nas=ft_warp_apply(transm,nas, 'homogenous');
lpa=ft_warp_apply(transm,lpa, 'homogenous');
rpa=ft_warp_apply(transm,rpa, 'homogenous');

elec = ft_read_sens('standard_1020.elc');

% create a structure similar to a template set of electrodes
fid.elecpos       = [nas; lpa; rpa];       % ctf-coordinates of fiducials
fid.label         = {'Nz','LPA','RPA'};    % same labels as in elec
fid.unit          = 'mm';                  % same units as mri

% alignment
cfg               = [];
cfg.method        = 'fiducial';
cfg.target        = fid;                   % see above
cfg.elec          = elec;
cfg.fiducial      = {'Nz', 'LPA', 'RPA'};  % labels of fiducials in fid and in elec
elec_aligned      = ft_electroderealign(cfg);


%%
figure;
ft_plot_sens(elec,'style','k');
hold on;
ft_plot_mesh(vol.bnd(1),'facealpha', 0.85, 'edgecolor', 'none', 'facecolor', [0.65 0.65 0.65]);

ft_plot_headmodel(ft_convert_units(vol,'cm'));
%%
cfg                 = [];
cfg.mri             = mri;
cfg.sourceunits     = vol.unit;
grid                = ft_prepare_sourcemodel(cfg);


cfg            = [];
cfg.headmodel  = vol;
cfg.elec       = elec_aligned;
cfg.grid       = grid;
cfg.reducerank = 3; % default is 3 for EEG, 2 for MEG

lf             = ft_prepare_leadfield(cfg);

%%
% common grid/filter
% cfg            = [];
% cfg.elec       = powcsd_all.elec;
% cfg.headmodel  = vol;
% cfg.reducerank = 3; % default is 3 for EEG, 2 for MEG
% cfg.resolution = 0.5;   % use a 3-D grid with a 0.5 cm resolution
% cfg.unit       = 'cm';
% cfg.tight      = 'yes';
% [grid] = ft_prepare_leadfield(cfg);

%%
% beamform common filter
cfg                 = [];
% cfg.channel         = {'1-C6','1-T8','1-TP8','1-CP6'}; % not best for
% beamforming u should use all channels
cfg.method          = 'dics';
cfg.frequency       = 30:95;
cfg.grid            = grid;
cfg.headmodel       = vol;
cfg.senstype        = 'EEG'; % Remember this must be specified as either EEG, or MEG
cfg.dics.keepfilter = 'yes';
cfg.dics.lambda     = '15%';
source_NeNoOcc = ft_sourceanalysis(cfg, powcsd_NeNoOcc);
