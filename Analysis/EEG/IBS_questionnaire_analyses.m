
questionnaire_fname = 'Y:\\Inter-brain synchrony\\Results\\Questionnaire_details.xlsx';

QuestionnaireS1 = import_questionnaire_data(questionnaire_fname,2);


[a,b] = corr([QuestionnaireS1.embarrassment_visual_contact1;QuestionnaireS1.embarrassment_visual_contact2],[QuestionnaireS1.embarrassment_visual_contact_unfamiliar1;QuestionnaireS1.embarrassment_visual_contact_unfamiliar2],'type', 'Spearman')


[r,p] = corr(QuestionnaireS1.driving_other_smile2,QuestionnaireS1.smile_when_observing2,'type','Spearman')


[r,p] = corr([QuestionnaireS1.driving_other_smile1;QuestionnaireS1.driving_other_smile2],[QuestionnaireS1.smile_when_observing1; QuestionnaireS1.smile_when_observing2],'type','Spearman')


[r,p] = corr([QuestionnaireS1.driving_other_mov1;QuestionnaireS1.driving_other_mov2],[QuestionnaireS1.mov_when_observing1; QuestionnaireS1.mov_when_observing2],'type','Spearman')
[r,p] = corr([QuestionnaireS1.driving_other_eyegaze1;QuestionnaireS1.driving_other_eyegaze2],[QuestionnaireS1.eyegaze_when_observing1; QuestionnaireS1.eyegaze_when_observing2],'type','Spearman')


% probably not interesting barely significant 0.0274
[a,b] = corr([QuestionnaireS1.attention_during_expt1;QuestionnaireS1.attention_during_expt2],...
    [QuestionnaireS1.visiting_freq1;QuestionnaireS1.visiting_freq2],'type', 'Spearman')


%%
analysis = 'Brain_behavior_glm_power_freqwise';
analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
conditions = {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'};
analysis_sub_type = '_insta_corr_avg_freqwise';

glm_result = IBS_brain_behavior_glm_binary(analysis_type,analysis,conditions,analysis_sub_type,'no_plots');
cluster_no = 2;
glm_data = glm_result.stats_cell{cluster_no}.Variables;


glm_data.social = glm_data.Fun_ALL_joint+glm_data.Fun_eyeface_joint+glm_data.Fun_mouth_size_joint;
glm_data.social = glm_data.social>0;

glm_data.Dyads = findgroups(cellstr(glm_data.Dyad_no_Smile_auto));
glm_data.conditions = findgroups(cellstr(glm_data.condition_Smile_auto));
summary_glm = groupsummary(glm_data,{'Dyads','conditions','social'},'mean','chan_freq_data');

s = summary_glm.mean_chan_freq_data((summary_glm.social==true & summary_glm.conditions == 4),:);
summary_glm = groupsummary(glm_data,{'Dyads','conditions'},'mean','chan_freq_data');

s = summary_glm.mean_chan_freq_data((summary_glm.conditions == 4),:);

summary_glm = groupsummary(glm_data,{'Dyads'},'mean','chan_freq_data');

s = summary_glm.mean_chan_freq_data;

%%
quest = IBS_compute_vector_angle(QuestionnaireS1.attention_during_expt1,QuestionnaireS1.attention_during_expt2);
quest = IBS_compute_vector_angle(QuestionnaireS1.subjective_closeness1,QuestionnaireS1.subjective_closeness2);
quest = IBS_compute_vector_angle(QuestionnaireS1.visiting_freq1,QuestionnaireS1.visiting_freq2);
quest = IBS_compute_vector_angle(QuestionnaireS1.years_of_familiarity1,QuestionnaireS1.years_of_familiarity2);

[r,p] = corr(s,quest,'type','Spearman')

tf_corr = IBS_tf_correlations(analysis_type);

gamma = cellfun(@(x) x{1,5}(:,73:95),tf_corr,'UniformOutput',0);
gamma = cat(1,gamma{:});
s = mean(gamma,2);

%% checks of something reliability
[r,p] = corr(QuestionnaireS1.visiting_freq1,QuestionnaireS1.visiting_freq2);


% not significant:

[a,b] = corr([QuestionnaireS1.attention_during_expt1;QuestionnaireS1.attention_during_expt2],[QuestionnaireS1.years_of_familiarity1;QuestionnaireS1.years_of_familiarity2],'type', 'Spearman')

[a,b] = corr([QuestionnaireS1.attention_during_expt1;QuestionnaireS1.attention_during_expt2],[QuestionnaireS1.subjective_closeness1;QuestionnaireS1.subjective_closeness2],'type', 'Spearman')


[a,b] = corr([QuestionnaireS1.years_of_familiarity1;QuestionnaireS1.years_of_familiarity2],[QuestionnaireS1.subjective_closeness1;QuestionnaireS1.subjective_closeness2],'type', 'Spearman')
[a,b] = corr([QuestionnaireS1.attention_during_expt1;QuestionnaireS1.attention_during_expt2],[QuestionnaireS1.subjective_closeness1;QuestionnaireS1.subjective_closeness2],'type', 'Spearman')

[a,b] = corr([QuestionnaireS1.attention_during_expt1;QuestionnaireS1.attention_during_expt2],...
    [QuestionnaireS1.embarrassment_visual_contact1;QuestionnaireS1.embarrassment_visual_contact2],'type', 'Spearman')


[a,b] = corr([QuestionnaireS1.visiting_freq1;QuestionnaireS1.visiting_freq2],...
    [QuestionnaireS1.embarrassment_visual_contact1;QuestionnaireS1.embarrassment_visual_contact2],'type', 'Spearman')





