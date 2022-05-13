function [ data_out, eliminated_trials_all, interpolated_channels_all ] = Giac_AK_EEG_CleanSignal( data, channels, range, layout_file, neigh_dist,eliminate_all_trial)
%
%
%% Giacomo Novembre
if nargin < 6
    eliminate_all_trial = 1; % do eliminate the entire trial by default
end
loop                        = 0;
tmp_data                    = data;
interpolated_channels_all   = [];
eliminated_trials_all       = [];

% PREPARE LAYOUT
load(layout_file); % this normally load a 'lay' structure
cfg.layout          = lay;
layout              = ft_prepare_layout(cfg, data);

%% Provide tips about suspicious electrodes... based on Automatic identification of NOISY electrodes
[ out_ch_noisy ]    = Giac_EEG_CatchNoisyElectrodes( data, channels, 3, 'recursive' ); % find noisy electrodes
display(['GIAC: suspicious electrodes: ' out_ch_noisy]);

while loop < 1
    
    % VISUALIZE DATA
    cfgint                 = [];
    cfgint.layout          = layout;
    cfgint.ylim            = range;
    cfgint.continuous      = 'no';
    cfgint.selectmode      = 'markartifact';
    cfgint.channel         = channels;
    cfgint.viewmode        = 'vertical';
    cfgint.axisfontsize    = 10;
    cfgint.plotlabels      = 'yes';
    cfgint.artifact        = [];
    
    display(['GIAC: trials eliminated: ' num2str(eliminated_trials_all)]);
    display(['GIAC: channels interpolated: ' interpolated_channels_all']);
    
    cfgVISUAL              = ft_databrowser(cfgint,tmp_data);
    
    %% Question
    answer = questdlg('What do youclc want to do?', ...
        'Options', ...
        'Move on','Reject Trials & Watch Data Again','Interpolate','Interpolate');
    
    switch answer
        case 'Reject Trials & Watch Data Again'
            cfgVISUAL.artfctdef.reject     = 'nan'; % whole trial is gone for 'complete' or replaced with 'nan's!
            cfgVISUAL.artfctdef.feedback   = 'no';
            tmp_data               = ft_rejectartifact(cfgVISUAL, tmp_data);  % remove trials identified and stored as artifact
            if eliminate_all_trial
                
                eliminated_trials_tmp          = Giac_findNanTrials( tmp_data, 'OnlyAll' );  % find out trial (nr) that were removed
                eliminated_trials_all          = [eliminated_trials_all eliminated_trials_tmp]; % merge to previous removals
                eliminated_trials_all          = unique(eliminated_trials_all);
                
            end
        case 'Interpolate'
            display(['GIAC: suspicious electrodes: ' out_ch_noisy]);
            display(['GIAC: already interpolating  : ' interpolated_channels_all' ]);
            % Giac toolbox
            %         ChanInterpol = listdlg('PromptString','Choose bad channels:','SelectionMode','multiple','ListString',data.label); % select which components to remove
            % Atesh
            ChanInterpol = listdlg('PromptString','Choose bad channels:','SelectionMode','multiple','ListString',lay.label); % select which components to remove
            interpolated_channels_all  = [interpolated_channels_all; lay.label(ChanInterpol)]; % merge with previous components to be removed
        case 'Move on'
            loop = 1;
    end % switch
%     clear tmp_data
%     
%     if ~eliminate_all_trial
%         tmp_data = data_highlighted;
%     end
    if eliminate_all_trial % if all trials have to be removed
        
        % Do trials removal (all selected so far)
        if isempty(eliminated_trials_all)==0 % if trials have been eliminated
            tmp_data  = Giac_makeNanTrials( data, eliminated_trials_all );
            
        else
            tmp_data  = data;
        end
        
        
    end
    % Do the interpolation (all channels selected so far)
    if isempty(interpolated_channels_all)==0
        cfg                 = [];
        cfg.layout          = layout;
        cfg.method          = 'distance'; % for prepare_neigh
        cfg.neighbourdist   = neigh_dist;         % results in avg 5 channels
        cfg.neighbours      = ft_prepare_neighbours(cfg, tmp_data);
        cfg.badchannel      = interpolated_channels_all; %data.label(ChanInterpol);
        cfg.method          = 'nearest';
        tmp_data            = ft_channelrepair(cfg, tmp_data);
    end
end % loop

data_out = tmp_data;

end % function
