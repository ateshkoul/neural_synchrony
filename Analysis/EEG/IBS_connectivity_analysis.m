function conn_stat = IBS_connectivity_analysis(freq_ft_struct,measure)
if nargin<2
    
   measure = 'coh'; 
end
cfg             = [];
cfg.method      = measure;
channelcmb      = load('IBS_iso_channelcmb_coherence.mat','iso_channelcmb');
cfg.channelcmb  = channelcmb.iso_channelcmb;

conn_stat       = ft_connectivityanalysis(cfg, freq_ft_struct);


end