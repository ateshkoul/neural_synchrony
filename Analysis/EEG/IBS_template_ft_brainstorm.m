function template_ft = IBS_template_ft_brainstorm(data)
% convert all data cols of input data into single time fieldtrip structs

load('IBS_template_ft_brainstorm.mat')
for data_col = 1:size(data,2)
template_ft.trial{1,data_col} = data(:,data_col);
template_ft.time{1,data_col} = 1;
end
end