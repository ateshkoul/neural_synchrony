function output_mat = select_index_from_array(test_matrix,index_matrix)
%SELECT_INDEX_FROM_ARRAY 
%
% SYNOPSIS: output_mat = select_index_from_array(test_matrix,index_matrix)
%
% INPUT test_matrix main array from which elements to select
%		index_matrix matrix with indicies to choose (based on some criteria)  
%
% OUTPUT output_mat output matrix
%
% REMARKS
%
% created with MATLAB ver.: 9.8.0.1359463 (R2020a) Update 1 on Microsoft Windows 10 Pro Version 10.0 (Build 19042)
%
% created by: Atesh
% DATE: 05-May-2022
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[rows,cols] = size(index_matrix);
output_mat = nan(rows,cols);
for i = 1:rows
    for j = 1:cols
        index_ = index_matrix(i,j);
        output_mat(i,j) = test_matrix(i,j,index_);       
        
    end
end
end