function IBS_save_powerpoint_results_anova(analysis,file_precursur)

if nargin <2
    
    file_precursur = '';
end


%% power point save
presentation_save_dir = 'Y:\\Inter-brain synchrony\\Results\\EEG\\IBS_EEG_presentations\\';
import mlreportgen.ppt.*

ppt = Presentation([presentation_save_dir 'results_' analysis '_anova.pptx']);
analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};

switch(analysis)
    
    
    case 'Within_analysis_fig'
%         cor_fun = @IBS_load_within_brain_analysis_data;
        cor_fun = @IBS_tf_within_pwr_decomp_trialwise;

        select_string = {['cluster_plot_images_' func2str(cor_fun) '_freqwise_anova']};
    case 'Power_correlation_analysis_fig'
        cor_fun = @IBS_tf_correlations;


        select_string = {'cluster_plot_images_' func2str(cor_fun) 'detrend_freqwise_anova'};

end



IBS_save_powerpoint_stats(analysis_type,ppt,select_string,analysis);
close(ppt);


end