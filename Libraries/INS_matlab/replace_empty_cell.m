function cell_matrix = replace_empty_cell(cell_matrix)

log_idx = cellfun('isempty', cell_matrix);
cell_matrix(log_idx) = {NaN};
cell_matrix = cell2mat(cell_matrix);
end
