function corr_value = compute_pairwise_measure(mat1,mat2,corr_measure)
%COMPUTE_PAIRWISE_MEASURE computes pairwise correlation measure
%
% SYNOPSIS: compute_pairwise_measure(mat1,mat2,corr_measure)
%
% INPUT
%
% OUTPUT
%
% REMARKS
%
% created with MATLAB ver.: 9.8.0.1359463 (R2020a) Update 1 on Microsoft Windows 10 Pro Version 10.0 (Build 19042)
%
% created by: Atesh
% DATE: 03-Mar-2022
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin<3
    %    corr_measure = @(x,y) kappa(confusionmat(x,y));
%     corr_measure = @jaccard;
    corr_measure = @(x,y) 1-pdist([x';y'],'hamming');
    % there is a big difference beween jaccard and pdist - 
    % jaccard looks at non-zero values only while hamming takes also '0'
    % into account. '0' in both reduces distance for hamming while jaccard
    % doesn't care about it
    % a = [1 1 0 1 0 0];b = [1 1 1 0 0 0]
    % jaccard(a,b)
    % pdist([a;b],'hamming')
end

[nrow1,ncol1] = size(mat1);
[nrow2,ncol2] = size(mat2);


assert(nrow1==nrow2 && ncol1==ncol2)
% do a preview of how it should look like. easiest way to get the 3rd
% dimension
ncol3 = length(corr_measure(mat1(:,1),mat2(:,1)));

corr_value = nan(ncol1,ncol2,ncol3);
for col1 = 1:ncol1
    for col2 = 1:ncol2
        corr_value(col1,col2,:) = corr_measure(mat1(:,col1),mat2(:,col2));
    end
end

end







