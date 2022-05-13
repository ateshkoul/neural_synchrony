function [stat] = IBS_cluster_F_test(combined_correlations,test_freq,levels,test_type,cluster_cfg)
%% Atesh
% function to test two sample tests - paired and independent.
% combined_correlations - cell to test. 1 column for independent and 2 for
% dependent
% levels has to be equal to that of rows of combined_correlations
% signifying which group the two belong.
% test_type - paired or independent

% if nargin <2
%     test_freq = 1:95;
% end

if nargin<5
    
    cluster_cfg = IBS_get_anova_cluster_cfg();
end

switch(test_type)
%     case 'paired'
%         cluster_cfg.statistic        = 'ft_statfun_depsamplesT';
%         combined_correlations = cat(1,combined_correlations{:});
%         subj = size(combined_correlations,1);
%         subj_1 = subj/2;
%         subj_2 = subj/2;
%         cluster_cfg.uvar     = 1;

    case 'independent'
        cluster_cfg.statistic        = 'ft_statfun_indepsamplesF';
        subj_1 = sum(levels==1);
        subj_2 = sum(levels==2);
        subj_3 = sum(levels==3);
end


combined_correlations_level_1 = combined_correlations(levels==1);
combined_correlations_level_2 = combined_correlations(levels==2);
combined_correlations_level_3 = combined_correlations(levels==3);

load('correlation_template_struct.mat');
template_struct.freq = test_freq;
data_all_sub_level_1 = cellfun(@(x) IBS_subs_data(template_struct,x) ,combined_correlations_level_1,'UniformOutput',false);

%%
load('correlation_template_struct.mat');
template_struct.freq = test_freq;
data_all_sub_level_2 = cellfun(@(x) IBS_subs_data(template_struct,x) ,combined_correlations_level_2,'UniformOutput',false);

%%
load('correlation_template_struct.mat');
template_struct.freq = test_freq;
data_all_sub_level_3 = cellfun(@(x) IBS_subs_data(template_struct,x) ,combined_correlations_level_3,'UniformOutput',false);

%%
% n = ft_timelockgrandaverage(cfg,data_all_sub{:});
cfg = [];
cfg.keepindividual = 'yes' ;
[grandavg_level_1] = ft_freqgrandaverage(cfg, data_all_sub_level_1{:});

%%
% n = ft_timelockgrandaverage(cfg,data_all_sub{:});
cfg = [];
cfg.keepindividual = 'yes' ;
[grandavg_level_2] = ft_freqgrandaverage(cfg, data_all_sub_level_2{:});
%%
cfg = [];
cfg.keepindividual = 'yes' ;
[grandavg_level_3] = ft_freqgrandaverage(cfg, data_all_sub_level_3{:});
%%
% specifies with which sensors other sensors can form clusters
cfg_neighb.method    = 'triangulation';%'distance';
%cfg_neighb.neighbourdist    = 2; % boh not sure about what value to use here.
cfg_neighb.layout    = ft_prepare_layout(cluster_cfg);

cluster_cfg.neighbours       = ft_prepare_neighbours(cfg_neighb, grandavg_level_1);



design = zeros(2,(subj_1+subj_2+subj_3));
for i = 1:subj_1
    design(1,i) = i;
end
for i = 1:subj_2
    design(1,subj_1+i) = i;
end

for i = 1:subj_3
    design(1,subj_1+subj_2+i) = i;
end

design(2,1:subj_1)        = 1;%
design(2,subj_1+1:(subj_1+subj_2)) = 2;%
design(2,(subj_1+subj_2)+1:(subj_1+subj_2+subj_3)) = 3;%

cluster_cfg.design   = design;
cluster_cfg.ivar     = 2;

[stat] = ft_freqstatistics(cluster_cfg, grandavg_level_1,grandavg_level_2,grandavg_level_3);



end