function [dataset_clean] = IBS_EEG_Interpolate(dataset_filt,remove_segments)

if nargin < 2
    remove_segments = 0;
end
%% interpolation
%Dyd 02, 1-IZ
% auto_interp_fname = 'interp_chans_all_sub_corrected_sub_order_corrected_S2.mat';
auto_interp_fname = 'interp_chans_all_sub_corrected_sub_order_corrected_S2_S12_S19.mat';
% insert here the skipping step of automatic interpolation.
[Dyad, block_no,depth] = IBS_get_dyad_cond_from_struct(dataset_filt);

if ~exist(auto_interp_fname,'file')
    
    [ dataset_clean, visual_artif, interpolated_channels ] = Giac_AK_EEG_CleanSignal( dataset_filt, {'1*'}, [-30 30], 'IBS_S1_layout_64.mat', .23);
    
    [ dataset_clean, visual_artif, interpolateinterp_ch_S1d_channels ] = Giac_AK_EEG_CleanSignal( dataset_clean, {'2*'}, [-30 30], 'IBS_S2_layout_64.mat', .23);
else
    load(auto_interp_fname)
    % get the interplolated chan
    S1_chans = interp_ch_S1{Dyad,1}{1,block_no};
    S2_chans = interp_ch_S2{Dyad,1}{1,block_no};
    if ~isempty(S1_chans)
        % interpolate
        dataset_clean = IBS_interpolate_ch(dataset_filt,S1_chans,'IBS_S1_layout_64.mat',.23);
        depth = depth+1;
    end
    
    if isempty(S1_chans) && ~isempty(S2_chans)
        dataset_clean = IBS_interpolate_ch(dataset_filt,S2_chans,'IBS_S2_layout_64.mat',.23);
        depth = depth+1;
        
    end
    
    
    % very critical to have dataset_clean here otherwise it just doesn't
    % work for Sub 1
    if ~isempty(S1_chans) && ~isempty(S2_chans)
        % interpolate
        dataset_clean = IBS_interpolate_ch(dataset_clean,S2_chans,'IBS_S2_layout_64.mat',.23);
        depth = depth+1;
        
    end
    
    
    if isempty(S1_chans) && isempty(S2_chans)
        dataset_clean = dataset_filt;
    end
    
    if remove_segments
        
        cfg_S1.channel = {'1-*'};
        cfg_S2.channel = {'2-*'};
        data_S1  = ft_selectdata(cfg_S1, dataset_clean); 
        data_S2  = ft_selectdata(cfg_S2, dataset_clean); 
        [ dataset_clean_S1, visual_artif, interpolated_channels ] = Giac_AK_EEG_CleanSignal( data_S1, {'1*'}, [-30 30], 'IBS_S1_layout_64.mat', .23,0);
        
        [ dataset_clean_S2, visual_artif, interpolated_channels ] = Giac_AK_EEG_CleanSignal( data_S2, {'2*'}, [-30 30], 'IBS_S2_layout_64.mat', .23,0);
    end
    
    
end