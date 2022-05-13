function brain_data_cluster = IBS_get_brain_stat_data(brain_data,stat_cluster,cluster_no)
cur_stat_cluster = stat_cluster{cluster_no};
brain_data = permute(brain_data,[1 3 2]);
brain_data_cluster = table(squeeze(nanmean(nanmean(brain_data.*repmat(cur_stat_cluster,1,1,size(brain_data,3))))),'VariableNames',{['chan_freq_data_' num2str(cluster_no)]});



end