function [stat] = IBS_cluster_interaction(combined_correlations,test_freq,levels,cluster_cfg)
%% function to perform cluster based stats
% combined_correlations: (cell) ncond x nchan x nfreq cells
% test_freq            : (array) freq values at which to test
% levels               : (array) an array describing condition groups of
% conditions
% cluster_cfg          : (fieldtrip cfg) cfg file for cluster based stats


%% Atesh
% function to test interaction effects.


if nargin <2
    test_freq = 1:95;
    
end
if nargin<3
    
    levels = [1 1 2 2;1 2 1 2];
    cluster_cfg = IBS_get_anova_cluster_cfg();
end


if nargin <4
    cluster_cfg = IBS_get_anova_cluster_cfg();
end
cond_level_1_1 = levels(1,:) ==1 & levels(2,:) == 1;
cond_level_1_2 = levels(1,:) ==1 & levels(2,:) == 2;
cond_level_2_1 = levels(1,:) ==2 & levels(2,:) == 1;
cond_level_2_2 = levels(1,:) ==2 & levels(2,:) == 2;

cond_level_1_1_data = combined_correlations(:,cond_level_1_1);
cond_level_1_2_data = combined_correlations(:,cond_level_1_2);
cond_level_2_1_data = combined_correlations(:,cond_level_2_1);
cond_level_2_2_data = combined_correlations(:,cond_level_2_2);

% FaOcc = s(:,2);
% FaNoOcc = s(:,3);


% diff_level_1 = cellfun(@(x,y) x-y,cond_level_1_1_data,cond_level_1_2_data,'UniformOutput',false);
diff_level_1 = cellfun(@(x,y) x-y,cond_level_1_1_data,cond_level_2_1_data,'UniformOutput',false);


load('correlation_template_struct.mat');
template_struct.freq = test_freq;
data_all_sub_level_1 = cellfun(@(x) IBS_subs_data(template_struct,x) ,diff_level_1,'UniformOutput',false);


% n = ft_timelockgrandaverage(cfg,data_all_sub{:});
cfg = [];
cfg.keepindividual = 'yes' ;
[grandavg_diff_level_1] = ft_freqgrandaverage(cfg, data_all_sub_level_1{:});


%%

% NeOcc = s(:,4);
% NeNoOcc = s(:,5);


% diff_level_2 = cellfun(@(x,y) x-y,cond_level_2_1_data,cond_level_2_2_data,'UniformOutput',false);
diff_level_2 = cellfun(@(x,y) x-y,cond_level_1_2_data,cond_level_2_2_data,'UniformOutput',false);

load('correlation_template_struct.mat');
template_struct.freq = test_freq;

data_all_sub_level_2 = cellfun(@(x) IBS_subs_data(template_struct,x) ,diff_level_2,'UniformOutput',false);


% n = ft_timelockgrandaverage(cfg,data_all_sub{:});
cfg = [];
cfg.keepindividual = 'yes' ;
[grandavg_diff_level_2] = ft_freqgrandaverage(cfg, data_all_sub_level_2{:});



%%

% specifies with which sensors other sensors can form clusters
cfg_neighb.method    = 'triangulation';%'distance';
%cfg_neighb.neighbourdist    = 2; % boh not sure about what value to use here.
cfg_neighb.layout    = ft_prepare_layout(cluster_cfg);

cluster_cfg.neighbours       = ft_prepare_neighbours(cfg_neighb, grandavg_diff_level_1);

subj = size(grandavg_diff_level_1.powspctrm,1);
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

[stat] = ft_freqstatistics(cluster_cfg, grandavg_diff_level_1,grandavg_diff_level_2);



end



% diff = [grandavg_diff_level_1.powspctrm-grandavg_diff_level_2.powspctrm];
% alpha_clust = 1*(stat.negclusterslabelmat==1);
% s = diff .* permute(repmat(alpha_clust,1,1,23),[3 1 2]);
% alpha_diff = squeeze(s(:,:,7));
% alpha_cohend = nanmean(alpha_diff)./nanstd(alpha_diff);
% nanmean(alpha_cohend)
% [value,idx] = max(beta_cohend)

%% within interaction
% diff = [grandavg_diff_level_1.powspctrm-grandavg_diff_level_2.powspctrm];
% alpha_clust = 1*(stat.negclusterslabelmat==1);
% s = diff .* permute(repmat(alpha_clust,1,1,46),[3 1 2]);
% alpha_diff = squeeze(s(:,:,6:10));
% alpha_cohend = nanmean(alpha_diff)./nanstd(alpha_diff);
% nanmean(nanmean(alpha_cohend))
% [value,idx] = max(beta_cohend)
