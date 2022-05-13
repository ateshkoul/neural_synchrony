function ft_data = IBS_update_dimord(ft_data,dimord)
%% Atesh Koul
% function to update dimord for letswave saving
if nargin <2
   dimord = 'chan_freq'; 
end
ft_data.dimord = dimord;

end