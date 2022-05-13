function [ data_onlyEEG, Cmp_to_remove_all ] = IBS_analyze_computed_ICA( data_onlyEEG, cmp_nr, range, layout,eeg_channels,non_eeg_channels )
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

close all


%% AK
% [Dyad, block_no,~,datafile] = IBS_get_dyad_cond_from_struct(data_onlyEEG,5);
[Dyad, block_no,~,datafile] = IBS_get_dyad_cond_from_struct(data_onlyEEG,data_onlyEEG.depth+1);

[~,plot_name,~] = fileparts(datafile);

% processed_dir = IBS_get_rep_struct_field_from_depth(data_onlyEEG.cfg,'previous',5,'processed_dir');
% blocks = {'baseline_1','blocks','baseline_2'};
% data_raw = IBS_preprocess_raw_data(Dyad,blocks{block_no});

processed_dir = 'D:\\Experiments\\IBS\\Processed\\EEG\\ICA\\';

comp                = data_onlyEEG.comp;
[ ~, ~ ] = Giac_EEGplotNanTrials( comp, {'all'}, [], layout,  'NoReject' );
    uiwait(msgbox('Press OK when you decided that some (new) components have to be removed ...', 'Rejection?'));

Cmp_to_correlate      = listdlg('PromptString','Choose bad components:','SelectionMode','multiple','ListString',comp.label);

%% load the time-freq of the ICA components

% load([processed_dir layout(5:6) '_' sprintf('Dyd_%0.2d_comp_tf_bc_eye_neck_artefact_clean_bp_03_95_120s.mat',Dyad)])
comp_tf_bc = IBS_tf_ICA(comp,unique(comp.trialinfo));
avg_tf_ICA_comp = squeeze(mean(comp_tf_bc.powspctrm(:,:,30:95,:),3));
% avg_tf_ICA_comp = squeeze(mean(comp_tf_bc.powspctrm(:,:,55:95,:),3));

avg_tf_comp = [];
for trial = 1:15
    
    trial_dat = movingmean(squeeze(avg_tf_ICA_comp(trial,:,1:end-2)),10,2,1);
    avg_tf_comp = [avg_tf_comp trial_dat];
    
end

% 
% end_points = find(isnan(avg_tf_comp(1,1:end)));
% avg_tf_comp(:,end_points)=[];



n_comp = size(avg_tf_comp,1);
Cmp_to_remove_auto = [];

mean(avg_tf_comp(Cmp_to_correlate,:))

rep_comp_array = repmat(mean(avg_tf_comp(Cmp_to_correlate,:)),[n_comp 1]);
% arrayfun(@(x) IBS_ret_corr_p_value(rep_comp_array(x,1:end-2)',avg_tf_ICA_comp(x,1:end-2)'),1:n_comp,'Uni', 1)
correlations_comp = arrayfun(@(x) corr(rep_comp_array(x,1:end-2)',avg_tf_comp(x,1:end-2)'),1:n_comp);
correlations_comp = arrayfun(@(x) IBS_ret_corr_p_value(rep_comp_array(x,1:end-2)',avg_tf_comp(x,1:end-2)'),1:n_comp);

Cmp_to_remove_auto = [Cmp_to_remove_auto find(correlations_comp>0.8)];




%%
for comp_correlate = 1:length(Cmp_to_correlate)
    
rep_comp_array = repmat(avg_tf_comp(Cmp_to_correlate(comp_correlate),:),[n_comp 1]);
% arrayfun(@(x) IBS_ret_corr_p_value(rep_comp_array(x,1:end-2)',avg_tf_ICA_comp(x,1:end-2)'),1:n_comp,'Uni', 1)
correlations_comp = arrayfun(@(x) corr(rep_comp_array(x,1:end-2)',avg_tf_comp(x,1:end-2)'),1:n_comp);

Cmp_to_remove_auto = [Cmp_to_remove_auto find(correlations_comp>0.7)];
end


Cmp_to_remove_auto = unique(Cmp_to_remove_auto);
%% 2 Plot Components topgraphies
figure;
cfg                 = [];
cfg.component       = [1:n_comp];       % specify the component(s) that should be plotted
cfg.layout          = layout;
cfg.comment         = 'no';
ft_topoplotIC(cfg, comp);

% saveas(gca,[processed_dir 'ICA\\' plot_name '_ICA_topo.tif'])


%% automatically remove comp

% Cmp_to_remove_all = find(correlations_comp>0.8);
% cfg                 = [];
% cfg.component       = Cmp_to_remove_all;
% [data_onlyEEG]          = ft_rejectcomponent(cfg, comp, data_onlyEEG);


