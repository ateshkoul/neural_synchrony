function cur_data_numeric = IBS_clean_video_landmark_data(data_numeric,test_values)
%% Atesh Koul
% data_numeric : (table) data with movement data 

if nargin < 2
   test_values = 0;
end

S = vartype('numeric');
cur_data_numeric = data_numeric(:,S);
data_var_names = cur_data_numeric.Properties.VariableNames;


for test_value_no = 1:length(test_values)
    cur_test_value = test_values(test_value_no);
    cur_data_numeric = IBS_replace_table_test_value(cur_data_numeric,cur_test_value);
end


%% outlier value removal
outlier_value = 3;



cur_data_numeric = table2array(cur_data_numeric);


scaled_values = zscore(cur_data_numeric);

cur_data_numeric(find(scaled_values< -outlier_value | scaled_values>outlier_value)) = NaN;


cur_data_numeric = IBS_smoothdata(cur_data_numeric);
cur_data_numeric = array2table(cur_data_numeric,'VariableNames',data_var_names);

%% wrong values removed part due to multiple subject detection

cur_data_numeric = IBS_video_landmarks_remove_mislabeled(cur_data_numeric);



end




function numeric_table = IBS_replace_table_test_value(numeric_table,test_value)
% S = vartype('numeric');
% data_numeric = data(:,S);

data_numeric_array = table2array(numeric_table(:,1:end-1));
data_numeric_array(find(data_numeric_array==test_value)) = NaN;


data_numeric_array(:,end+1) = table2array(numeric_table(:,end));
numeric_table = array2table(data_numeric_array,'VariableNames',numeric_table.Properties.VariableNames);

end