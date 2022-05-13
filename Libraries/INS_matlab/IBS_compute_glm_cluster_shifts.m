function [betas,lme_model,deviances] = IBS_compute_glm_cluster_shifts(brain_data,behav_data,stat_cluster)
%% Atesh Koul
% 19-05-2021

[n_chans,~,n_freq] = size(brain_data);
% stat_cell = cell(n_chans,n_freq);

deviances = NaN(n_chans,n_freq);
% behav_data = IBS_glm_clean_behav_data(behav_data);
% this is because intercept has to be included and dyad no is to be removed
% betas = repmat(NaN,[64 95 size(behav_data,2)+1-1]);
betas = cell(n_chans,n_freq);

% behav_data.Properties.VariableNames = cellfun(@(x) x(1:11),behav_data.Properties.VariableNames,'UniformOutput',false);


% % different behaviors would have their own Dyad cols so just choose 1 out
% % of many and remove others
% dyad_cols = contains(behav_data.Properties.VariableNames,'Dyad_no');
%
% % get the first dyad col name - all the rest should be the same
% dyad_col_names = behav_data.Properties.VariableNames(dyad_cols);
% random_effects_var_name = dyad_col_names{1,1};
% % fixed_effects_var_names = behav_data.Properties.VariableNames(~ismember(behav_data.Properties.VariableNames,random_effects_var_name));
%
% condition_cols = contains(behav_data.Properties.VariableNames,'condition');
% condition_col_names = behav_data.Properties.VariableNames(condition_cols);

% fixed_effects_var_names = behav_data.Properties.VariableNames(~ismember(behav_data.Properties.VariableNames,[dyad_col_names condition_col_names]));
%
% % all_fixed_var_names = strcat([fixed_effects_var_names condition_col_names(1)],'*');
%
% all_fixed_var_names = strcat([fixed_effects_var_names],'+');
% % all_fixed_var_names = strcat([fixed_effects_var_names condition_col_names(1)],'+');
%
% all_fixed_var_names = cat(2,all_fixed_var_names{:});
% all_fixed_var_names = all_fixed_var_names(1:end-1);

brain_data = permute(brain_data,[1 3 2]);

% cur_brain_data = brain.*repmat(stat_cluster,1,1,27623);

% cur_brain_data = normalize(squeeze(nanmean(nanmean(brain_data.*repmat(stat_cluster,1,1,size(brain_data,3))))));


% doesn't matter to AIC or BIC if u normalize or not but for coefficients
% it's better to normalize - so that they make direct sense
% cur_brain_data_table = table(squeeze(nanmean(nanmean(brain_data.*repmat(stat_cluster,1,1,size(brain_data,3))))),'VariableNames',{'chan_freq_data'});

% this was previously
% cur_brain_data_table = table(normalize(squeeze(nanmean(nanmean(brain_data.*repmat(stat_cluster,1,1,size(brain_data,3))))),'zscore'),'VariableNames',{'chan_freq_data'});
%
% all_data = [cur_brain_data_table behav_data];

%% normalize subjectwise
brain_data_cluster = table(squeeze(nanmean(nanmean(brain_data.*repmat(stat_cluster,1,1,size(brain_data,3))))),'VariableNames',{'chan_freq_data'});
func  = @(x){normalize(x,'zscore')};
% [Groups,~] = findgroups(cellstr(behav_data.Dyad_no_Gaze_nose_dist));
[Groups,~] = findgroups(cellstr(behav_data.Dyad_no_Gaze_nose_dist),cellstr(behav_data.condition_Smile_auto));

normalized_subwise_brain_data = splitapply(func,brain_data_cluster.chan_freq_data,Groups);
% check that data is normalized data is subjectwise
% cellfun(@(x) std(x), normalized_subwise_brain_data,'UniformOutput',0)

normalized_subwise_brain_data = table(cat(1,normalized_subwise_brain_data{:}),'VariableNames',{'chan_freq_data'});
all_data = [normalized_subwise_brain_data behav_data];

conditions = unique(cellstr(all_data.condition_Gaze_nose_dist))';

shifts = [-30 -20 -19 -18 -17 -16 -15 -14 -13 -12 -11 -10 -9 -8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 30]; % in seconds
subset_fun = @(x) x(2);
Dyads = unique(cellstr(all_data.Dyad_no_Gaze_nose_dist));
Dyads = cell2mat(cellfun(@(x) str2double(subset_fun(strsplit(x,'_'))),Dyads,'UniformOutput',0))';

% mapObj = containers.Map({'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned'},...
%     {'Fun_eye_gaze_distance_joint','Fun_mouth_size_joint','Fun_ALL_joint'});
lme_model = cell(1,length(shifts));
for shift = 1:length(shifts)
    data_binned_condition = cell(length(Dyads),length(conditions));
    for dyd_no = 1:length(Dyads)
        dyad_str = sprintf('Dyad_%0.2d',Dyads(dyd_no));
        sub_data = all_data(strcmpi(cellstr(all_data.Dyad_no_Gaze_nose_dist), dyad_str),:);
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
            groups = groups(1:size(data_variables,1));
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
    for fixed_effects_var = 1:length(fixed_effects_var_names)
        all_fixed_var_names = fixed_effects_var_names{fixed_effects_var};
%     all_fixed_var_names = strcat([fixed_effects_var_names],'+');

    % all_fixed_var_names = strcat([fixed_effects_var_names condition_col_names(1)],'+');
    
%     all_fixed_var_names = cat(2,all_fixed_var_names{:});
%     all_fixed_var_names = all_fixed_var_names(1:end-1);
    
    dyad_cols = contains(data_all_dyads.Properties.VariableNames,'Dyad_no');
    
    % get the first dyad col name - all the rest should be the same
    dyad_col_names = data_all_dyads.Properties.VariableNames(dyad_cols);
    random_effects_var_name = dyad_col_names{1,1};
    
    lme_model{fixed_effects_var,shift} = fitlme(data_all_dyads,['nanmean_chan_freq_data~ '  all_fixed_var_names ' + (1|' random_effects_var_name ')'],'DummyVarCoding','effects');
    
    end
end


end