function [dataset_ica_artefact_clean] = IBS_EEG_manual_artefact_removal(dataset_ica_cleaned,Sub_no)

if nargin < 2
    Sub_no = 'S1';
end


switch Sub_no
    
    case 'S1'
        selected_chan_type = {'1-*'};
    case 'S2'
        selected_chan_type = {'2-*'};
end

[ dataset_ica_artefact_clean, visual_artif, interpolated_channels ] = Giac_AK_EEG_CleanSignal( dataset_ica_cleaned, selected_chan_type, [-30 30], ['IBS_' Sub_no '_layout_64.mat'], .23,0);
        

% %% interpolation
% %Dyd 02, 1-IZ
% auto_interp_fname = 'interp_chans_all_sub_corrected_sub_order_corrected_S2.mat';
% % insert here the skipping step of automatic interpolation.
% try
%     [Dyad, block_no,depth] = IBS_get_dyad_cond_from_struct(dataset_filt,5,true);
% catch
%     [Dyad, block_no,depth] = IBS_get_dyad_cond_from_struct(dataset_filt,6,true);
%     
% end
% if ~exist(auto_interp_fname,'file')
%     
%     [ dataset_clean, visual_artif, interpolated_channels ] = Giac_AK_EEG_CleanSignal( dataset_filt, {'1*'}, [-30 30], 'IBS_S1_layout_64.mat', .23);
%     
%     [ dataset_clean, visual_artif, interpolated_channels ] = Giac_AK_EEG_CleanSignal( dataset_clean, {'2*'}, [-30 30], 'IBS_S2_layout_64.mat', .23);
% else
%     load(auto_interp_fname)
%     % get the interplolated chan
%     chans = eval(['interp_ch_' Sub_no '{Dyad,1}{1,block_no}']);
%     if ~isempty(chans)
%         % interpolate
%         dataset_clean = IBS_interpolate_ch(dataset_filt,chans,['IBS_' Sub_no '_layout_64.mat'],.23);
%         depth = depth+1;
%     end
%     
%     
%     if isempty(chans)
%         dataset_clean = dataset_filt;
%     end
%     
%     if remove_segments
%         
% 
%     end
%     
%     
% end
% dataset_clean.depth = depth;

end