function IBS_blink_plot_results(results,Dyad_no,condition_no,delay_rms)
%% Atesh Koul
% 16-02-2021

Dyads = 1:size(results,1);
% Dyad_no = 1;
% condition_no =3;

blinks_EEG_times   =results{Dyads(Dyad_no),condition_no}.blinks_EEG_times  ;
blinks_EEG =results{Dyads(Dyad_no),condition_no}.blinks_EEG  ;
% pos_delay_S2=results_S2{Dyads(Dyad_no),condition_no}.pos_delay_S2 ;
% neg_delay_S2=results_S2{Dyads(Dyad_no),condition_no}.neg_delay_S2  ;
all_timepoints =   results{Dyads(Dyad_no),condition_no}.all_timepoints  ;
if nargin <4
delay_rms =   results{Dyads(Dyad_no),condition_no}.delay_rms  ;
end

deviance_delay_rms = results{Dyads(Dyad_no),condition_no}.deviance_delay_rms;
blinks_start_loc = results{Dyads(Dyad_no),condition_no}.blinks_start_loc;
max_blink_chan =  find(cat(1,blinks_EEG.signalData.numberBlinks) == max(cat(1,blinks_EEG.signalData.numberBlinks)));
blink_data = results{Dyads(Dyad_no),condition_no}.blink_data;
% s_start = results{Dyads(Dyad_no),condition_no}.blink_data;

figure('units','normalized','outerposition',[0 0 1 1])
plot(blinks_EEG_times,blinks_EEG.signalData(max_blink_chan(1)).signal)
%             plot(blinks_EEG_S2_times,blinks_EEG_S2.signalData(min_blink_chan_S2(1)).signal)

hold on;

plot_y_max = max(blinks_EEG.signalData(max_blink_chan(1)).signal)+100;
plot_y_max = 500;
plot(blinks_EEG_times,blink_data*plot_y_max,'g')
plot(all_timepoints+delay_rms,blinks_start_loc*plot_y_max,'r')
title(['delay ' num2str(delay_rms) ' deviance ' num2str(deviance_delay_rms)])
% plot(all_timepoints+neg_delay_S2,s_start_S2*500,'y')
end

