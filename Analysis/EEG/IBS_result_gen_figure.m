%% script to generate figures
%% Atesh - 13-01-2021


%% t_stat figure
%%


analysis = 'Within_analysis_fig';
IBS_save_powerpoint_results_t_stats(analysis);

%%
analysis = 'Power_correlation_analysis_fig';
IBS_save_powerpoint_results_t_stats(analysis);


%% Figure 1
analysis = 'Power_correlation_analysis_fig';
IBS_save_powerpoint_results(analysis,'trialwise_detrend_freqwise_');
IBS_save_powerpoint_results(analysis,'pseudo_detrend_freqwise_');
% 
% 
% analysis = 'Connectivity_analysis_fig';
% file_precursur = 'coherence_analysis_';
% IBS_save_powerpoint_results(analysis,file_precursur);

%% ANOVA figure
%%


analysis = 'Within_analysis_fig';
IBS_save_powerpoint_results_anova(analysis);

%%
analysis = 'Power_correlation_analysis_fig';
IBS_save_powerpoint_results_anova(analysis);




