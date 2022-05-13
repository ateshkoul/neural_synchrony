function [data_sub_cond] = IBS_load_video_landmarks_manual_cleaned_abs(Dyad_no,Sub_no,condition,raw_data_dir,labels)
%IBS_LOAD_VIDEO_LANDMARKS_MANUAL_CLEANED load openpose landmarks cleaned
%
% SYNOPSIS: IBS_load_video_landmarks_manual_cleaned_abs
%
% INPUT
%
% OUTPUT
%
% REMARKS
%
% created with MATLAB ver.: 9.8.0.1359463 (R2020a) Update 1 on Microsoft Windows 10 Pro Version 10.0 (Build 19042)
%
% created by: Atesh
% DATE: 19-Apr-2021
%
% One minor inconvenient is that for the Cleaned Data folder, starting from Dyad_12 until Dyad_23,
% S0 and S1 are inverted (S0 = moving), while in the Grouped Data folder S0 and S1 are “normal”
% (S0 = stationary) for all Dyads.  Hope that doesn’t cause problems.
% {'Nose','Neck','RShoulder','RElbow','RWrist','LShoulder','LElbow','LWrist','MidHip','RHip',
% 'RKnee','RAnkle','LHip','LKnee','LAnkle','REye','LEye','REar','LEar','LBigToe','LSmallToe',
% 'LHeel','RBigToe','RSmallToe','RHeel'}

% 10-02-2022: Atesh
% works also for hands just have to change the folder to that of hands

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin <4
    labels = 'ALL';
    raw_data_dir = 'Y:\\Inter-brain synchrony\\Results\\Video\\2_Cleaned\\';

end


if nargin <5
    
%     labels = {'LAnkle','LBigToe','LSmallToe','LHeel','RAnkle','RBigToe','RSmallToe', 'RHeel','LKnee','RKnee'};
    labels = 'ALL';
end

mapObj = containers.Map({'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3', ...
    'FaOcc_1','FaOcc_2','FaOcc_3', ...
    'NeNoOcc_1','NeNoOcc_2','NeNoOcc_3', ...
    'NeOcc_1','NeOcc_2','NeOcc_3', ...
    'Task_1','Task_2','Task_3'},1:15);



data = load([raw_data_dir sprintf('Dyad_%0.1d',Dyad_no)]);

% this takes care of the issue with the inverting of the data- this is
% present only in the cleaned data (all labels) that Davide cleaned with
% Giacomo. The origin I think comes from the switch of the camera.

% important to note that the switch after dyad no 11 has not been
% corrected in the 'cleaned' folder but only in the 'grouped'
% folder (see davide script Dav_Step_3_Grouping_Body_Hands line
% 131)
if Dyad_no>11
    subMapObj = containers.Map({1,0},{0,1});
    Sub_no = subMapObj(Sub_no);
    
end

all_fields = fieldnames(data);
field_0_name = all_fields{contains(fieldnames(data),'0')};
field_1_name = all_fields{contains(fieldnames(data),'1')};

switch(Sub_no)
    
    case 0
        if strcmp(labels,'ALL')
%             labels =  data.DATA_sub0.label;
            labels =  data.(field_0_name).label;

        end
        %         label_row = strcmp(data.DATA_sub1.label  ,labels);
        % for multiple body parts
%         label_row = contains(data.DATA_sub0.label  ,labels);
%         data_sub_cond = data.DATA_sub0.trial{1,mapObj(condition)}(label_row,:);

        label_row = contains(data.(field_0_name).label  ,labels);

        data_sub_cond = data.(field_0_name).trial{1,mapObj(condition)}(label_row,:);
        
        % normalize over the rows : giacomo and davide suggested this over
        % just a mean over velocity values
        if(sum(label_row)<2)
            data_sub_cond = data_sub_cond';
        else
            % here 2 is ok for normalising because the data are arranged in
            % rows
            data_sub_cond = nanmean(normalize(data_sub_cond,2,'zscore'))';
        end
        % abs or mean +- std
        %         data_sub_cond = nanmean(abs(data_sub_cond))';
        
        data_sub_cond = table(data_sub_cond,'VariableNames',{'ALL'});
    case 1
        
        if strcmp(labels,'ALL')
%             labels =  data.DATA_sub1.label;
            labels =  data.(field_1_name).label;

        end
        %         label_row = strcmp(data.DATA_sub1.label  ,labels);
        % for multiple body parts
%         label_row = contains(data.DATA_sub1.label  ,labels);
%         
%         data_sub_cond = data.DATA_sub1.trial{1,mapObj(condition)}(label_row,:);

        label_row = contains(data.(field_1_name).label  ,labels);
        
        data_sub_cond = data.(field_1_name).trial{1,mapObj(condition)}(label_row,:);        
        
        
        %         data_sub_cond = nanmean(abs(data_sub_cond))';
        %         data_sub_cond = nanmean(normalize(data_sub_cond,2,'zscore'))';
        if(sum(label_row)<2)
            data_sub_cond = data_sub_cond';
        else
            data_sub_cond = nanmean(normalize(data_sub_cond,2,'zscore'))';
        end
        data_sub_cond = table(data_sub_cond,'VariableNames',{'ALL'});
end






end