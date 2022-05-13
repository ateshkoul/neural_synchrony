function IBS_plot_tf(data_tf,layout_file,channels,t_of_int)
if nargin <4
t_of_int = [0 120];
end
f_of_int = [1 95];

if nargin <2
    layout_file = 'IBS_S1_layout_64.mat'; 
    channels = 'all';

end

if nargin <3
   channels = 'all';
end




cfg                 = [];
cfg.parameter       = 'powspctrm';
cfg.xlim            = t_of_int;
cfg.ylim            = f_of_int;
cfg.zlim            = [-0.8 0.8];

%cfg.showlabels       = 'yes';
%cfg.fontsize         = 4;
cfg.showoutline     = 'yes';
cfg.colorbar        = 'yes';
cfg.renderer        = 'painters';

cfg.layout                      = layout_file;
ElecLayout                      = ft_prepare_layout(cfg);
cfg.channel                     = channels;
cfg.interactive                 = 'yes';
% figure; ft_multiplotTFR(cfg, data_tf)

figure('units','normalized','outerposition',[0 0 1 1]); ft_singleplotTFR(cfg, data_tf)
% figure; ft_multiplotER(cfg, data_tf)
% figure; ft_topoplotER(cfg, data_tf)

end