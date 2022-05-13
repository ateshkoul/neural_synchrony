function [data_cond] = IBS_select_cond_from_cell_struct(IBS_ft_cell,trial_nos,trial_no)



switch(trial_no)
    case 1
        cfg_event = [];
        cfg_event.trials = ismember(IBS_ft_cell{1,1}.trialinfo,trial_nos{trial_no});
        data_cond = ft_redefinetrial(cfg_event,IBS_ft_cell{1,1});
        %                 data_cond_S2 = ft_redefinetrial(cfg_event,crop_data_S2_fft_nomalized{1,1});
        
    case {2,3,4,5,6}
        cfg_event = [];
        cfg_event.trials = ismember(IBS_ft_cell{1,2}.trialinfo,trial_nos{trial_no});
        data_cond = ft_redefinetrial(cfg_event,IBS_ft_cell{1,2});
        %                 data_cond_S2 = ft_redefinetrial(cfg_event,crop_data_S2_fft_nomalized{1,2});
    case 7
        cfg_event = [];
        cfg_event.trials = ismember(IBS_ft_cell{1,3}.trialinfo,trial_nos{trial_no});
        data_cond = ft_redefinetrial(cfg_event,IBS_ft_cell{1,3});
        %                 data_cond_S2 = ft_redefinetrial(cfg_event,crop_data_S2_fft_nomalized{1,3});
        
end


end