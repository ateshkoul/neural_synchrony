function [stat_main_effects] = IBS_cluster_main_effects(combined_correlations,cond_no,test_freq,levels,cluster_cfg)
%% function to perform cluster based stats
% combined_correlations: (cell) ncond x nchan x nfreq cells
% cond_no              : (double) condition for which the main effect is
% needed
% test_freq            : (array) freq values at which to test
% levels               : (array) an array describing condition groups of
% conditions
% cluster_cfg          : (fieldtrip cfg) cfg file for cluster based stats


% script for a 2x2 ANOVA
%% Atesh Koul

if nargin<3
    test_freq = 1:95;
    levels = [1 1 2 2;1 2 1 2];
    cluster_cfg = IBS_get_anova_cluster_cfg();
end

if nargin <4
    levels = [1 1 2 2;1 2 1 2];
    
    cluster_cfg = IBS_get_anova_cluster_cfg();
end

if nargin <5
    cluster_cfg = IBS_get_anova_cluster_cfg();
end


%%

cond_level_1 = levels(cond_no,:) ==cond_no;
cond_level_2 = levels(cond_no,:) ~=cond_no;


cond_level_1_data = combined_correlations(:,cond_level_1);
cond_level_2_data = combined_correlations(:,cond_level_2);


avg_level_1 = IBS_apply_fun_arrays(cond_level_1_data(:,1),cond_level_1_data(:,2),@mean);
% avg_level_1 = arrayfun(@(x) (cond_level_1_data{x,1}+cond_level_1_data{x,2})/2,1:size(cond_level_1_data,1),'UniformOutput',false);
load('correlation_template_struct.mat');

template_struct.freq = test_freq;

data_all_sub_level_1 = cellfun(@(x) IBS_subs_data(template_struct,x) ,avg_level_1,'UniformOutput',false);

% this basically is just adding to the powspectrm the matrix avg_level_1;
% n = ft_timelockgrandaverage(cfg,data_all_sub{:});
cfg = [];
cfg.keepindividual = 'yes' ;
[grandavg_avg_level_1] = ft_freqgrandaverage(cfg, data_all_sub_level_1{:});


%%


% checked that the mean this way is correct
avg_level_2 = IBS_apply_fun_arrays(cond_level_2_data(:,1),cond_level_2_data(:,2),@mean);

% avg_level_2 = arrayfun(@(x) (cond_level_2_data{x,1}+cond_level_2_data{x,2})/2,1:size(cond_level_2_data,1),'UniformOutput',false);
load('correlation_template_struct.mat');
template_struct.freq = test_freq;
data_all_sub_level_2 = cellfun(@(x) IBS_subs_data(template_struct,x) ,avg_level_2,'UniformOutput',false);

% n = ft_timelockgrandaverage(cfg,data_all_sub{:});
cfg = [];
cfg.keepindividual = 'yes' ;
[grandavg_avg_level_2] = ft_freqgrandaverage(cfg, data_all_sub_level_2{:});


%%

cfg_neighb.method    = 'triangulation';%distance
cfg_neighb.layout    = ft_prepare_layout(cluster_cfg);

cluster_cfg.neighbours       = ft_prepare_neighbours(cfg_neighb, grandavg_avg_level_1);

subj = size(grandavg_avg_level_1.powspctrm,1);
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
cluster_cfg.ivar     = 2;
% it seems it is ok to have 2*subj no measurements
% [stat] = ft_freqstatistics(cfg, grandavg_FaOcc,grandavg_FaNoOcc,grandavg_NeOcc,grandavg_NeNoOcc);
[stat_main_effects] = ft_freqstatistics(cluster_cfg, grandavg_avg_level_1,grandavg_avg_level_2);
end
%%

% diff = [grandavg_avg_level_1.powspctrm-grandavg_avg_level_2.powspctrm];
% beta_clust = 1*(stat_main_effects.posclusterslabelmat==2);
% s = diff .* permute(repmat(beta_clust,1,1,23),[3 1 2]);
% beta_diff = squeeze(s(:,:,10));
% beta_cohend = nanmean(beta_diff)./nanstd(beta_diff);
% nanmean(beta_cohend)
% [value,idx] = max(beta_cohend)

