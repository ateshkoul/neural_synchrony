function [blink_data_diff_time,blinks_EEG_times,blink_data,blinks_EEG] = IBS_blink_detect_EEG(data,data_times,Dyad_no,varargin_table)
%% Atesh Koul
% 15-02-2021

eeglab_data_S1 = IBS_template_ft_eeglab(data);

eeglab_data_S1.times = data_times;
eeglab_data_S1.pnts = length(data_times);
try
    params = struct();
    params.stdThreshold = varargin_table.stdThreshold;
%     if any(varargin_table.Dyads_var_thresh_1 == Dyad_no)
%         params.stdThreshold = varargin_table.stdThreshold_1;
%     else
%         if any(varargin_table.Dyads_var_thresh_2 == Dyad_no)
%             params.stdThreshold = varargin_table.stdThreshold_2;
%         end
%     end
    % doesn't work
%     switch(Dyad_no)
%         case any(varargin_table.Dyads_var_thresh_1,Dyad_no)
%             params.stdThreshold = varargin_table.stdThreshold_1;
%         case any(varargin_table.Dyads_var_thresh_2,Dyad_no)
%             params.stdThreshold = varargin_table.stdThreshold_2;
%             
%     end
try
    
    params.goodRatioThreshold = varargin_table.goodRatioThreshold; %0.51;
    params.blinkAmpRange = varargin_table.blinkAmpRange; %[1.65 50];
catch
end
eeglab_data_S1.srate = 1024;
    [~, ~, blinks_EEG, ~, ~, ~, ~] = pop_blinker(eeglab_data_S1,params); %struct()
    %     sel_blink_chan_S1 = find(cat(1,blinks_EEG.signalData.numberBlinks) == max(cat(1,blinks_EEG.signalData.numberBlinks)));
    %     sel_blink_chan_S1 = find(cat(1,blinks_EEG_S1.signalData.numberBlinks) == min(cat(1,blinks_EEG_S1.signalData.numberBlinks)));
    sel_blink_chan_S1 = find(cat(1,blinks_EEG.signalData.goodRatio) == max(cat(1,blinks_EEG.signalData.goodRatio)));
    
    blinks_EEG_times = data_times;
    blink_data = zeros(1,length(blinks_EEG_times));
    blink_data(blinks_EEG.signalData(sel_blink_chan_S1(1)).blinkPositions(1,:)) = 1;
    %             blink_data_S1(blinks_EEG_S1.signalData(min_blink_chan_S1(1)).blinkPositions(1,:)) = 1;
    blink_data_diff_time = blinks_EEG_times(find(blink_data));
    
    
    close all
catch
    blinks_EEG = nan;
    blink_data = nan;
    blink_data_diff_time = nan;
    blinks_EEG_times = nan;
    
end
end