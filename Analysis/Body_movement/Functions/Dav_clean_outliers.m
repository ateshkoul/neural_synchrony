function [data_out, outlier, rejected] = Dav_clean_outliers(data_in, grand_avg, grand_std, nstd, name)
%
% DAV_CLEAN_OUTLIERS compares the std of single time series against its grand_avg and grand_std. 
% 
% If std(data) outside the range (i.e. outliers), functions PLOTS THE DATA and asks for user input 
% to reject (nan) or keep it. 
% 
% User should always confront the videos when deciding on the Outlier data. However, some criteria seems to hold true : 
% Criteria for rejection : 
%     data presents high frequency fluctuations typical of noisy trials. 
%     data baseline is consistenly higher than 0.5 
%     data does not present any "peaks" 
%     data present sudden changes in baseline 

% Criteria for keeping : 
%     data presents a constant flat baseline around the 0 
%     data shows occasional peaks of around 1/2 Hertz (i.e. 2 secs) which represent genuine biological movement
%
% --Input:    data        = 1xN array (N = time points) 
%             grand_avg   = calculated from DAV_AVERAGES
%             grand_std   = calculated from DAV_AVERAGES
%             nstd        = n of std away from the mean (crite) 
%
%-- Output:  data_out 
%                reject  -->   data_out = nan(1xlength(data)) 
%                kept    -->   data_out = data_in


std_data  = std(data_in); 

upper_lim = grand_avg + (grand_std .* nstd); 

lower_lim = grand_avg - (grand_std .* nstd);


compare = (std_data < lower_lim | std_data > upper_lim);


if      double(compare) < 1  %keep data 
    
       data_out = data_in; 
       
       outlier  = 0; 
       rejected = 0; 
  
       
elseif   double(compare) >= 1  %outlier data
    
        outlier = 1; 
    
    %Plotting data 
     fig = figure(1); 
     time = linspace(1, 120, length(data_in)); 
     plot(time, data_in);  ylim([-2 , 5]);
     tlt = title(['OUTLIER    :   ' name]);  tlt.Interpreter = 'none'; tlt.FontSize=16;
     pause   % press key to skip forward 
     
     
     %% Decide to Keep or Delete
     question = listdlg('PromptString', 'Keep Data or Delete Data',...
                'SelectionMode', 'multiple', 'ListString', {'Keep', 'Delete'});  
            
        if     question  == 1     %Keep, 
            
            data_out = data_in;
            
            rejected = 0;
            
        elseif  question  == 2    %Delete 
            
            data_out = nan(1 , length(data_in)); 
            
            rejected = 1; 
            
        else 
            error('Select a valid input : Keep or Delete')
        end
        
        clf(fig)
        
end
end
        
            
         
 
    


