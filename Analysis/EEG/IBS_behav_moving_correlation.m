function moving_correlation = IBS_behav_moving_correlation(mat_1,mat_2,windowSize_cols,joint_fun,pad_value,moving_cor_type)
if nargin <5
    pad_value = 0 ; % this is for joint and/or cases. 
end


if nargin <6
    moving_cor_type = 'centered' ;
end
nFeat = size(mat_1,2);

% freq_bands = [30:55];



switch(moving_cor_type)
%     case 'prev'
%         mat_1 = padarray(mat_1,[0 0 windowSize_cols],NaN);
%         mat_2 = padarray(mat_2,[0 0 windowSize_cols],NaN);
%         parfor chan = 1:nChan
%             
%             [N,M] = size(squeeze(mat_1(chan,:,:)));
%             for t = windowSize_cols+1:(M-windowSize_cols)
%                 p = squeeze(mat_1(chan,:,t-windowSize_cols:t));
%                 q = squeeze(mat_2(chan,:,t-windowSize_cols:t));
%                 C = nancorrmat(squeeze(mat_1(chan,:,t-windowSize_cols:t)),squeeze(mat_2(chan,:,t-windowSize_cols:t)),freq_bands)
%                 %     C = arrayfun(@(x) nancorr(squeeze(k1(chan,x,t-windowSize_cols:t)),squeeze(k2(chan,x,t-windowSize_cols:t))),freq_band);
%                 moving_correlation{chan}(t-windowSize_cols,:) = C;
%                 
%             end
%             
%         end
    case 'centered'
        mat_1 = padarray(mat_1,[windowSize_cols/2],pad_value);% 1 10 100 % there are issues with nans
        mat_2 = padarray(mat_2,[windowSize_cols/2],pad_value);
        

        for feat = 1:nFeat
            
            [N,M] = size(mat_1(:,feat));
%             for t = (windowSize_cols/2)+1:(M-(windowSize_cols/2))

            for t = 1:(N-windowSize_cols)
                moving_correlation(t,feat) = joint_fun(mat_1(t:t+windowSize_cols-1,feat),mat_2(t:t+windowSize_cols-1,feat));
                

                    
%                 p = squeeze(mat3d_1(chan,:,t:t+windowSize_cols-1));
%                 q = squeeze(mat3d_2(chan,:,t-windowSize_cols/2:t+windowSize_cols/2));
%                 C = nancorrmat(squeeze(mat_1(feat,:,t:t+windowSize_cols-1)),squeeze(mat_2(feat,:,t:t+windowSize_cols-1)),freq_bands);
                %     C = arrayfun(@(x) nancorr(squeeze(k1(chan,x,t-windowSize_cols:t)),squeeze(k2(chan,x,t-windowSize_cols:t))),freq_band);


%                 moving_correlation{chan}(t+(windowSize_cols/2)-1,:) = p(1,:);
                % t+(windowSize_cols/2)-1 is ok because then I remove the first columns which effectively makes
                % this the central value
                % from the perspective of understanding t+(windowSize_cols/2)-1 makes sense
                % but practically just t makes sense
%                 moving_correlation{chan}(t+(windowSize_cols/2)-1,:) = C;
%                 moving_correlation{feat}(t,:) = C;

            end

               % this has to be in combination with moving_correlation{chan}(t+(windowSize_cols/2)-1,:) = C;
               % however the parallel loop doesn't work with this.
%                moving_correlation{chan} = moving_correlation{chan}((windowSize_cols/2):end,:);

        end
        
        
end

% moving_correlation = permute(cat(3,moving_correlation{:}),[3 1 2]);
end