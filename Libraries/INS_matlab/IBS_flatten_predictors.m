function dyad_data_aligned = IBS_flatten_predictors(dyad_cell_data)

behavior_data_aligned = cellfun(@(x,varargin) [x varargin{:}], dyad_cell_data{:},'UniformOutput',false);
empty_dyads = find(cell2mat(cellfun(@(x) isempty(x),behavior_data_aligned,'UniformOutput',false)));
behavior_data_aligned(empty_dyads) = [];

dyad_data_aligned = cat(1,behavior_data_aligned{:});

end


