%% Dav_Step_1_Prep 
%
% Automatic preprocessing of raw OpenPose data. 
%
% For each subject, scripts loads invidual data files, cleans x and y time-series and  calculates the x-y 1st derivative. 
% Data is saved in a FieldTrip-like format : 1 DATA struct for each subject containing all data for all conditions. 
%
% Data Input : Unprocessed Data. 
%              23 Dyads. 
%              2 Subjects.  
%              15 files each sub (30 each dyad)
%              5 Condition = FaNoOcc, FaOcc, NeNoOcc, NeOcc, Task
%              3 Repetition = 1 2 3 (each condition)
%              25 body parts --> 50 x and y data points 
%
% Analysis  : GIAC_DAV_FILTERTING function
%
% Data Output  : DATA struct. 
%
%
% Missing Data files : NAN.  
%   --> For missing Data files scipts creates a nan time-series of length = samp_rate * 120 (secs)  
%
%% Davide Ahmar

clear; close all; clc;  
%Adding paths for relevant Giacomo and fieldtrip codes
% addpath(genpath('C:\Users\ahmar\OneDrive\Documents\IBS\Libraries\IBS_libraries\Giac_toolbox'));
% addpath('C:\Users\ahmar\OneDrive\Documents\IBS\Libraries\fieldtrip-20201214'); 
% ft_defaults;
addpath('C:\Users\ahmar\OneDrive\Documents\IBS\Behaviour\Video_landmark\Codes\Giacomo\Functions');
addpath('C:\Users\ahmar\OneDrive\Documents\IBS\Behaviour\Video_landmark\Codes\Functions');


addpath('Y:\Inter-brain synchrony\Analysis\IMS_Davide\Functions')

%% Parameters 
dyads      =  1 : 23;   %specify dyads of interest

parent_directory = 'C:\Users\ahmar\OneDrive\Documents\IBS\Behaviour\Video_landmark\Data\';

save_directory   =  'Giacomo\1_Preprocessed';

%%
parent_directory = 'E:\Davide_shared\IBS\';

%%

dist_x_y   =  25; % 50 body parts (25x and 25y)
samp_rate  =  25; % avg frames per sec 

body_label =  {'Nose','Neck','RShoulder','RElbow','RWrist','LShoulder','LElbow','LWrist','MidHip',...    % only name of body parts
              'RHip','RKnee','RAnkle','LHip','LKnee','LAnkle','REye','LEye','REar','LEar','LBigToe',...
              'LSmallToe','LHeel','RBigToe','RSmallToe','RHeel'};

conditions =  {'FaNoOcc','FaOcc','NeNoOcc','NeOcc','Task'};
repet      =  3;



%% 
for dyad_loop = 1 : length(dyads)
     
dyad = dyads(dyad_loop)


for subject = 0  : 1

%% Here you make a data structure compatible with FieldTrip
n_trials     = length(conditions) * repet;  % 5 conditions * 3 repetitions
DATA         = struct;
DATA.trial   = cell(1,n_trials);
DATA.label   = body_label';
DATA.time    = cell(1,n_trials);
DATA.fsample = samp_rate;

tr = 1; % this is a counter 


for cond = 1 : length(conditions)

for rep  = 1 : repet
 
   try    
% load([parent_directory 'Dyad_' num2str(dyad) '\Unprocessed\results_video_'...
%       num2str(subject) '_' conditions{cond} '_' num2str(rep) '_pose_body_unprocessed'])
  
  load([parent_directory 'Dyd_' sprintf('%0.3d',dyad) '\Video\Ses_001\results_video_'...
      num2str(subject) '_' conditions{cond} '_' num2str(rep) '_pose_body_unprocessed'])
  
  
  
    %For missing files 
   catch
        DATA.trial{tr}(:, :)      =   nan(length(body_label), samp_rate * 120); 
        DATA.time{tr}(:, :)        =  linspace(samp_rate/120, 120, samp_rate * 120);
        tr = tr +1; 
        continue  % Goes back to try; 
    end

  % sanity check
if data_table.Dyd_no(1) ~= dyad    ||  data_table.Sub_no(1)~= subject ||...
   data_table.Condition(1) ~= conditions{cond}
   error(['Sanity Check: ' 'Dyad_' num2str(dyad) '\Unprocessed\results_video_'...
       num2str(subject) '_' conditions{cond} '_' num2str(rep)]);
end 

mat_oi              = data; clear data_table data_colnames
mat_oi(:,end-1:end) = [];   %last 2 cols contain dyad and subject number. Removed


    for body_part = 1 : size(mat_oi,2)/2

        x = mat_oi(:, body_part);
        y = mat_oi(:, body_part + dist_x_y);

        % Calling GIAC_DAV_FILTERING Function
        [ xy ] = Giac_Dav_filtering( x, y, samp_rate, 1, 3);
        %[ xy ] = temp_Plot_Giac_Dav_filtering( x, y, samp_rate, 1, 3); % %same as Giac_Dav_filtering but it plots every steps for visual inspection 

        sprintf(['Subject', num2str(subject), ' ', body_label{body_part}])
        
        %Input back into DATA struct
        DATA.trial{tr}(body_part, :) = xy;   %every row is a body_part (25) 
        time_tmp                  =  linspace(0, 120, size(mat_oi, 1));
        time_tmp(1)               =  [];  %because diff(xy) has 1 less value
        DATA.time{tr}(1,:)        =  time_tmp;
  
    end
    tr = tr + 1;
 end
 end

% Saving 
cd([parent_directory, save_directory]);
save(['Dyad_' num2str(dyad) '_subject_' num2str(subject)], 'DATA'); 

end % end subject loop
end % end dyad loop
