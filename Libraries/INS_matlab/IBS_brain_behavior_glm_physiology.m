function [glm_result] = IBS_brain_behavior_glm_physiology(data_analysis_type,analysis,condition,analysis_sub_type,output)

if nargin <5
    output = 'plots';
    
end


if nargin <4
   analysis_sub_type = '_insta';
    
end



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
% here the behavior is changed in the sense that the data is normalized
% first subjectwise and then joint function is applied
% save_fname = [save_dir cond_name '_auto_joint_merged_cond_norm_joint_behav.mat'];
% % save_fname = [save_dir cond_name '_eye_lowpassed.mat'];
% save_fname = [save_dir cond_name '_smile_corrected_video_sub_mouth.mat'];
save_fname = [save_dir cond_name '_physio_joint.mat'];

% save_fname = [save_dir cond_name '_inv_eye_auto_joint_merged_cond_norm_joint_behav.mat'];

% save_fname = [save_dir cond_name '_auto_joint_merged_cond_20_data_smoothed.mat'];
% save_fname = [save_dir cond_name '_insta_auto_joint_merged_cond.mat'];

%%
if exist(save_fname,'file')
    load(save_fname,'glm_result','analysis','data_analysis_type','behaviors','behav_analysis')
%      lme_cluster_1_data = glm_result.stats_cell{1}.Variables;
%     writetable(lme_cluster_1_data,[cond_name '_lme_cluster_1_data_IBS.csv'])
%         lme_cluster_1_data = glm_result.stats_cell{1}.Variables;
%         writetable(lme_cluster_1_data,[cond_name '_lme_cluster_1_data.csv'])
%     
%     
%         lme_cluster_2_data = glm_result.stats_cell{2}.Variables;
%         writetable(lme_cluster_2_data,[cond_name '_lme_cluster_2_data.csv'])


%     lme_cluster_1_data = glm_result.stats_cell{1}.Variables;
%     writetable(lme_cluster_1_data,[cond_name '_lme_smile_cluster_beta_data_IBS.csv'])
%     
%     
%     lme_cluster_2_data = glm_result.stats_cell{2}.Variables;
%     writetable(lme_cluster_2_data,[cond_name '_lme_smile_cluster_gamma_data_IBS.csv'])
% 
%         lme_cluster_3_data = glm_result.stats_cell{3}.Variables;
%     writetable(lme_cluster_3_data,[cond_name '_lme_smile_cluster_alpha_data_IBS.csv'])

else
    % Data from some conditions in these dyads 7,15 and 19 is not considered because of NaN in their data. this is removed from the analysis
    Dyads = [1:23];
    
    %% load brain data
    brain_data = IBS_brain_behavior_get_brain_data(data_analysis_type,analysis,Dyads,condition,analysis_sub_type);
    % brain_data = cellfun(@(x) cat(2,brain_data_sub{:}),;
    
    %% load the behavior
    % behaviors = {'Eye_tracker_pupil','Eye_tracker_gaze_positions_on_body'};
    % behaviors = {'Eye_tracker_gaze','Video_manual_labelled'};
    % behaviors = {'Eye_tracker_gaze_nose_dist','Smile_auto','Video_manual_labelled'};
%     behaviors = {'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned'};
%     behaviors = {'Eye_tracker_pupil','Smile_auto','video_openpose_landmarks_manual_cleaned'};
%     behaviors = {'Eye_tracker_pupil','ECG','EDA','Resp'};
    behaviors = {'Eye_tracker_pupil','ECG','EDA'};

%     behaviors = {'Smile_auto'};
    behav_analysis = 'joint';
    behavior_data = IBS_brain_behavior_get_behavioral_data(data_analysis_type,analysis,behaviors,Dyads,condition,behav_analysis,analysis_sub_type);
    
    
    %% GLM
    % glm_result = IBS_compute_brain_behavior_glm(brain_data,behavior_data,data_analysis_type);
    % glm_result = IBS_compute_brain_behavior_glm(brain_data_sub,behavior_data,data_analysis_type);
    
    % all subjects
    % for joint features, there is an error on the full column rank if only few
    % dyads are used.
    % if x is ill conditioned, for the dyad no.s
    
    % if there are issues of full rank - basically it should mean that there
    % aren't enough distinct values of a specific condition to estimate it.
        glm_result = IBS_compute_brain_behavior_glm(data_analysis_type,analysis,brain_data,behavior_data);

    
    
    %%
    % cond_name = strcat(condition,'_');
    % cond_name = cat(2,cond_name{:});
    
    
    % clusternames = {['cluster_1_' behav_analysis ],['cluster_2_' behav_analysis ],['cluster_3_' behav_analysis ]};
    % cellfun(@(x,y) IBS_plot_brain_behav_glm_mean_scatter_plot(data_analysis_type,analysis,x,y,behav_analysis),...
    %     glm_result.stats_cell,clusternames,'UniformOutput',false);
    
    % save([save_dir analysis data_analysis_type '_' cond_name behav_analysis '_avg_sig_cluster_interaction.mat'],'glm_result','analysis','data_analysis_type','behaviors',...
    %     'freq_bands','windowSize','-v7.3')
    %%
    % save([save_dir analysis data_analysis_type '_' behav_analysis '_avg_sig_cluster_interaction_delay_insta_auto.mat'],'glm_result_AND','glm_result_OR','analysis','data_analysis_type','behaviors',...
    %     'behav_analysis','-v7.3')
    
    
    
    
    save(save_fname,'glm_result','analysis','data_analysis_type','behaviors',...
        'behav_analysis','-v7.3')
    
    
    
%     lme_cluster_1_data = glm_result.stats_cell{1}.Variables;
%     writetable(lme_cluster_1_data,[cond_name '_lme_cluster_1_data_IBS.csv'])
%     
%     
%     lme_cluster_2_data = glm_result.stats_cell{2}.Variables;
%     writetable(lme_cluster_2_data,[cond_name '_lme_cluster_2_data_IBS.csv'])
%     
%         lme_cluster_3_data = glm_result.stats_cell{3}.Variables;
%     writetable(lme_cluster_3_data,[cond_name '_lme_cluster_3_data_IBS.csv'])
%     
%         lme_cluster_4_data = glm_result.stats_cell{4}.Variables;
%     writetable(lme_cluster_4_data,[cond_name '_lme_cluster_4_data_IBS.csv'])
end
%%

switch(output)
    case 'plots'
        IBS_brain_behav_plot_Model_fit(data_analysis_type,analysis,glm_result,cond_name)
        
        IBS_brain_behav_plot_glm_coeff(data_analysis_type,analysis,glm_result,'joint',cond_name)
        
        close all
        
        
%         shifts = [-3 -2 -1 0 1 2 3]; % in seconds
% 
%     for shift = 1:length(shifts)
%         
%         IBS_brain_behav_plot_glm_coeff(data_analysis_type,analysis,...
%             {glm_result.stats_cell{1,1}{1,shift} glm_result.stats_cell{1,2}{1,shift} glm_result.stats_cell{1,3}{1,shift}},'joint',cond_name)
%     end


    case 'no_plots'
        % do nothing
end

%
% lme_cluster_3_data = glm_result.stats_cell{3}.Variables;
% writetable(lme_cluster_3_data,'lme_cluster_3_data.csv')

end

