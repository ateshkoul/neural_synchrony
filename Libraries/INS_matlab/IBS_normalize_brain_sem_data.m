function all_data = IBS_normalize_brain_sem_data(all_data)
% [Groups,~] = findgroups(cellstr(behav_data.Dyad_no_Gaze_nose_dist));
% [Groups,~] = findgroups(cellstr(behav_data.Dyad_no_Gaze_nose_dist),cellstr(behav_data.condition_Smile_auto));
% for not physiology results
% [Groups,~] = findgroups(cellstr(behav_data.Dyad_no_Smile_auto),cellstr(behav_data.condition_Smile_auto));
% after physiology
dyad_cols = contains(all_data.Properties.VariableNames,'Dyad_no');

dyad_col_names = all_data.Properties.VariableNames(dyad_cols);
condition_cols = contains(all_data.Properties.VariableNames,'condition');
condition_col_names = all_data.Properties.VariableNames(condition_cols);


dyad_col_name = dyad_col_names{1};
condition_col_name = condition_col_names{1};
[Groups,~] = findgroups(cellstr(all_data.(dyad_col_name)),cellstr(all_data.(condition_col_name)));

IBS_cols = find(contains(all_data.Properties.VariableNames,'chan_freq_data'));
IBS_col_names = all_data.Properties.VariableNames{IBS_cols};

func  = @(x){normalize(x,'zscore')};

for cluster = 1:length(IBS_cols)
    cur_cluster_name = all_data.Properties.VariableNames{cluster};
normalized_subwise_brain_data = splitapply(func,all_data.(cur_cluster_name),Groups);

all_data.(cur_cluster_name) = cat(1,normalized_subwise_brain_data{:});


end