%% old script
%%
Cmp_to_remove_all   = [];
loop                = 0;

% % remove non-cortical data (as indixed by 'channels' above) in order to let 'ft_rejectcomponent' work properly (otherwise you get error messages)
% cfg                 = [];
% cfg.channel         = eeg_channels; % 'EEG'; only EEG channels are considered (non EEG should not enter into ICA)
% data_onlyEEG        = ft_selectdata(cfg, data_raw);

% isolate non-cortical data (useful for display)
% non_EEG_ch  = find(ismember(data.label,data_onlyEEG.label)==0);
% non_EEG_ch  = non_eeg_channels;

% cfg         = [];
% cfg.channel = non_EEG_ch; %data.label(non_EEG_ch);
% data_noEEG  = ft_selectdata(cfg, data_raw);

% load([processed_dir layout(5:6) '_' sprintf('Dyd_%0.2d_data_noEEG_eye_neck_artefact_clean_bp_03_95_120s.mat',Dyad)])

% clear data_raw
% %% ICA - Run ICA,
% cfg                 = [];
% cfg.method          = 'runica';
% cfg.numcomponent    = n_comp;
% cfg.channel         = eeg_channels; %'EEG';
% % the random seem makes the analysis give the same result over and over
% % again
% cfg.randomseed      = 42;
% % comp                = ft_componentanalysis(cfg, data_onlyEEG);
% comp                = data_onlyEEG.comp;

tmp_data            = data_onlyEEG; % this is the data you can change to evaluate the effect of the ICA

%% 1 Plot Components
% [ ~, ~ ] = Giac_EEGplotNanTrials( comp, {'all'}, [], layout,  'NoReject' );

% plot_ICA_add_electrodes(comp,data_noEEG,layout);

% saveas(gca,[processed_dir 'ICA\\' plot_name '_ICA_comp.tif'])



%% 3 Plot time-locked components (to make sure you identify VW-related components)
% cfg                 = [];
% cfg.latency         = [-.2 +60]; %[-.2 +.4];
% comp_tl             = ft_timelockanalysis(cfg, comp);
% [ ~, ~ ] = Giac_EEGplotNanTrials( comp_tl, {'all'}, [], layout,  'NoReject' );

while loop < 1
    
    %% 4 Plot Data
    [ ~, ~ ]      = Giac_EEGplotNanTrials( tmp_data, {'all'}, range, layout, 'NoReject' );
    
    %% choose the components to remove
    display(['GIAC: currently you have removed components: ' num2str(Cmp_to_remove_all) ]);
    uiwait(msgbox('Press OK when you decided that some (new) components have to be removed ...', 'Rejection?'));
    Question = listdlg('PromptString','Components to remove?','SelectionMode','multiple','ListString',{'yes','no'});
    
    %% Remove components if any has been selected
    if Question == 1 % if you want to remove components ...
        
        clear tmp_data
        
        Cmp_to_remove       = listdlg('PromptString','Choose bad components (additional to auto):','SelectionMode','multiple','ListString',comp.label);
%         Cmp_to_remove_all   = [Cmp_to_remove_all Cmp_to_remove];
%         Cmp_to_remove_all   = sort(unique(Cmp_to_remove_all));
        
        
        Cmp_to_remove_all = [Cmp_to_remove_auto Cmp_to_remove];
        
        Cmp_to_remove_all   = sort(unique(Cmp_to_remove_all));
        % remove selected components
        cfg                 = [];
        cfg.component       = Cmp_to_remove_all;
        [tmp_data]          = ft_rejectcomponent(cfg, comp, data_onlyEEG);
        
        % Plot Cleaned Data
        [ ~, ~ ]      = Giac_EEGplotNanTrials( tmp_data, {'all'}, range, layout, 'NoReject' );
        
        display(['GIAC: currently you have removed components: ' num2str(Cmp_to_remove_all) ]);
        uiwait(msgbox('Check your data ...', 'Rejection?'));
        Question2 = listdlg('PromptString','Select additional ICs?','SelectionMode','multiple','ListString',{'yes','no'});
        
        if Question2 == 1 % yes, other components to remove..
            close(4);
            close(5);
        elseif Question2 == 2 % no, enough components removed ...
            loop = 1;
        end
        
    else % if not componenets have been selected, then store an empty array or overwrite an existing one
        loop = 1;
    end
    
end % while

data_onlyEEG = tmp_data;
% add ICA components for later processing.
% data_ica.comp = comp;
close all

end % function

