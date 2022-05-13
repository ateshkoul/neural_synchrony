function [mat_corr] = nancorrmat(mat1,mat2,corr_rows)
% this function generalizes over nancorr that performs correlation over nan
% values for matrices
% important to consider that it works on the rows and not the columns of
% the matricies
% nancorr and corr give the same result for vectors in case there are no nans

% x = rand(10);y = rand(10);
% sum(corr(x(:,1),y(:,1))-nancorr(x(:,1),y(:,1)))


%% tests:
% tested using the IBS_test_moving_correlation function
%% 
if nargin<3
    corr_rows = 1:size(mat1,1);
end
    mat_corr = arrayfun(@(x) nancorr(mat1(x,:),mat2(x,:)),corr_rows);

end