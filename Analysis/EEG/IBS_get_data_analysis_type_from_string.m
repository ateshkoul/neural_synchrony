function cur_data_analysis_type = IBS_get_data_analysis_type_from_string(string)

data_analysis_types = {'no_aggressive_trialwise_CAR','aggressive_trialwise_CAR','no_aggressive_CAR_ASR_5_ICA_appended_trials','no_aggressive_CAR_ASR_10_ICA_appended_trials'};





cur_data_analysis_no = cellfun(@(x) contains(string,x),data_analysis_types,'UniformOutput',false);
cur_data_analysis_type = data_analysis_types(cell2mat(cur_data_analysis_no));


try
    if strcmp(cur_data_analysis_type{1,1},'no_aggressive_trialwise_CAR')
        cur_data_analysis_no = cellfun(@(x,y) strcmp(data_analysis_types(x),y),cur_data_analysis_no,data_analysis_types,'UniformOutput',false);
        
    end
catch
    if strcmp(cur_data_analysis_type,'no_aggressive_trialwise_CAR')
        cur_data_analysis_no = cellfun(@(x,y) strcmp(data_analysis_types(x),y),cur_data_analysis_no,data_analysis_types,'UniformOutput',false);
        
    end
end
cur_data_analysis_type = data_analysis_types(cell2mat(cur_data_analysis_no));

end