function data_struct = IBS_re_reference_data(data_struct)
cfg.reref         = 'yes';
cfg.refchannel    = 'all'; 
cfg.refmethod     = 'avg';
data_struct = ft_preprocessing(cfg,data_struct);
end