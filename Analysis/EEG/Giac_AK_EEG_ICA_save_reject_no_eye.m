function [ data_ica, Cmp_to_remove_all ] = Giac_AK_EEG_ICA_save_reject_no_eye( data, cmp_nr, range, layout,eeg_channels,modality)
%%
% This script runs ICA on EEG 'data' using the FT's functions.
% A number of ICs (='cmp_nr') is computed only for EEG channels (other
% channels in the dataset are ignored - although plotted).
% 'range' and 'layout' are input for the plotting functions.
% The function works recursively - it allows you to gradually include more
% components (looking at how the data changes after they are removed).
% Note that the components eliminated on a previous step will be
% excluded by default in all following steps (although the function performs only 1 ICA and 1 elimination of ICs).
% Also, note that the output file includes only the EEG channels.
%
%% Giacomo Novembre
if nargin <6 && ~isfield(data,'comp')
    disp('assuming that ICA has to be calculated')
    modality = 'save';
    % else
    %     modality = 'reject';
end


if strcmp(modality,'save') && isfield(data,'comp')
    
    input('data already contains estimated ICA components. Sure to proceed?');
end
close all


%% AK
% [Dyad, block_no,~,datafile] = IBS_get_dyad_cond_from_struct(data,data.depth);
% [~,plot_name,~] = fileparts(datafile);
%
% processed_dir = IBS_get_rep_struct_field_from_depth(data.cfg,'previous',data.depth,'processed_dir');
%%
Cmp_to_remove_all   = [];
loop                = 0;

% remove non-cortical data (as indixed by 'channels' above) in order to let 'ft_rejectcomponent' work properly (otherwise you get error messages)
cfg                 = [];
cfg.channel         = eeg_channels; % 'EEG'; only EEG channels are considered (non EEG should not enter into ICA)
data_onlyEEG        = ft_selectdata(cfg, data);

% isolate non-cortical data (useful for display)
% non_EEG_ch  = find(ismember(data.label,data_onlyEEG.label)==0);
% non_EEG_ch  = non_eeg_channels;
% 
% cfg         = [];
% cfg.channel = non_EEG_ch; %data.label(non_EEG_ch);
% data_noEEG  = ft_selectdata(cfg, data);
clear data
%% ICA - Run ICA,

if strcmp(modality,'save')
    cfg                 = [];
    cfg.method          = 'runica';
    cfg.numcomponent    = cmp_nr;
    cfg.channel         = eeg_channels; %'EEG';
    % the random seem makes the analysis give the same result over and over
    % again
    cfg.randomseed      = 42;
    comp                = ft_componentanalysis(cfg, data_onlyEEG);
else
    comp = data_onlyEEG.comp;
    
    cfg_latency.latency = [-1 130];
    comp = ft_selectdata(cfg_latency,comp);
    
%     plot_ICA_add_electrodes(comp,data_noEEG,layout);
    %% 2 Plot Components topgraphies
    figure;
    cfg                 = [];
    cfg.component       = [1:cmp_nr];       % specify the component(s) that should be plotted
    cfg.layout          = layout;
    cfg.comment         = 'no';
    ft_topoplotIC(cfg, comp);
    
    % saveas(gca,[processed_dir 'ICA\\' plot_name '_ICA_topo.tif'])
end
tmp_data            = data_onlyEEG; % this is the data you can change to evaluate the effect of the ICA

%% 1 Plot Components


% [ ~, ~ ] = Giac_EEGplotNanTrials( comp, {'all'}, [], layout,  'NoReject' );

%

% saveas(gca,[processed_dir 'ICA\\' plot_name '_ICA_comp.tif'])



%% 3 Plot time-locked components (to make sure you identify VW-related components)
% cfg                 = [];
% cfg.latency         = [-.2 +60]; %[-.2 +.4];
% comp_tl             = ft_timelockanalysis(cfg, comp);
% [ ~, ~ ] = Giac_EEGplotNanTrials( comp_tl, {'all'}, [], layout,  'NoReject' );
if strcmp(modality,'reject')
    while loop < 1
        
        %% 4 Plot Data
%         feedback_data = ft_appenddata([],tmp_data,data_noEEG);
%         [ ~, ~ ]      = Giac_EEGplotNanTrials( feedback_data, {'all'}, range, layout, 'NoReject' );
        
        %% choose the components to remove
        display(['GIAC: currently you have removed components: ' num2str(Cmp_to_remove_all) ]);
        uiwait(msgbox('Press OK when you decided that some (new) components have to be removed ...', 'Rejection?'));
        Question = listdlg('PromptString','Components to remove?','SelectionMode','multiple','ListString',{'yes','no'});
%         Question = 1;
        %% Remove components if any has been selected
        if Question == 1 % if you want to remove components ...
            
            clear tmp_data
            
            Cmp_to_remove       = listdlg('PromptString','Choose bad components:','SelectionMode','multiple','ListString',comp.label);
%             Cmp_to_remove_all = [1 3];
            Cmp_to_remove_all   = [Cmp_to_remove_all Cmp_to_remove];
            Cmp_to_remove_all   = sort(unique(Cmp_to_remove_all));
            
            % remove selected components
            cfg                 = [];
            cfg.component       = Cmp_to_remove_all;
            [tmp_data]          = ft_rejectcomponent(cfg, comp, data_onlyEEG);
            
            % Plot Cleaned Data
%             feedback_data = ft_appenddata([],tmp_data,data_noEEG);
%             [ ~, ~ ]      = Giac_EEGplotNanTrials( feedback_data, {'all'}, range, layout, 'NoReject' );
            
            display(['GIAC: currently you have removed components: ' num2str(Cmp_to_remove_all) ]);
            uiwait(msgbox('Check your data ...', 'Rejection?'));
            Question2 = listdlg('PromptString','Select additional ICs?','SelectionMode','multiple','ListString',{'yes','no'});
%             Question2 = 2;
            if Question2 == 1 % yes, other components to remove..
%                 close(4);
%                 close(5);
            elseif Question2 == 2 % no, enough components removed ...
                loop = 1;
            end
            
        else % if not componenets have been selected, then store an empty array or overwrite an existing one
            loop = 1;
        end
        
    end % while
end

if strcmp(modality,'save')
%     cfg_append = [];
%     data_ica = ft_appenddata(cfg_append,tmp_data,data_noEEG);
    data_ica = tmp_data;
    % add ICA components for later processing.
    % don't keep the components for reducing file size
    data_ica.comp = comp;
elseif strcmp(modality,'reject')
    
    data_ica = tmp_data;
end
close all

end % function

