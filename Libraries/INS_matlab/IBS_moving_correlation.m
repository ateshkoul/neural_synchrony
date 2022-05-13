function moving_correlation = IBS_moving_correlation(mat3d_1,mat3d_2,freq_bands,windowSize_cols,moving_cor_type)
% mat3d_1    chan x freq x time
if nargin <5
    moving_cor_type = 'centered' ;
end
nChan = size(mat3d_1,1);

% freq_bands = [30:55];



switch(moving_cor_type)
    case 'prev'
        mat3d_1 = padarray(mat3d_1,[0 0 windowSize_cols],NaN);
        mat3d_2 = padarray(mat3d_2,[0 0 windowSize_cols],NaN);
        parfor chan = 1:nChan
            
            [N,M] = size(squeeze(mat3d_1(chan,:,:)));
            for t = windowSize_cols+1:(M-windowSize_cols)
                p = squeeze(mat3d_1(chan,:,t-windowSize_cols:t));
                q = squeeze(mat3d_2(chan,:,t-windowSize_cols:t));
                C = nancorrmat(squeeze(mat3d_1(chan,:,t-windowSize_cols:t)),squeeze(mat3d_2(chan,:,t-windowSize_cols:t)),freq_bands)
                %     C = arrayfun(@(x) nancorr(squeeze(k1(chan,x,t-windowSize_cols:t)),squeeze(k2(chan,x,t-windowSize_cols:t))),freq_band);
                moving_correlation{chan}(t-windowSize_cols,:) = C;
                
            end
            
        end
    case 'centered'
        mat3d_1 = padarray(mat3d_1,[0 0 windowSize_cols/2],NaN);% 1 10 100
        mat3d_2 = padarray(mat3d_2,[0 0 windowSize_cols/2],NaN);
        

        parfor chan = 1:nChan
            
            [N,M] = size(squeeze(mat3d_1(chan,:,:)));
%             for t = (windowSize_cols/2)+1:(M-(windowSize_cols/2))

            for t = 1:(M-windowSize_cols)
%                 p = squeeze(mat3d_1(chan,:,t:t+windowSize_cols-1));
%                 q = squeeze(mat3d_2(chan,:,t-windowSize_cols/2:t+windowSize_cols/2));
                C = nancorrmat(squeeze(mat3d_1(chan,:,t:t+windowSize_cols-1)),squeeze(mat3d_2(chan,:,t:t+windowSize_cols-1)),freq_bands);
                %     C = arrayfun(@(x) nancorr(squeeze(k1(chan,x,t-windowSize_cols:t)),squeeze(k2(chan,x,t-windowSize_cols:t))),freq_band);


%                 moving_correlation{chan}(t+(windowSize_cols/2)-1,:) = p(1,:);
                % t+(windowSize_cols/2)-1 is ok because then I remove the first columns which effectively makes
                % this the central value
                % from the perspective of understanding t+(windowSize_cols/2)-1 makes sense
                % but practically just t makes sense
%                 moving_correlation{chan}(t+(windowSize_cols/2)-1,:) = C;
                moving_correlation{chan}(t,:) = C;

            end

               % this has to be in combination with moving_correlation{chan}(t+(windowSize_cols/2)-1,:) = C;
               % however the parallel loop doesn't work with this.
%                moving_correlation{chan} = moving_correlation{chan}((windowSize_cols/2):end,:);

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







