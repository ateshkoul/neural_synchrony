function [data_conditions,conditions,within_save_dir] = IBS_load_within_brain_analysis_data(analysis_type)

analysis_type_params = IBS_get_params_analysis_type(analysis_type);
within_save_dir = analysis_type_params.within_save_dir{1,1};
conditions = analysis_type_params.conditions;



data = cellfun(@(x) squeeze(load([within_save_dir 'merged_ft_script_' x '.mat']).data),conditions,'UniformOutput',false);

subset_col_mat_fun = @(x,v) x(:,:,v);
freq_values = 2:2:size(data{1,1},3);
data_subset = cellfun(@(x) subset_col_mat_fun(x,freq_values),data,'UniformOutput',false);

expand_fun = @(x) squeeze(num2cell(permute(x,[2 3 1]),[1 2]));
data_expanded = cellfun(@(x) expand_fun(x),data_subset,'UniformOutput',false);


data_conditions = cat(2,data_expanded{:});

data_conditions = arrayfun(@(x) data_conditions(x,:), 1:size(data_conditions,1), 'UniformOutput',false);
end