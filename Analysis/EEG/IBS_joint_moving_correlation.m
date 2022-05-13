function [behavior_data_joint] = IBS_joint_moving_correlation(behav_data_1,behav_data_2,joint_fun)

windowSize_cols = 50; % based on EEG moving window
behavior_data_joint = IBS_behav_moving_correlation(table2array(behav_data_1),table2array(behav_data_2),windowSize_cols,joint_fun);


% behavior_data_joint = array2table(behavior_data_joint,'VariableNames',strrep(behav_data_1.Properties.VariableNames,'_S1','_joint'));
end