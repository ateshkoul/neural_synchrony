function [data_cell] = IBS_remove_empty_dyads(data_cell)
%% Atesh Koul
% 04-02-2021

empty_dyads = find(cell2mat(cellfun(@(x) isempty(x),data_cell,'UniformOutput',false)));
data_cell(empty_dyads) = [];


end