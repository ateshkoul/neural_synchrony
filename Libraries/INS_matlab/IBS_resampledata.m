function dataset = IBS_resampledata(dataset,resamplefs)

if nargin <2
   resamplefs = 1024; 
end
cfg.resamplefs = resamplefs;
dataset = ft_resampledata(cfg, dataset);

end