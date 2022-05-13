function [stat] = IBS_cluster_one_way_anova(combined_correlation,test_freq,levels,cluster_cfg)
%% Atesh
% function to test one way independent anova.


if nargin<4
    
    cluster_cfg = IBS_get_anova_cluster_cfg();
end


cluster_cfg.statistic        = 'ft_statfun_indepsamplesF';
cluster_cfg.tail = 1;
cluster_cfg.clustertail = 1;
cluster_cfg.alpha = 0.05;
cluster_cfg.clusteralpha = 0.05;
cluster_cfg.numrandomization = 1000;

for level_no = 1:length(unique(levels))
    unique_levels = unique(levels);
    combined_correlation_levels{level_no} = combined_correlation(levels==unique_levels(level_no));
    
end
load('correlation_template_struct.mat');
template_struct.freq = test_freq;
data_all_sub_levels = cellfun(@(y) cellfun(@(x) IBS_subs_data(template_struct,x) ,...
    y,'UniformOutput',false),combined_correlation_levels,'UniformOutput',false);

%%
% n = ft_timelockgrandaverage(cfg,data_all_sub{:});
for level_no = 1:length(unique(levels))
    cur_data_all_sub_levels = data_all_sub_levels{level_no};
    cfg = [];
    cfg.keepindividual = 'yes' ;
    grandavg_level{level_no} = ft_freqgrandaverage(cfg, cur_data_all_sub_levels{:});
    
end

%%

% specifies with which sensors other sensors can form clusters
cfg_neighb.method    = 'triangulation';%'distance';
%cfg_neighb.neighbourdist    = 2; % boh not sure about what value to use here.
cfg_neighb.layout    = ft_prepare_layout(cluster_cfg);

cluster_cfg.neighbours       = ft_prepare_neighbours(cfg_neighb, grandavg_level{1,1});


%% design
total_sub_no = length(levels);

design = zeros(2,(total_sub_no));
prev_subj_no = 0;    
unique_levels = unique(levels);

for level_no = 1:length(unique(levels))
    
    
    cur_subj_no = sum(levels==unique_levels(level_no));
    
    
    for i = 1:cur_subj_no
        design(1,prev_subj_no+i) = i;
    end
    design(2,prev_subj_no+1:(prev_subj_no+cur_subj_no))        = unique_levels(level_no);%

    prev_subj_no = prev_subj_no + cur_subj_no;
    
    
    
    
    
end

cluster_cfg.design   = design;
cluster_cfg.ivar     = 2;

[stat] = ft_freqstatistics(cluster_cfg, grandavg_level{:});



end