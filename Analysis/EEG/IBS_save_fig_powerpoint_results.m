function IBS_save_fig_powerpoint_results(figure_no,analysis,file_precursur,analysis_sub_type)
if nargin <2
    
    file_precursur = '';
end


if nargin <3
    
    analysis_sub_type = '';
end
presentation_save_dir = 'Y:\\Inter-brain synchrony\\Results\\EEG\\IBS_EEG_presentations\\';
import mlreportgen.ppt.*
ppt = Presentation([presentation_save_dir 'results_' figure_no  '.pptx']);
analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
plot_types = {'images','multiplot'};

IBS_save_powerpoint_corr(analysis_type,ppt,plot_types,analysis,file_precursur,analysis_sub_type);
close(ppt);

end