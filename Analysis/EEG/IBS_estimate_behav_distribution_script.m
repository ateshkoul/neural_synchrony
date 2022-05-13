

%%
analysis = 'Brain_behavior_glm_power_freqwise';
data_analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';

save_dir = IBS_get_params_analysis_type(data_analysis_type,analysis).analysis_save_dir{1,1};
save_dir_figures = IBS_get_params_analysis_type(data_analysis_type,analysis).analysis_save_dir_figures{1,1};

%%


[sub_avg_behav_eye,frac_AND_eye] = IBS_estimate_behav_distribution('Eye_tracker_gaze');
[sub_avg_behav_eye,frac_AND_eye] = IBS_estimate_behav_distribution('Gaze_nose_dist');

[sub_avg_behav_smile,frac_AND_smile] = IBS_estimate_behav_distribution('Smile_auto');
[sub_avg_behav_body,frac_AND_body] = IBS_estimate_behav_distribution('video_openpose_landmarks_manual_cleaned');

save([save_dir 'behavior_distribution.mat'],'sub_avg_behav_eye','frac_AND_eye',...
    'sub_avg_behav_smile','frac_AND_smile','sub_avg_behav_body','frac_AND_body')

bar([mean(sub_avg_behav_eye);mean(sub_avg_behav_body);mean(sub_avg_behav_smile)])
sem = @(x,dim) nanstd( x,0,dim ) / sqrt( size( x,dim ));
hold on
errorbar([mean(sub_avg_behav_eye);mean(sub_avg_behav_body);mean(sub_avg_behav_smile)],...
    [sem(sub_avg_behav_eye,2);sem(sub_avg_behav_body,2);sem(sub_avg_behav_smile,2)],'k','linestyle','none')
xticklabels({'Eye contact','Body movements','Smiling'})
exportgraphics(gcf,[save_dir_figures '\\behavior_distribution.eps'],'BackgroundColor','none','ContentType','vector')

%%


%%
behav_analysis = 'joint';
output_data = 'all';
behavior_data = IBS_load_behavior_data(behavior,data_analysis_type,1:23,conditions,behav_analysis,analysis_sub_type,output_data);
cellfun(@(x) cell2mat(cellfun(@(sub) sum(table2array(sub(:,1))),x,'UniformOutput',0)),behavior_data_XOR,'UniformOutput',0)






