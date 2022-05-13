function [data_out] = AK_Dav_interp_nans(data_in,time_points)
%
% Function interpolates the nans time points in the data using interp1 function
%
% IMPORTANT :  If data contains more than 1/3 of nan values ---> data_out automatically all nans (removed)
%
% If first and last time points are == nan --> subsitute with mean of all time serie (interp1 doesn't work)

%% Davide Ahmar 


data = data_in;

if length(find(isnan(data))) >= length(data)./3
    data    = nan(size(data));

else
%If first or last element of data is nan --> subsitute with mean 
if isnan(data(1))
    data(1)    = nanmean(data);
end
if isnan(data(end))
    data(end)   = nanmean(data);
end 

%Interpolating any remaining nan values 
% time_points                = 1 : length(data);
query_points               = isnan(data);

data(query_points)      = interp1(time_points (~ query_points), data(~ query_points),...
                               time_points(query_points));
end

data_out = data; 

end

