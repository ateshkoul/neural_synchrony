function [] = plot_ICA_add_electrodes(comp_sttruct,extra_electrodes_struct,layout)


for trial = 1:size(comp_sttruct.trial,2)
    comp_sttruct.trial{:,trial} = comp_sttruct.trial{:,trial}/50;
end
cfg=[];
comp_electrodes = ft_appenddata(cfg,comp_sttruct,extra_electrodes_struct);
[ ~, ~ ] = Giac_EEGplotNanTrials( comp_electrodes, {'all'}, [], layout,  'NoReject' );

end