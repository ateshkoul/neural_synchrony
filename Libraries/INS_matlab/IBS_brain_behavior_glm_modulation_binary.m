function [glm_result_AND,glm_result_XOR] = IBS_brain_behavior_glm_modulation_binary(data_analysis_type,analysis,condition,analysis_sub_type,output)
if nargin <5
    output = 'plots';
    
end


if nargin <4
    analysis_sub_type = '_insta';
    
end



%%
%% get cond name
subset = @(x) x{1};

cond_name = cellfun(@(x) subset(strsplit(x,'_')),condition,'UniformOutput',0);
cond_name = strjoin(unique(cond_name),'_');


% analysis_sub_type = '_IBS_moving_win';
cond_name = [cond_name analysis_sub_type];
% cond_name = [cond_name '_all_norm_subwise'];
% cond_name = [cond_name '_all_norm_subwise'];

save_dir = IBS_get_params_analysis_type(data_analysis_type,analysis).analysis_save_dir{1,1};

% save_fname = [save_dir cond_name '_auto_joint_merged_cond.mat'];
save_fname = [save_dir cond_name '_modulation_smile_AND_XOR.mat'];

% save_fname = [save_dir cond_name '_auto_joint_merged_cond_20_data_smoothed.mat'];
% save_fname = [save_dir cond_name '_insta_auto_joint_merged_cond.mat'];

%%

if exist(save_fname,'file')
    load(save_fname,'glm_result_AND','glm_result_XOR','analysis','data_analysis_type','analysis_sub_type','behaviors','behav_analysis')
