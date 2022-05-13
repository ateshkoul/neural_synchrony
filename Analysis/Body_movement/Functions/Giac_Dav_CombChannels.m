function [ data_out ] = Giac_Dav_CombChannels( data, channels, z_norm, method, new_label )
%
% GIAC_DAV_COMBCHANNELS calculates the mean or sum of specified nodes (i.e.
% channels) and gives out a single data point (i.e. new_label). 
 
%  Input = 
%         DATA struct 
%         channels  =  body_parts (i.e. nodes) of interest (e.g. Nose, Ears, Eyes)
%         z_norm    = 
%                   'yes_z' -- > normalize time series into z scores  
%                   'no_z'  --> time series kept raw
%
%         method    = 
%                   'sum'   --> sum of all the nodes into single new body part
%                   'mean'  --> mean of all the nodes into single new body part

%         new_label =  new_body_part OI (e.g. HEAD)
% 
% Output = new DATA struct for new_label (sum or mean of input channels) 
%          # of rows = # of new body parts 

%% Davide Ahmar & Giacomo Novembre

cfg           = [];  
cfg.channel   = channels;


data_chOI     = ft_selectdata(cfg, data);   %only takes chOI from DATA.trial


data_chOI = rmfield( data_chOI , 'label' ); %removes previous label (body_parts)
data_chOI.label{1} = new_label;             %adds new label (new_body_parts)


for tr = 1 : length(data_chOI.trial)

    if strcmp(z_norm,'yes_z')==1
    tmp    = data_chOI.trial{tr};
    tmp_z  = normalize(tmp, 2, 'zscore');  % normalizes across 2 dim into z scores; 
 
    elseif strcmp(z_norm,'no_z')==1
    tmp_z = data_chOI.trial{tr};
    end
    
        switch method
        
            case 'sum'
            data_chOI.trial{tr} = nansum(tmp_z,1);  %if all nans --> nansum = 0; 
         
            case 'mean'
            data_chOI.trial{tr} = nanmean(tmp_z,1);
        end
        
end
    
data_out = data_chOI;

end

