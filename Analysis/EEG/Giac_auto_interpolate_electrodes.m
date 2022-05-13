function [data] = Giac_auto_interpolate_electrodes(data,layout)
%GIAC_AUTO_INTERPOLATE_ELECTRODES function to automatically interpolate electrodes
%
% SYNOPSIS: Giac_auto_interpolate_electrodes
%
% INPUT 
%
% OUTPUT 
%
% REMARKS
%
% created with MATLAB ver.: 9.8.0.1359463 (R2020a) Update 1 on Microsoft Windows 10 Pro Version 10.0 (Build 19042)
%
% created by: Giacomo
% DATE: 22-Mar-2021
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin <2
layout = 'Layout_Monkey_EEG';
end
[ out_ch_noisy ]    = Giac_EEG_CatchNoisyElectrodes( data, {'all'}, 2, 'recursive' );

load(layout); % this normally load a 'lay' structure


cfg.layout          = lay;
layout              = ft_prepare_layout(cfg, data);

cfg                 = [];
cfg.layout          = layout;
cfg.method          = 'distance'; % for prepare_neigh
cfg.neighbourdist   = .2;         % results in avg 5 channels
cfg.neighbours      = ft_prepare_neighbours(cfg, data);
cfg.badchannel      = out_ch_noisy'; %data.label(ChanInterpol);
cfg.method          = 'nearest';     
data    = ft_channelrepair(cfg, data);

end