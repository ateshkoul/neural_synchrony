%% function
function [data_out] = interpolate_channel_IBS(data,interpolated_channels_all,layout,neigh_dist)

cfg                 = [];
cfg.layout          = layout;
cfg.method          = 'distance'; % for prepare_neigh
cfg.neighbourdist   = neigh_dist;         % results in avg 5 channels
cfg.neighbours      = ft_prepare_neighbours(cfg, data);
cfg.badchannel      = interpolated_channels_all; %data.label(ChanInterpol);
cfg.method          = 'nearest';
data_out            = ft_channelrepair(cfg, data);

end