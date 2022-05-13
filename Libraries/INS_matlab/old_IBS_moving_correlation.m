function moving_correlation = IBS_moving_correlation(mat3d_1,mat3d_2,freq_bands,windowSize_cols)
%%
% this is the main function of the moving correlation
% the general idea is a correlation of 2 3d arrays across some of their
% rows

% here:
% mat3d_1, mat3d_2      : two 3d matrices [dim1,dim2,dim3]
% freq_bands            : 2nd dimension rows for which to compute the corr
% windowSize_cols       : window size in matrix col no.s to compute moving
%                         corr

% moving corr is perfomed for each dim1, for specified dim2 (freq_bands)
% over the values of dim3.

%% tests:
% overall tested using the IBS_test_moving_correlation function
% nancorrmat tested as well


%%


nChan = size(mat3d_1,1);
% freq_bands = [30:55];

% mat3d_1 = padarray(mat3d_1,[0 0 windowSize_cols],NaN);
% mat3d_2 = padarray(mat3d_2,[0 0 windowSize_cols],NaN);

mat3d_1 = padarray(mat3d_1,[0 0 windowSize_cols/2],NaN);
mat3d_2 = padarray(mat3d_2,[0 0 windowSize_cols/2],NaN);

for chan = 1:nChan

[Freqs,padded_time_points] = size(squeeze(mat3d_1(chan,:,:)));
% windowSize_cols+1 because it's padded at the begining. this way, the
% moving correlation starts at the first actual value
for t = windowSize_cols/2:(padded_time_points-windowSize_cols)
    C = nancorrmat(squeeze(mat3d_1(chan,:,t-windowSize_cols:t)),squeeze(mat3d_2(chan,:,t-windowSize_cols:t)),freq_bands);
%     C = arrayfun(@(x) nancorr(squeeze(k1(chan,x,t-windowSize_cols:t)),squeeze(k2(chan,x,t-windowSize_cols:t))),freq_band);
    moving_correlation{chan}(t-windowSize_cols,:) = C;
    
end

end


moving_correlation = permute(cat(3,moving_correlation{:}),[3 1 2]);
end
% slower by 7.5 times
% for chan = 1:nChan
% 
% [N,M] = size(squeeze(mat3d_1(chan,:,:)));
% for t = windowSize_cols+1:(M-windowSize_cols)
%     C = nancorrmat(squeeze(mat3d_1(chan,:,t-windowSize_cols:t)),squeeze(mat3d_2(chan,:,t-windowSize_cols:t)),freq_bands);
% %     C = arrayfun(@(x) nancorr(squeeze(k1(chan,x,t-windowSize_cols:t)),squeeze(k2(chan,x,t-windowSize_cols:t))),freq_band);
%     moving_correlation(chan,t-windowSize, :) = C;
%     
% end
% 
% end







