function [result_cell_array] = IBS_apply_fun_arrays(cell_A,cell_B,fun,varargin)
%% Atesh
% apply an arbitrary function elementwise to two cell array elements

% 14-12-2020
%%
if nargin <3
    
    fun = @mean;
    
end
n_input_array = 2;
combined_array = cat(3,cell_A{:},cell_B{:});
combined_array = reshape(combined_array,[size(cell_A{1,1}) numel(cell_A) n_input_array]);


result_cell_array = fun(combined_array,length(size(combined_array)));
result_cell_array = squeeze(num2cell(result_cell_array,[1 2]));


end