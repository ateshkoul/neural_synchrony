function name = cell_2_name(data_name_cell)
% data_name_cell has to be a cell

combined_name = strjoin(cellfun(@(x) [replace(replace_mul_with_one_space(num2str(x)),' ','-') '_'],data_name_cell,'UniformOutput',false));
name = combined_name(~isspace(combined_name));

end


