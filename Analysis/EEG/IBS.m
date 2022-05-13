%% IBS script
% Atesh Koul 18-08-2020
% -------------------------------------
%%
startup_IBS()
%% save data

save_cleaned_IBS_data

save_ICA_processed_IBS_data
IBS_save_artefact_removed_processed_IBS_data
%% ASR cleaning
% IBS_asr_clean_combined_trials(analysis_type,[1:11 13:23]);
IBS_asr_clean_combined_trials_script

%% within brain analysis
IBS_within_brain_analysis_script %ILW_custANOVA_parfor % run
% IBS_plot_save_lw_anova_script
IBS_power_stats_script_within_brain_analysis
IBS_power_t_stats_script_within_brain_analysis
%% time-freq analysis

IBS_tf_correlation_script % run
% statistics for time-freq
IBS_power_stats_script
IBS_power_t_stats_script
IBS_test_correlation_dyad_specific_script % go to IBS_power_stats_script
IBS_tf_plot_sub_averages_script
IBS_export_sig_electrodes_script

%% 
IBS_natural_freq_script

%% moving window analyses
IBS_tf_moving_correlations_script

%% Brain-behavior analyses

IBS_brain_behavior_glm_script
IBS_save_glm_result
IBS_brain_behavior_ERP_script
IBS_brain_behavior_phase_relationship_script
IBS_granger_causality_script

IBS_brain_behavior_plot_LOO
IBS_estimate_smile_corresp_script

IBS_generate_crosscorr_figure


IBS_behav_correlation_cov_script
IBS_estimate_behav_distribution_script

IBS_estimate_mov_outliers
IBS_estimate_mov_manual_step2

IBS_manual_labelled_behav_script

IBS_plot_behav_functions_script


IBS_SEM_analysis_script

%%
IBS_result_gen_figure
%%
IBS_generate_example_plots
%%
IBS_plot_topoplots_3d_script
IBS_plot_sample_images_script

IBS_example_raw_tf_LME_plots_script
IBS_example_power_correlation_procedure

%%


IMS


%%
IBS_brain_physio_script

%%
IBS_vicon_script


%%
IBS_monkey

%% extra misc stuff

%% source analysis
IBS_source_analysis
IBS_source_analysis_brainstorm


%%
IBS_save_video_landmark_condition_data
IBS_load_video_landmark_condition_data % for raw data
%%
IBS_power_stats_one_way_anova_script
%%
IBS_align_eeg_pupil_blinker_script

%%
IBS_read_EEG_file_details_script

%% 
IBS_compute_interp_chans


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
IBS_vicon_script
