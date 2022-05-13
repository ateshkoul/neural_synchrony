function [grandavg] = IBS_freqgrandaverage(cond_data_cell)


% cond_data_cell = s(:,2);
load('correlation_template_struct.mat');

data_all_sub = cellfun(@(x) IBS_subs_data(template_struct,x) ,cond_data_cell,'UniformOutput',false);


% n = ft_timelockgrandaverage(cfg,data_all_sub{:});
cfg = [];
cfg.keepindividual = 'yes' ;
[grandavg] = ft_freqgrandaverage(cfg, data_all_sub{:});
end