function cfg = IBS_get_anova_cluster_cfg(cfg)
%% Atesh Koul

if nargin <1
    
    cfg = [];
end
cfg.latency          = 1;
cfg.method           = 'montecarlo';
cfg.statistic        = 'ft_statfun_depsamplesT';
cfg.correctm         = 'cluster';%'cluster';%'no';%'holm';%'fdr';%'cluster';%
cfg.clusteralpha     = 0.05;
cfg.clusterstatistic = 'maxsum';%'maxsum';%'maxsum'; %'wcm' % 'maxsize'
% cfg.clusterthreshold = 'nonparametric_common';

cfg.minnbchan        = 3;
cfg.tail             = 0;
cfg.clustertail      = 0;
cfg.correcttail     = 'alpha';
% cfg.alpha            = 0.025; %https://www.fieldtriptoolbox.org/tutorial/cluster_permutation_timelock/#the-format-of-the-output
% a p-value less than the critical alpha-level of 0.025. This critical alpha-level corresponds to a false alarm rate of 0.05 in a two-sided test. 
% This alpha is seen in the stat.mask parameter
cfg.alpha            = 0.05;

cfg.numrandomization = 1000;
cfg.layout           = 'IBS_layout_64.mat';
% while choosing specific channels - for cluster based results, there has
% to be min 3 channels and atleast some channel that is a bit outside for a cluster to be formed
cfg.channel          = 'all'; % use all channes {'TP7','CP1','CP3','CP5'};%{'T8','C6','TP8','P6','P8','P10','PO8'};{'TP7','P5','P7','P9','PO7'};%
cfg.frequency        = 'all'; % use all frequencies [55 95];[35 95];

cfg.avgoverchan      = 'no'; % Do NOT average over channels
cfg.avgoverfreq      = 'no'; % Do NOT average over frequencies
cfg.avgovertime      = 'no'; % Do NOT average over time
end