% {'TP8'} 0.9052
% diff = [grandavg_avg_level_1.powspctrm-grandavg_avg_level_2.powspctrm];
% gamma_clust = 1*(stat_main_effects.posclusterslabelmat==1);
% s = diff .* permute(repmat(gamma_clust,1,1,23),[3 1 2]);
% gamma_diff = squeeze(s(:,:,12:14));
% gamma_cohend = nanmean(gamma_diff)./nanstd(gamma_diff);
% mean(nanmean(gamma_cohend))
% [value,idx] = max(gamma_cohend)
% stat_main_effects.label(60)
% 60 and 3 {'P8'}

% no ASR
% diff = [grandavg_avg_level_1.powspctrm-grandavg_avg_level_2.powspctrm];
% gamma_clust = 1*(stat_main_effects.posclusterslabelmat==1);
% s = diff .* permute(repmat(gamma_clust,1,1,23),[3 1 2]);
% gamma_diff = squeeze(s(:,:,9:14));
% gamma_cohend = nanmean(gamma_diff)./nanstd(gamma_diff);
% nanmean(nanmean(gamma_cohend))
% 
% 
% diff = [grandavg_avg_level_1.powspctrm-grandavg_avg_level_2.powspctrm];
% gamma_clust = 1*(stat_main_effects.posclusterslabelmat==2);
% s = diff .* permute(repmat(gamma_clust,1,1,23),[3 1 2]);
% gamma_diff = squeeze(s(:,:,9:14));
% gamma_cohend = nanmean(gamma_diff)./nanstd(gamma_diff);
% nanmean(nanmean(gamma_cohend))
% 

% aggressive
% diff = [grandavg_avg_level_1.powspctrm-grandavg_avg_level_2.powspctrm];
% gamma_clust = 1*(stat_main_effects.posclusterslabelmat==1);
% s = diff .* permute(repmat(gamma_clust,1,1,23),[3 1 2]);
% gamma_diff = squeeze(s(:,:,11:14));
% gamma_cohend = nanmean(gamma_diff)./nanstd(gamma_diff);
% nanmean(nanmean(gamma_cohend))
% [value,idx] = max(gamma_cohend)
% stat_main_effects.label(60)
% 60 and 3 {'P8'}


%% within

% diff = [grandavg_avg_level_1.powspctrm-grandavg_avg_level_2.powspctrm];
% gamma_clust = 1*(stat_main_effects.negclusterslabelmat==1);
% s = diff .* permute(repmat(gamma_clust,1,1,46),[3 1 2]);
% gamma_diff = squeeze(s(:,:,10:14));
% gamma_cohend = nanmean(gamma_diff)./nanstd(gamma_diff);
% nanmean(nanmean(gamma_cohend))
% [value,idx] = max(gamma_cohend)
% stat_main_effects.label(60)
% 60 and 3 {'P8'}

% vision pos
% diff = [grandavg_avg_level_1.powspctrm-grandavg_avg_level_2.powspctrm];
% gamma_clust = 1*(stat_main_effects.posclusterslabelmat==1);
% s = diff .* permute(repmat(gamma_clust,1,1,46),[3 1 2]);
% gamma_diff = squeeze(s(:,:,11:14));
% gamma_cohend = nanmean(gamma_diff)./nanstd(gamma_diff);
% nanmean(nanmean(gamma_cohend))
% [value,idx] = max(gamma_cohend)
% stat_main_effects.label(60)
% 60 and 3 {'P8'}

% find(sum(stat_main_effects.posclusterslabelmat ==1))
% diff = [grandavg_avg_level_1.powspctrm-grandavg_avg_level_2.powspctrm];
% gamma_clust = 1*(stat_main_effects.posclusterslabelmat==2);
% s = diff .* permute(repmat(gamma_clust,1,1,46),[3 1 2]);
% gamma_diff = squeeze(s(:,:,1:3));
% gamma_cohend = nanmean(gamma_diff)./nanstd(gamma_diff);
% nanmean(nanmean(gamma_cohend))
% [value,idx] = max(gamma_cohend)
% stat_main_effects.label(60)
% 60 and 3 {'P8'}



% diff = [grandavg_avg_level_1.powspctrm-grandavg_avg_level_2.powspctrm];
% gamma_clust = 1*(stat_main_effects.negclusterslabelmat==1);
% s = diff .* permute(repmat(gamma_clust,1,1,46),[3 1 2]);
% gamma_diff = squeeze(s(:,:,4:10));
% gamma_cohend = nanmean(gamma_diff)./nanstd(gamma_diff);
% nanmean(nanmean(gamma_cohend))
% [value,idx] = max(gamma_cohend)
% stat_main_effects.label(60)
% 60 and 3 {'P8'}

%%
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