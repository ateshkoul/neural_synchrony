function [data_out] = IBS_interpolate_ch(data,interpolated_channels_all,layout,neigh_dist,trials)

if nargin <5
    trials = 'all';
end
cfg                 = [];
cfg.layout          = layout;
cfg.method          = 'distance'; % for prepare_neigh
cfg.neighbourdist   = neigh_dist;         % results in avg 5 channels
cfg.neighbours      = ft_prepare_neighbours(cfg, data);
cfg.badchannel      = interpolated_channels_all; %data.label(ChanInterpol);
cfg.method          = 'nearest';
cfg.trials          = trials;
data_out            = ft_channelrepair(cfg, data);

end