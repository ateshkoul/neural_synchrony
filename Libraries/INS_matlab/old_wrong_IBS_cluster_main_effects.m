function [stat_main_effects] = IBS_cluster_main_effects(grandavg_main_effects,ivar,cluster_cfg)
% grandavg_main_effects: cell


if nargin <3
    cluster_cfg = IBS_get_anova_cluster_cfg();
end
% cfg = [];
% cfg.latency          = [1];
% cfg.method           = 'montecarlo';
% cfg.statistic        = 'ft_statfun_depsamplesT';
% cfg.correctm         = 'cluster';
% cfg.clusteralpha     = 0.05;
% cfg.clusterstatistic = 'maxsum';
% cfg.minnbchan        = 3;
% cfg.tail             = 0;
% cfg.clustertail      = 0;
% cfg.alpha            = 0.025;
% cfg.numrandomization = 500;
% cfg.layout = 'IBS_layout_64.mat';
% cfg.channel          = 'all'; % use all channes
% cfg.frequency        = 'all'; % use all frequencies
% cfg.latency          = 'all'; % use all time points
%
% cfg.avgoverchan      = 'no'; % Do NOT average over channels
% cfg.avgoverfreq      = 'no'; % Do NOT average over frequencies
% cfg.avgovertime      = 'no'; % Do NOT average over time
% specifies with which sensors other sensors can form clusters
cfg_neighb.method    = 'triangulation';%distance
cfg_neighb.layout    = ft_prepare_layout(cluster_cfg);

cluster_cfg.neighbours       = ft_prepare_neighbours(cfg_neighb, grandavg_main_effects{1,1});

subj = size(grandavg_main_effects{1,1}.powspctrm,1);
design = zeros(2,2*subj);
for i = 1:subj
    design(1,i) = i;
end
for i = 1:subj
    design(1,subj+i) = i;
end

design(2,1:subj)        = 1;%
design(2,subj+1:2*subj) = 2;%

cluster_cfg.design   = design;
cluster_cfg.uvar     = 1;
cluster_cfg.ivar     = ivar;%2 or 3

% [stat] = ft_freqstatistics(cfg, grandavg_FaOcc,grandavg_FaNoOcc,grandavg_NeOcc,grandavg_NeNoOcc);
[stat_main_effects] = ft_freqstatistics(cluster_cfg, grandavg_main_effects{:});
end



% 
% design = zeros(3,4*subj);
% for i = 1:subj
%     design(1,i) = i;
% end
% for i = 1:subj
%     design(1,subj+i) = i;
% end
% 
% design(2,1:2*subj)        = 1;% Far
% design(2,2*subj+1:4*subj) = 2;% Near
% 
% 
% design(3,1:subj)        = 1;% Occ
% design(3,subj+1:2*subj) = 2;% No Occ
% 
% design(3,2*subj+1:3*subj) = 1;% Occ
% design(3,3*subj+1:4*subj) = 2;% No Occ



% 
% [FieldTrip] depsamplesF
% Eric Maris e.maris at donders.ru.nl
% Fri Jan 28 10:43:42 CET 2011
% Previous message (by thread): [FieldTrip] depsamplesF
% Next message (by thread): [FieldTrip] help with inverse computing
% Messages sorted by: [ date ] [ thread ] [ subject ] [ author ]
% Hi Tom,
% 
%  
% 
%  
% 
% To test main and interaction effects in your 2x2 within subjects design, you
% have to perform 3 tests, each using the statfun desamplesT. Say you have the
% output of ft_timelockanalysis for all four conditions: tlout_Ia, tlout_Ib,
% tlout_IIa, tlout_IIb. Your then proceed as follows:
% 
%  
% 
% 1.   Main effect of I versus II: calculate the mean of tlout_Ia.avg and
% tlout_Ib.avg and put this is a a new struct variable tlout_I, which has the
% same fields as tlout_Ia and tlout_Ib. Do the same with tlout_IIa.avg and
% tlout_IIb.avg and make a new struct variable tlout_II. Then run
% ft_timelockstatistics with input arguments tlout_I and tlout_II. With this
% analysis you will test the main effect of I-versus-II.
% 
% 2.   In the same way, you now test the main effect of a versus b. In your
% calculations, the roles of (I,II) and (a,b) are now reversed.
% 
% 3.   Interaction of I-vs-II and a-vs-b. Calculate the differences
% (tlout_Ia.avg-tlout_Ib.avg) and (tlout_IIa.avg-tlout_IIb.avg), put them in
% output structures and statistically compare them using
% ft_timelockstatistics. With this analysis, you test the interaction of
% I-vs-II and a-vs-b.
% 
%  
% 
% There is no need for Bonferroni correction or an adjustment of
% cfg.clusteralpha (which does not affect the false alarm rate anyhow) and
% cfg.alpha.
% 
%  
% 
%  
% 
% Best,
% 
%  
% 
% Eric Mari