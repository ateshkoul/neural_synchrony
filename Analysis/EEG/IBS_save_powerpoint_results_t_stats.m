function IBS_save_powerpoint_results_t_stats(analysis,file_precursur)

if nargin <2
    
    file_precursur = '';
end


%% power point save
presentation_save_dir = 'Y:\\Inter-brain synchrony\\Results\\EEG\\IBS_EEG_presentations\\';
import mlreportgen.ppt.*

ppt = Presentation([presentation_save_dir 'results_' analysis '_t_stats.pptx']);
analysis_type = {'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
select_string = {'cluster_plot_images'}; % this will be same for within and powercorr

switch(analysis)
    
    
    case 'Within_analysis_fig'
        cor_fun = @IBS_load_within_brain_analysis_data;

        select_string = {['cluster_plot_images_' func2str(cor_fun) '_freqwise']};
    case 'Power_correlation_analysis_fig'
        
        select_string = {'cluster_plot_images_correlation_freqwise'};

end


IBS_save_powerpoint_t_stats(analysis_type,ppt,select_string,analysis);
close(ppt);


end