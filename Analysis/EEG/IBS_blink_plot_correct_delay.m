function IBS_blink_plot_correct_delay(Dyad_no,condition_no,sub_no)


load('correct_delays_EEG_eye_tracker.mat','S1_delay_min_dev','S2_delay_min_dev')
delay_S1 = S1_delay_min_dev(Dyad_no,condition_no);
delay_S2 = S2_delay_min_dev(Dyad_no,condition_no);
thresh = [1 1.5 2 2.5 3 3.5 4];
thresh_no = 1;
[results_S1_F,results_S2_F] = IBS_blink_load_delays(Dyad_no,condition_no,thresh,thresh_no);

if sub_no == 1
    IBS_blink_plot_results(results_S1_F,Dyad_no,condition_no,delay_S1)
else
    if sub_no==2
        IBS_blink_plot_results(results_S2_F,Dyad_no,condition_no,delay_S2)
    end
end
end