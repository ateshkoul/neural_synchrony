[correlations_cell,conditions] = IBS_tf_correlations;
s = cat(1,correlations_cell{:});

cfg = [];
% FaOcc = s(:,2);
FaOcc = s(:,1);
load('correlation_template_struct.mat');

data_all_sub_FaOcc = cellfun(@(x) IBS_subs_data(template_struct,x) ,FaOcc,'UniformOutput',false);


% n = ft_timelockgrandaverage(cfg,data_all_sub{:});
cfg = [];
cfg.keepindividual = 'yes' ;
[grandavg_FaOcc] = ft_freqgrandaverage(cfg, data_all_sub_FaOcc{:});


%%

cfg = [];
% FaNoOcc = s(:,3);
FaNoOcc = s(:,2);
load('correlation_template_struct.mat');

data_all_sub_FaNoOcc = cellfun(@(x) IBS_subs_data(template_struct,x) ,FaNoOcc,'UniformOutput',false);


% n = ft_timelockgrandaverage(cfg,data_all_sub{:});
cfg = [];
cfg.keepindividual = 'yes' ;
[grandavg_FaNoOcc] = ft_freqgrandaverage(cfg, data_all_sub_FaNoOcc{:});



%%

cfg = [];
% NeOcc = s(:,4);
NeOcc = s(:,3);
load('correlation_template_struct.mat');

data_all_sub_NeOcc = cellfun(@(x) IBS_subs_data(template_struct,x) ,NeOcc,'UniformOutput',false);


% n = ft_timelockgrandaverage(cfg,data_all_sub{:});
cfg = [];
cfg.keepindividual = 'yes' ;
[grandavg_NeOcc] = ft_freqgrandaverage(cfg, data_all_sub_NeOcc{:});


%%

cfg = [];
% NeNoOcc = s(:,5);
NeNoOcc = s(:,4);
load('correlation_template_struct.mat');

data_all_sub_NeNoOcc = cellfun(@(x) IBS_subs_data(template_struct,x) ,NeNoOcc,'UniformOutput',false);


% n = ft_timelockgrandaverage(cfg,data_all_sub{:});
cfg = [];
cfg.keepindividual = 'yes' ;
[grandavg_NeNoOcc] = ft_freqgrandaverage(cfg, data_all_sub_NeNoOcc{:});


%%


[correlations_cell,conditions] = IBS_tf_correlations;
s = cat(1,correlations_cell{:});

FaOcc = s(:,1);
FaNoOcc = s(:,2);


diff_Fa = cellfun(@(x,y) x-y,FaOcc,FaNoOcc,'UniformOutput',false);
load('correlation_template_struct.mat');

data_all_sub_Fa = cellfun(@(x) IBS_subs_data(template_struct,x) ,diff_Fa,'UniformOutput',false);


% n = ft_timelockgrandaverage(cfg,data_all_sub{:});
cfg = [];
cfg.keepindividual = 'yes' ;
[grandavg_Fa] = ft_freqgrandaverage(cfg, data_all_sub_Fa{:});


%%

NeOcc = s(:,3);
NeNoOcc = s(:,4);


diff_Ne = cellfun(@(x,y) x-y,NeOcc,NeNoOcc,'UniformOutput',false);
load('correlation_template_struct.mat');

data_all_sub_Ne = cellfun(@(x) IBS_subs_data(template_struct,x) ,diff_Ne,'UniformOutput',false);


% n = ft_timelockgrandaverage(cfg,data_all_sub{:});
cfg = [];
cfg.keepindividual = 'yes' ;
[grandavg_Ne] = ft_freqgrandaverage(cfg, data_all_sub_Ne{:});
