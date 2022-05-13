load('E:\Projects\IBS\Results\EEG\Brain_behavior_glm_power_freqwise\no_aggressive_CAR_ASR_10_ICA_appended_trials\Brain_behavior_glm_power_freqwiseno_aggressive_CAR_ASR_10_ICA_appended_trials_avg_sig_cluster_interaction_delay_insta_auto_joint.mat')

lme_cluster_1_data = glm_result.stats_cell{1}.Variables;
writetable(lme_cluster_1_data,'lme_cluster_1_data.csv')


lme_cluster_2_data = glm_result.stats_cell{2}.Variables;
writetable(lme_cluster_2_data,'lme_cluster_2_data.csv')


lme_cluster_3_data = glm_result.stats_cell{3}.Variables;
writetable(lme_cluster_3_data,'lme_cluster_3_data.csv')