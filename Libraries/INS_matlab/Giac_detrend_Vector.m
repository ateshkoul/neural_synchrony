function [ vector_out, trend_coef ] = Giac_detrend_Vector( vector_in )
%
% This function detrends single vectors (input: 'vector_in' - 1xN vector). 
% It outputs the detrended vector ('vector_out') as well as the actual slope 'trend_coef'.
%
%% Giacomo Novembre

x           = 1:length(vector_in);
y           = vector_in;
p           = polyfit(x,y,1);
trend       = (p(1)*x+p(2));
vector_out  = vector_in - trend;
trend_coef  = p(1);

end

