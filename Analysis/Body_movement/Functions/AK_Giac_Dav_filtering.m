% function [ xy ] = AK_Giac_Dav_filtering( x, y, samp_rate, smoothing_time, n_std,sample_points)
function [ xy,zero_xy_frac,Out_xy_frac] = AK_Giac_Dav_filtering( x, y, samp_rate, smoothing_time, n_std)

%
% Input = x and y (position of markers). Unprocessed landmark data
% samp_rate = no of frames per sec (avg 25)
% smoothing_time = no of secs for moving mean function
% n_std = no of std for removing outliers 
% 
% Output = diff(xy) filtered according to: 
%
% 1) Remove zeros and subsitute with nan 
% 2) Remove outliers and subsitute with nan
%       function : Giac_StdOverMeanVectorFilter
% 3) Interpolate nans (interp1)
%       function : Dav_interp_nans. 
%                   If data contains more than 1/3 of nan values data_out automatically all nans (removed)
% 4) Smooth signal using movingmean 
% 5) Combine x and y using Pythagora 
% 6) Compute 1st derivative of xy (refererence to 0)  
% 7) Smooth 1st derivative using movingmean
%
%% Giacomo e Davide

%% Filt_ 1 : Remove zeros
filt_1_x                = x;    %keeps both old and new variable 
filt_1_x(filt_1_x==0)   = nan;
filt_1_y                = y;
filt_1_y(filt_1_y==0)   = nan; 

zero_x = sum(x==0);
zero_y = sum(y==0);
zero_xy_frac = nansum([zero_x zero_y])/(length(x)*2);





%% Filt_2 : Remove outliers (filter too high or low data points)
filt_2_x                = filt_1_x;
[ indices ]             = Giac_StdOverMeanVectorFilter( filt_2_x', n_std );   %3 std away from m 
filt_2_x(indices)       = nan;

Out_x = length(indices);

filt_2_y                = filt_1_y;
[ indices ]             = Giac_StdOverMeanVectorFilter( filt_2_y', n_std );
filt_2_y(indices)       = nan;     

Out_y = length(indices);

Out_xy_frac = nansum([Out_x Out_y])/(length(filt_1_x)*2);

xy = nan;

% %% Filt_3: Interpolate nans (using Dav_interp_nans function) 
% 
% filt_3_x                     = Dav_interp_nans(filt_2_x); 
% filt_3_y                     = Dav_interp_nans(filt_2_y); 
% % 
% % filt_3_x                     = AK_Dav_interp_nans(filt_2_x,sample_points); 
% % filt_3_y                     = AK_Dav_interp_nans(filt_2_y,sample_points); 
% 
% 
% 
% %% Filt_4 Smooth the signal using moving mean fucntion 
% filt_4_x    = filt_3_x; 
% filt_4_x    = movingmean(filt_3_x, samp_rate * smoothing_time, 1, []);   %1=function operates along the first dimension of the data, i.e. column)
% 
% % filt_4_x    = smoothdata(filt_3_x,'movmean',smoothing_time,'SamplePoints',sample_points);   %1=function operates along the first dimension of the data, i.e. column)
% filt_4_y    = filt_3_y; 
% filt_4_y    = movingmean(filt_3_y, samp_rate * smoothing_time, 1, []);
% % filt_4_y    = smoothdata(filt_3_y,'movmean',smoothing_time,'SamplePoints',sample_points);
% 
% %% Compute Pythagora
% filt_4_xy = sqrt(filt_4_x.^2 + filt_4_y.^2);
% 
% %% Use first derivative (abs) to quantify movement (and reference to 0)
% filt_4_xy_diff       = diff(filt_4_xy);    %using abs derivate for movement
% filt_4_xy_diff_abs   = abs(filt_4_xy_diff);
% 
% %% Moving Mean on 1st derivative 
% xy                   =  movingmean(filt_4_xy_diff_abs,samp_rate*smoothing_time,1,[]);
% 


                         
end

