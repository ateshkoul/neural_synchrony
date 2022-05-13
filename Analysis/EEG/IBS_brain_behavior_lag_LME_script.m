
Dyads = 1:23;
analysis = 'Brain_behavior_glm_power_freqwise';
conditions = {'NeNoOcc_1' 'NeNoOcc_2' 'NeNoOcc_3','FaNoOcc_1','FaNoOcc_2','FaNoOcc_3'};
analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';

% lag_no = [];
% conditions = {'NeNoOcc_1' 'NeNoOcc_2' 'NeNoOcc_3'};
% mouth_size = IBS_load_behavior_data(behavior,analysis_type,Dyads,conditions,behav_analysis,output_data);
analysis_type_params = IBS_get_params_analysis_type(analysis_type,analysis);
analysis_save_dir_figures = analysis_type_params.analysis_save_dir_figures{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';

% load('E:\Projects\IBS\Results\EEG\Brain_behavior_glm_power_freqwise\no_aggressive_CAR_ASR_10_ICA_appended_trials\Brain_behavior_glm_power_freqwiseno_aggressive_CAR_ASR_10_ICA_appended_trials_avg_sig_cluster_interaction_delay_insta_auto_joint.mat')
% load('E:\Projects\IBS\Results\EEG\Brain_behavior_glm_power_freqwise\no_aggressive_CAR_ASR_10_ICA_appended_trials\old\Brain_behavior_glm_power_freqwiseno_aggressive_CAR_ASR_10_ICA_appended_trials_avg_sig_cluster_interaction_delay_insta_auto_joint_merged_cond.mat')
% load('E:\Projects\IBS\Results\EEG\Brain_behavior_glm_power_freqwise\no_aggressive_CAR_ASR_10_ICA_appended_trials\FaNoOcc_NeNoOcc_insta_auto_joint_merged_cond.mat')

% analysis_sub_type = '_insta_20';
analysis_sub_type = '_insta';

glm_result = IBS_brain_behavior_glm(analysis_type,analysis,conditions,analysis_sub_type,'no_plots');

% cluster_no =2;
glm_data = glm_result.stats_cell{cluster_no}.Variables;

% xcf_mouth_joint_mat = [];
% xcf_mouth_S1_mat = [];
% xcf_mouth_S2_mat = [];
% lag_no = [];
lags = 200;
xcf_mouth_joint_mat = nan(length(Dyads),2*lags+1);



mapObj = containers.Map({'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned'},...
    {'eye_gaze_distance_joint','mouth_size_joint','ALL_joint'});

shifts = [-3 -2 -1 0 1 2 3]; % in seconds

% mapObj = containers.Map({'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned'},...
%     {'Fun_eye_gaze_distance_joint','Fun_mouth_size_joint','Fun_ALL_joint'});
lme_model = cell(1,length(shifts));
for shift = 1:length(shifts)
    data_binned_condition = cell(length(Dyads),length(conditions));
    for dyd_no = 1:length(Dyads)
        dyad_str = sprintf('Dyad_%0.2d',Dyads(dyd_no));
        sub_data = glm_data(strcmpi(cellstr(glm_data.Dyad_no_Gaze_nose_dist), dyad_str),:);
        %     joint_mouth_size = mouth_size{3}{Dyads(dyd_no)};
        for cond = 1:length(conditions)
            %         S1_value = mouth_size{1}{Dyads(dyd_no)}.mouth_size_0;
            %         S2_value = mouth_size{2}{Dyads(dyd_no)}.mouth_size_1;
            %         S1_value(isnan(S1_value)) = 0;
            %         S2_value(isnan(S2_value)) = 0;
            
            cur_cond = sub_data(strcmpi(cellstr(sub_data.condition_Gaze_nose_dist), conditions{cond}),:);
            brain_data_cols = contains(cur_cond.Properties.VariableNames,'chan_freq_data');
            data_cols = contains(cur_cond.Properties.VariableNames,'_joint');
            % remove the 1st value because it corresponds to 0 value
            % otherwise the values are 1201 difficult to group into 10
            % values
            data_variables = cur_cond(2:end,logical(brain_data_cols+data_cols));
            
            %         data_variables = cur_cond(:,contains(cur_cond.Properties.VariableNames,'_joint'));
            groups = repmat(1:120,10,1);
            groups = groups(:);
            groups = groups(1:size(cur_cond,1));
            data_variables = addvars(data_variables,groups);
            
            data_binned = varfun(@nanmean,data_variables,'GroupingVariables','groups');
            
            % shift only the brain data
            data_binned.nanmean_chan_freq_data = circshift(data_binned.nanmean_chan_freq_data,shifts(shift));
            
            if shifts(shift) <0
                % if the shift is negative, remove the last
                data_binned(end-abs(shifts(shift))+1:end,:) = [];
                
            else
                
                data_binned(1:abs(shifts(shift)),:) = [];
                
            end
            data_binned.Dyad_no = repmat(cur_cond.Dyad_no_Gaze_nose_dist(1,:),length(data_binned.nanmean_chan_freq_data),1);
            data_binned.condition = repmat(cur_cond.condition_Gaze_nose_dist(1,:),length(data_binned.nanmean_chan_freq_data),1);

            data_binned_condition{Dyads(dyd_no),cond} = data_binned;
            
            
        end
        
        
    end
    
    data_all_dyads = cat(1,data_binned_condition{:});
    fixed_effects_var_names = data_all_dyads.Properties.VariableNames(contains(data_all_dyads.Properties.VariableNames,'_joint'));
    
    all_fixed_var_names = strcat([fixed_effects_var_names],'+');
% all_fixed_var_names = strcat([fixed_effects_var_names condition_col_names(1)],'+');

all_fixed_var_names = cat(2,all_fixed_var_names{:});
all_fixed_var_names = all_fixed_var_names(1:end-1);

dyad_cols = contains(data_all_dyads.Properties.VariableNames,'Dyad_no');

% get the first dyad col name - all the rest should be the same
dyad_col_names = data_all_dyads.Properties.VariableNames(dyad_cols);
random_effects_var_name = dyad_col_names{1,1};

lme_model{shift} = fitlme(data_all_dyads,['nanmean_chan_freq_data~ '  all_fixed_var_names ' + (1|' random_effects_var_name ')'],'DummyVarCoding','effects');


end

