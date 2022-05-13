function [data_out] = Dav_squared_signal(data_in, crite, name)
%
% DAV_SQUARED_SIGNAL finds data with  a squared morphology and plots it 
% Squared morphology =  number of exact same values for adjecent data points > crite 
% User decided to keep or remove the data through visual inspection 
 
% --Input:    data        = 1xN array (N = time points) 
%             crite       = # of frames to define squared morphology (25 frames = 1 sec)
%
%-- Output:  data_out 
%                reject  -->   data_out = nan(1xlength(data)) 
%                kept    -->   data_out = data_in


% IMPORTANT : Signal does not show a squared morphology anymore after using interp1 for nan interpolation 
% Therefore this is script is superfluous

deriv  =  [true, diff(data_in) ~= 0, true];   % TRUE if values change from frame to other

deriv  = diff(find(deriv));                % Number of repetitions of changing value 

deriv  = repelem(deriv,deriv);       % Returns a vector of repeated elements of x_change_n


 if  isempty( find( deriv>=crite ))==  0     %if repeated elements are above crite 
     
     %Plotting
    fig = figure(1); 
    time = linspace(1, 120, length(data_in)); 
    plot(time, data_in);      ylim([0 , 1]);
    tlt = title(['SQUARED    :   ' name]);      tlt.Interpreter = 'none';  tlt.FontSize=16;
    
    
    % Decide to Keep or Delete
     question = listdlg('PromptString', 'Keep Data or Delete Data',...
            'SelectionMode', 'multiple', 'ListString', {'Keep', 'Delete'});  

        if     question  == 1     %Keep, 

            data_out = data_in;

        elseif  question  == 2    %Delete 

            data_out = nan(1 , length(data_in)); 
        else 
            error('Select a valid input : Keep or Delete')
        end
        
        clf(fig)
        
 else
     data_out = data_in;
   
end

