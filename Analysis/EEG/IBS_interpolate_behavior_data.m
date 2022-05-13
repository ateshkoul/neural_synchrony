function [behavior_data_aligned] = IBS_interpolate_behavior_data(behav_data,behav_type)

if nargin<2
    behav_type = 'continuous';
    
end


tf_time_seq = load('tf_time_seq.mat','tf_time');




timepoint_col = contains(behav_data.Properties.VariableNames,{'Time','timepoints','pupil_timestamp','time_stamps','timestamps'});
dyad_col = contains(behav_data.Properties.VariableNames,{'Dyad_no'});

[~,unique_indicies,~] = unique(behav_data(:,timepoint_col));
%     unique_indicies = find(unique(cur_behav_predictor(:,1)));
behav_data = behav_data(unique_indicies,:);


behav_data_cols = ~(timepoint_col + dyad_col);
switch(behav_type)
    case 'binary'
        corresponding_time_rows = IBS_find_corresponding_time_points(table2array(behav_data(:,timepoint_col)),tf_time_seq.tf_time');
        behavior_data_aligned = behav_data(corresponding_time_rows,behav_data_cols);
        
    case 'continuous'
        %% for continuous behavior
        behavior_data_aligned = interp1(table2array(behav_data(:,timepoint_col)),double(table2array(behav_data(:,behav_data_cols))),tf_time_seq.tf_time');
                
        behavior_data_aligned = array2table(behavior_data_aligned,'VariableNames',behav_data.Properties.VariableNames(behav_data_cols));

%         behavior_data_aligned = interp1(table2array(behav_data(:,1)),table2array(behav_data(:,2:end)),tf_time_seq.tf_time');
        
%         behavior_data_aligned = array2table(behavior_data_aligned,'VariableNames',behav_data.Properties.VariableNames(2:end));
end


end