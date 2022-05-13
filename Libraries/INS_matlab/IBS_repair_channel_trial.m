function [dataset_interpolated,interpolated_channels_all,interpolated_trial_all] = IBS_repair_channel_trial(dataset,sub)


layout_file = sprintf('IBS_S%d_layout_64.mat',sub);

% PREPARE LAYOUT
load(layout_file); % this normally load a 'lay' structure



IBS_plot_data(dataset,sub,{'1*'})
chan_interpolate = 1;
interpolated_channels_all = [];
interpolated_trial_all = [];
while chan_interpolate
    nTrials = numel(dataset.trial);
    ChanInterpol = listdlg('PromptString','Choose bad channels:','SelectionMode','multiple','ListString',lay.label); % select which components to remove
    trialNo = inputdlg(['Select the trial no from 1 to ' num2str(nTrials)],'interpolated trial',1,{'all'});
    
    
    interpolated_channels_all  = [interpolated_channels_all; {lay.label(ChanInterpol)}];
    interpolated_trial_all     = [interpolated_trial_all; {trialNo}];
    
    answer = questdlg('What do you want to do?', ...
        'Options', ...
        'Move on','Interpolate','Interpolate');
    if strcmp(answer,'Move on')
        chan_interpolate = 0;
        close all
        
    end
end

for loop = 1:numel(interpolated_trial_all)
    
    dataset_interpolated = IBS_interpolate_ch(dataset,interpolated_trial_all{loop},layout_file,.23,interpolated_trial_all{loop});
    
    
end


end