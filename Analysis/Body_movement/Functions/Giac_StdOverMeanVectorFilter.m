function [ indices ] = Giac_StdOverMeanVectorFilter( vector, n_std )
%
% Basic function. Input is vector. Mean and std are computed. Elements
% within vector being N (='n_std') standard deviations away from the mean are
% outpputed. 
%
%% Giacomo Novembre

m  = nanmean(vector);
st = nanstd(vector);
ul = m + (st * n_std);
ll = m - (st * n_std);

out_h = find(vector>ul);
out_l = find(vector<ll);

indices = [sort([out_h, out_l])];

end