%         lme_cluster_1_data_AND = glm_result_AND.stats_cell{1}.Variables;
%         writetable(lme_cluster_1_data_AND,[cond_name '_lme_cluster_1_data_AND.csv'])
%     
%     
%         lme_cluster_2_data_AND = glm_result_AND.stats_cell{2}.Variables;
%         writetable(lme_cluster_2_data_AND,[cond_name '_lme_cluster_2_data_AND.csv'])
%         
%         lme_cluster_3_data_AND = glm_result_AND.stats_cell{3}.Variables;
%         writetable(lme_cluster_3_data_AND,[cond_name '_lme_cluster_3_data_AND.csv'])
%         
%         lme_cluster_1_data_XOR = glm_result_XOR.stats_cell{1}.Variables;
%         writetable(lme_cluster_1_data_XOR,[cond_name '_lme_cluster_1_data_XOR.csv'])
%     
%     
%         lme_cluster_2_data_XOR = glm_result_XOR.stats_cell{2}.Variables;
%         writetable(lme_cluster_2_data_XOR,[cond_name '_lme_cluster_2_data_XOR.csv'])
% 
%         lme_cluster_3_data_XOR = glm_result_XOR.stats_cell{3}.Variables;
%         writetable(lme_cluster_3_data_XOR,[cond_name '_lme_cluster_3_data_XOR.csv'])
else
    Dyads = 1:23;
    
    %% load brain data
    brain_data = IBS_brain_behavior_get_brain_data(data_analysis_type,analysis,Dyads,condition,analysis_sub_type);
    % brain_data = cellfun(@(x) cat(2,brain_data_sub{:}),;
    
    %% load the behavior
    % behaviors = {'Eye_tracker_pupil','Eye_tracker_gaze_positions_on_body'};
    % behaviors = {'Eye_tracker_gaze','Video_manual_labelled'};
    behaviors = {'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned',...
        'Eye_tracker_gaze-Smile_auto','Eye_tracker_gaze-video_openpose_landmarks_manual_cleaned'};
        % behaviors = {'video_openpose_landmarks_manual_cleaned'};
    
%     behaviors = {'Eye_tracker_gaze-Smile_auto'};
    behav_analysis = 'joint_AND';
    behavior_data_AND  = IBS_brain_behavior_get_behavioral_data(data_analysis_type,analysis,behaviors,Dyads,condition,behav_analysis,analysis_sub_type);
    
    
    behav_analysis = 'joint_XOR';
    behavior_data_XOR  = IBS_brain_behavior_get_behavioral_data(data_analysis_type,analysis,behaviors,Dyads,condition,behav_analysis,analysis_sub_type);
    
    %% GLM
    % glm_result = IBS_compute_brain_behavior_glm(brain_data,behavior_data,data_analysis_type);
    % glm_result = IBS_compute_brain_behavior_glm(brain_data_sub,behavior_data,data_analysis_type);
    
    % all subjects
    % for joint features, there is an error on the full column rank if only few
    % dyads are used.
    % if x is ill conditioned, for the dyad no.s
    
    % if there are issues of full rank - basically it should mean that there
    % aren't enough distinct values of a specific condition to estimate it.
    
    glm_result_AND = IBS_compute_brain_behavior_glm(data_analysis_type,analysis,brain_data,behavior_data_AND);
    glm_result_XOR = IBS_compute_brain_behavior_glm(data_analysis_type,analysis,brain_data,behavior_data_XOR);
    % glm_result = IBS_compute_brain_behavior_glm(data_analysis_type,analysis,brain_data_freqwise,behavior_data);
    
    
    %%
    % cond_name = strcat(condition,'_');
    % cond_name = cat(2,cond_name{:});
    
    % behav_analysis = 'joint_AND';
    % clusternames = {['cluster_1_' behav_analysis ],['cluster_2_' behav_analysis ],['cluster_3_' behav_analysis ]};
    % cellfun(@(x,y) IBS_plot_brain_behav_glm_mean_scatter_plot(data_analysis_type,analysis,x,y,behav_analysis),...
    %     glm_result_AND.stats_cell,clusternames,'UniformOutput',false);
    %
    % behav_analysis = 'joint_OR';
    % clusternames = {['cluster_1_' behav_analysis ],['cluster_2_' behav_analysis ],['cluster_3_' behav_analysis ]};
    % cellfun(@(x,y) IBS_plot_brain_behav_glm_mean_scatter_plot(data_analysis_type,analysis,x,y,behav_analysis),...
    %     glm_result_OR.stats_cell,clusternames,'UniformOutput',false);
    
    % save([save_dir analysis data_analysis_type '_' cond_name behav_analysis '_avg_sig_cluster_interaction.mat'],'glm_result','analysis','data_analysis_type','behaviors',...
    %     'freq_bands','windowSize','-v7.3')
    %%
    % save([save_dir analysis data_analysis_type '_' behav_analysis '_avg_sig_cluster_interaction_delay_insta_auto.mat'],'glm_result_AND','glm_result_OR','analysis','data_analysis_type','behaviors',...
    %     'behav_analysis','-v7.3')
    
    save(save_fname,'glm_result_AND','glm_result_XOR','analysis','data_analysis_type','behaviors','analysis_sub_type',...
        'behav_analysis','-v7.3')
    
end
end




% load('E:\Projects\IBS\Results\EEG\Brain_behavior_glm_power_freqwise\no_aggressive_CAR_ASR_10_ICA_appended_trials\Brain_behavior_glm_power_freqwiseno_aggressive_CAR_ASR_10_ICA_appended_trials_joint_OR_avg_sig_cluster_interaction.mat')
%
% bar([1 2 3], cell2mat(cellfun(@(x) x.ModelCriterion{1,2},glm_result.stats_cell,'UniformOutput',0))/10e5)
%
% BIC_OR = cell2mat(cellfun(@(x) x.ModelCriterion{1,2},glm_result.stats_cell,'UniformOutput',0));
%
%
% load('E:\Projects\IBS\Results\EEG\Brain_behavior_glm_power_freqwise\no_aggressive_CAR_ASR_10_ICA_appended_trials\Brain_behavior_glm_power_freqwiseno_aggressive_CAR_ASR_10_ICA_appended_trials_joint_AND_avg_sig_cluster_interaction.mat')
% hold on
% bar([4 5 6], cell2mat(cellfun(@(x) x.ModelCriterion{1,2},glm_result.stats_cell,'UniformOutput',0))/10e5,'r')
% yaxis([0 1])
%
% BIC_AND = cell2mat(cellfun(@(x) x.ModelCriterion{1,2},glm_result.stats_cell,'UniformOutput',0));
%
%



% %%
% coeff = 2;
% p_value_cell = cellfun(@(x) cellfun(@(y) y.p(coeff),x,'UniformOutput',false),glm_result.stats_cell,'UniformOutput',false);
% imagesc(cell2mat(p_value_cell{1,1}),[0 0.06])
%
% [p_fdr, p_masked] = fdr(cell2mat(p_value_cell{1,1}),0.05);
% figure; imagesc(p_masked)
%
% %%
% coeff = 10;
% p_value_cell = cellfun(@(y) y.p(coeff),glm_result.stats_cell,'UniformOutput',false);
% imagesc(cell2mat(p_value_cell),[0 0.06])
%
% [p_fdr, p_masked] = fdr(cell2mat(p_value_cell),0.05);
% figure; imagesc(p_masked)
%
% %%
%
% sub_no = 1;
%
%
% plot(zscore(brain_data_sub_1{1,sub_no }(1,:,1)))
% hold on
%
% plot(table2array(behavior_data{1, 4}{1, sub_no}(:,3)),'r')
% % plot(table2array(behavior_data{1, 5}{1, sub_no}(:,3)),'k')
%
%
% for sub_no = 1:23
%
%
% [a,p] = corrcoef(brain_data_sub{1, sub_no}(1,1:1201,1)',behavior_data{1, 3}{1, sub_no}(1:1201,3)');
% P(sub_no) = p(1,2);
% end