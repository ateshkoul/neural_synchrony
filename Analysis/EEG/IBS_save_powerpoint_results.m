function IBS_save_powerpoint_results(analysis,file_precursur)
if nargin <2
    
    file_precursur = '';
end



presentation_save_dir = 'Y:\\Inter-brain synchrony\\Results\\EEG\\IBS_EEG_presentations\\';
import mlreportgen.ppt.*
ppt = Presentation([presentation_save_dir 'results_' file_precursur analysis '.pptx']);
% analysis_type = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
analysis_type = {'no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};

% plot_types = {'images','multiplot'};
plot_types = {'images'};
IBS_save_powerpoint_corr(analysis_type,ppt,plot_types,analysis,file_precursur);
close(ppt);

end


% presentation_save_dir = 'Y:\\Inter-brain synchrony\\Results\\EEG\\IBS_EEG_presentations\\';
% import mlreportgen.ppt.*
% ppt = Presentation([presentation_save_dir 'results_connectivity_analysis_coh.pptx']);
% % ,'aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
% analysis_type = {'no_aggressive_trialwise_CAR'};
% plot_types = {'images','multiplot'};
% IBS_save_powerpoint_corr(analysis_type,ppt,plot_types,analysis,file_precursur);
% close(ppt);



% presentation_save_dir = 'Y:\\Inter-brain synchrony\\Results\\EEG\\IBS_EEG_presentations\\';
% import mlreportgen.ppt.*
% analysis = 'Connectivity_analysis';
% ppt = Presentation([presentation_save_dir 'results_connectivity_analysis_plv.pptx']);
% % ,'aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};%{'no_aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'};%,'aggressive_trialwise_CAR'};
% analysis_type = {'no_aggressive_trialwise_CAR'};
% plot_types = {'images','multiplot'};
% file_precursur = 'plv_analysis_';
% IBS_save_powerpoint_corr(analysis_type,ppt,plot_types,analysis,file_precursur);
% close(ppt);