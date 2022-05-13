function behav_data = IBS_glm_clean_behav_data(behav_data)

%% remove stationary cols
initial_no_feat = size(behav_data,2);
behav_data = behav_data(:,sum(arrayfun(@isnan,table2array(behav_data)),1) ~= size(behav_data,1));
if size(behav_data,2)  ~= initial_no_feat
    removed_no_feat = initial_no_feat - size(behav_data,2);
    warning('Removing %d stationary features',removed_no_feat)
    
end



end