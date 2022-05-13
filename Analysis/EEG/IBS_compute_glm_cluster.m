function [betas,stat_cell,deviances] = IBS_compute_glm_cluster(brain_data,behav_data,stat_cluster)
%% Atesh Koul
% 04-02-2021

[n_chans,~,n_freq] = size(brain_data);
stat_cell = cell(n_chans,n_freq);

deviances = NaN(n_chans,n_freq);
% behav_data = IBS_glm_clean_behav_data(behav_data);
% this is because intercept has to be included and dyad no is to be removed
% betas = repmat(NaN,[64 95 size(behav_data,2)+1-1]);
betas = cell(n_chans,n_freq);

% behav_data.Properties.VariableNames = cellfun(@(x) x(1:11),behav_data.Properties.VariableNames,'UniformOutput',false);


% different behaviors would have their own Dyad cols so just choose 1 out
% of many and remove others
dyad_cols = contains(behav_data.Properties.VariableNames,'Dyad_no');

% get the first dyad col name - all the rest should be the same
dyad_col_names = behav_data.Properties.VariableNames(dyad_cols);
random_effects_var_name = dyad_col_names{1,1};
% fixed_effects_var_names = behav_data.Properties.VariableNames(~ismember(behav_data.Properties.VariableNames,random_effects_var_name));

condition_cols = contains(behav_data.Properties.VariableNames,'condition');
condition_col_names = behav_data.Properties.VariableNames(condition_cols);

fixed_effects_var_names = behav_data.Properties.VariableNames(~ismember(behav_data.Properties.VariableNames,[dyad_col_names condition_col_names]));

% all_fixed_var_names = strcat([fixed_effects_var_names condition_col_names(1)],'*');

all_fixed_var_names = strcat([fixed_effects_var_names],'+');
% all_fixed_var_names = strcat([fixed_effects_var_names condition_col_names(1)],'+');

all_fixed_var_names = cat(2,all_fixed_var_names{:});
all_fixed_var_names = all_fixed_var_names(1:end-1);

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
% [Groups,~] = findgroups(cellstr(behav_data.Dyad_no_Gaze_nose_dist),cellstr(behav_data.condition_Smile_auto));
% for not physiology results
% [Groups,~] = findgroups(cellstr(behav_data.Dyad_no_Smile_auto),cellstr(behav_data.condition_Smile_auto));
% after physiology
dyad_col_name = dyad_col_names{1};
condition_col_name = condition_col_names{1};
[Groups,~] = findgroups(cellstr(behav_data.(dyad_col_name)),cellstr(behav_data.(condition_col_name)));

normalized_subwise_brain_data = splitapply(func,brain_data_cluster.chan_freq_data,Groups);
% check that data is normalized data is subjectwise
% cellfun(@(x) std(x), normalized_subwise_brain_data,'UniformOutput',0)

normalized_subwise_brain_data = table(cat(1,normalized_subwise_brain_data{:}),'VariableNames',{'chan_freq_data'});
all_data = [normalized_subwise_brain_data behav_data];



all_data = rmmissing(all_data);

% s = rowfun(@mean,all_data,'GroupingVariables',{'Dyad_no_Eye_tracker_gaze','Fun_eye_on_face_ellipse_0'},'InputVariables',{'chan_freq_data'});

% all_data.chan_freq_data = all_data.chan_freq_data -0.5; % this means that 0 is now 0 correlation and range is [-0.5 0.5]


% lme = fitlme(all_data,['chan_freq_data~' condition_col_names{1} '*(' all_fixed_var_names ')+ (1|' random_effects_var_name ')'],'DummyVarCoding','effects');
% lme = fitlme(all_data,['chan_freq_data~' condition_col_names{1} '+' all_fixed_var_names '+ (1|' random_effects_var_name ')'],'DummyVarCoding','effects');

% lme = fitlme(all_data,['chan_freq_data~' all_fixed_var_names '+ (1|' random_effects_var_name ')'],'DummyVarCoding','effects');

% lme = fitlme(all_data,['chan_freq_data~ '  all_fixed_var_names ' + (1|' random_effects_var_name ')'],'DummyVarCoding','effects');
lme = fitlme(all_data,['chan_freq_data~ 1+'   all_fixed_var_names ' + (1|' random_effects_var_name ')']);
% lme = fitlme(all_data,['chan_freq_data~ -1+'   all_fixed_var_names ' + (1|' random_effects_var_name ')'],'DummyVarCoding','full');

% if u choose only eye gaze and movement, the model is better than null but
% when u add the mouth size, the difference becomes 0.6846

% p = IBS_compute_brain_behav_permutation(all_data,all_fixed_var_names,random_effects_var_name,100)
%[~,~,STATS] = randomEffects(lme)
% anova(lme)
lme_null = fitlme(all_data,['chan_freq_data~1+(1|' random_effects_var_name ')']);
% lme_null = fitlme(all_data,['chan_freq_data~1+(1|' random_effects_var_name ')'],'DummyVarCoding','full');

B = lme.Coefficients.Estimate;

% dev = lme.ModelCriterion.BIC/lme_null.ModelCriterion.BIC;
dev = lme_null.ModelCriterion;

stats = lme;
deviances = dev;
stat_cell = stats;
% this is important to track in case there are some features that
% are eliminated.
betas = array2table(B','VariableNames',lme.CoefficientNames);

end