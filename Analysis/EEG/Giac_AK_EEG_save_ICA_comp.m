function [ data_onlyEEG, Cmp_to_remove_all ] = Giac_AK_EEG_save_ICA_comp( data, cmp_nr, range, layout,eeg_channels,non_eeg_channels )
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
% [Dyad, block_no,~,datafile] = IBS_get_dyad_cond_from_struct(data,data.depth);
% [~,plot_name,~] = fileparts(datafile);
% 
% % processed_dir = IBS_get_rep_struct_field_from_depth(data.cfg,'previous',data.depth,'processed_dir');
% processed_dir = 'D:\\Atesh\\IBS\\';
%%
Cmp_to_remove_all   = [];
loop                = 0;

% remove non-cortical data (as indixed by 'channels' above) in order to let 'ft_rejectcomponent' work properly (otherwise you get error messages) 
cfg                 = [];
cfg.channel         = eeg_channels; % 'EEG'; only EEG channels are considered (non EEG should not enter into ICA)
data_onlyEEG        = ft_selectdata(cfg, data);
tmp_data            = data_onlyEEG; % this is the data you can change to evaluate the effect of the ICA

% isolate non-cortical data (useful for display)
% non_EEG_ch  = find(ismember(data.label,data_onlyEEG.label)==0);
non_EEG_ch  = non_eeg_channels;

cfg         = [];
cfg.channel = non_EEG_ch; %data.label(non_EEG_ch);
data_noEEG  = ft_selectdata(cfg, data); 
% save([processed_dir 'ICA\\' layout(5:6) '_' sprintf('Dyd_%0.2d_data_noEEG_eye_neck_artefact_clean_bp_03_95_120s.mat',Dyad)],'data_noEEG')

clear data
%% ICA - Run ICA, 
cfg                 = []; 
cfg.method          = 'runica';%'pca';
cfg.numcomponent    = cmp_nr;        
cfg.channel         = eeg_channels; %'EEG';
% the random seem makes the analysis give the same result over and over
% again
cfg.randomseed      = 42;
comp                = ft_componentanalysis(cfg, data_onlyEEG);


% load('correlation_template_struct.mat');
% comp_tf_bc = IBS_tf(comp,unique(comp.trialinfo));

% save([processed_dir 'ICA\\' layout(5:6) '_' sprintf('Dyd_%0.2d_comp_tf_bc_eye_neck_artefact_clean_bp_03_95_120s.mat',Dyad)],'comp_tf_bc')

data_onlyEEG.comp = comp;
close all
% save([processed_dir 'Data\\' layout(5:6) '_' sprintf('Dyd_%0.2d_ICA_blocks_only_neck_artefact_clean_bp_03_95_120s.mat.mat',Dyad)],'data_onlyEEG','-v7.3')


end % function

