function [output] = IBS_estimate_corresp_auto_smile_manual_label(Dyad_no,Sub_no,condition,output,raw_data_dir)
%IBS_ESTIMATE_CORRESP_AUTO_SMILE_MANUAL_LABEL
%
% SYNOPSIS: IBS_estimate_corresp_auto_smile_manual_label
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
% DATE: 18-Mar-2021
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin <5
    raw_data_dir = 'D:\\iannettilab_dropbox\\Dropbox\\Koul_Atesh\\IBS\\';
end
% Dyad_no = 1;
% condition = 'FaNoOcc_1';
% Sub_no = 0;
sub = table();
sub.behav_analysis = 'joint_XOR';
% sub.analysis_sub_type = '_insta_corr_avg_freqwise';
sub.analysis_sub_type = '_insta_abs_detrend';

subs = [0,1];
video_sub = setdiff(subs,Sub_no);
% video_sub = Sub_no;
auto_smile = IBS_get_sub_behavior_data('Smile_auto',Dyad_no,video_sub,condition,raw_data_dir,sub);
smile_algo = auto_smile.Properties.VariableNames{contains(auto_smile.Properties.VariableNames,'mouth_size')};
% smile_algo = ['smile_pca_' num2str(Sub_no)];
% smile_algo = ['smile_' num2str(Sub_no)];
mapObj = containers.Map({0,1},{1,2});

video_manual_smile = table2array(IBS_get_sub_behavior_data('Video_manual_labelled',Dyad_no,Sub_no,condition,raw_data_dir,sub));

corresp_frames = IBS_eye_tracker_load_corresp_frames(Dyad_no,condition,raw_data_dir);
if Sub_no==0
    % for the old case where the video sub wasn't corrected
%         corresp_rows = ismember(1:length(auto_smile.mouth_size_0), corresp_frames+1);
    corresp_rows = ismember(1:length(auto_smile.mouth_size_1), corresp_frames+1);
    
    auto_smile_values = auto_smile.(smile_algo)(corresp_rows);
    % auto_smile_values = table2array(auto_smile(corresp_frames+1,3));
    
else
    auto_smile_values = auto_smile.(smile_algo);
end
try
    accuracy = nansum(auto_smile_values == video_manual_smile(:,2))/length(video_manual_smile(:,2));
    
    auto_smile_correct = auto_smile_values == 1;
    if sum(auto_smile_correct) >0 %&& sum(video_manual_smile(:,2)) >0
        accuracy_smile = nansum(video_manual_smile(auto_smile_correct,2))/length(video_manual_smile(auto_smile_correct,2));
    else
        accuracy_smile = nan;
    end
    
    video_smile_correct = video_manual_smile(:,2) == 1;
    accuracy_video = nansum(auto_smile_values(video_smile_correct,1))/length(auto_smile_values(video_smile_correct,1));
    
    all_accuracy = auto_smile_values == video_manual_smile(:,2);
    accuracy_0 = nansum(all_accuracy(video_manual_smile(:,2)==0))/length(all_accuracy(video_manual_smile(:,2)==0));
    accuracy_1 = nansum(all_accuracy(video_manual_smile(:,2)==1))/length(all_accuracy(video_manual_smile(:,2)==1));
    balanced_accuracy = nanmean([accuracy_0 accuracy_1]);
    
    %        kappa_comp = [sum(auto_smile_values) length(auto_smile_values)-sum(auto_smile_values);sum(video_manual_smile(:,2)) length(video_manual_smile(:,2))-sum(video_manual_smile(:,2))];
    % p = kappa(kappa_comp);
    [k,p] = kappa(confusionmat(1*auto_smile_values,video_manual_smile(:,2)));
    
catch
    
    % sum(video_manual_smile(:,2))
    % sum(auto_smile_values)
    
    
    
    accuracy = nansum(auto_smile_values(1:end-1) == video_manual_smile(:,2))/length(video_manual_smile(:,2));
    auto_smile_correct = auto_smile_values(1:end-1) == 1;
    if sum(auto_smile_correct) >0 %&& sum(video_manual_smile(:,2)) >0
        accuracy_smile = nansum(video_manual_smile(auto_smile_correct,2))/length(video_manual_smile(auto_smile_correct,2));
    else
        accuracy_smile = nan;
    end
    
    
    video_smile_correct = video_manual_smile(:,2) == 1;
    
    auto_smile_values = auto_smile_values(1:end-1);
    accuracy_video = nansum(auto_smile_values(video_smile_correct,1))/length(auto_smile_values(video_smile_correct,1));
    
    
    all_accuracy = auto_smile_values == video_manual_smile(:,2);
    accuracy_0 = nansum(all_accuracy(video_manual_smile(:,2)==0))/length(all_accuracy(video_manual_smile(:,2)==0));
    accuracy_1 = nansum(all_accuracy(video_manual_smile(:,2)==1))/length(all_accuracy(video_manual_smile(:,2)==1));
    
    
    
    
    balanced_accuracy = nanmean([accuracy_0 accuracy_1]);
    %        kappa_comp = [sum(auto_smile_values) length(auto_smile_values)-sum(auto_smile_values);sum(video_manual_smile(:,2)) length(video_manual_smile(:,2))-sum(video_manual_smile(:,2))];
    [k,p] = kappa(confusionmat(1*auto_smile_values,video_manual_smile(:,2)));
    
end
all_acc = nansum(all_accuracy)/length(all_accuracy);

switch(output)
    case 'all_acc'
        output=all_acc;
    case 'balanced_acc'
        output=balanced_accuracy;
        
    case 'accuracy_0'
        output=acuracy_0;
        
    case 'acuracy_1'
        output=acuracy_1;
        
    case 'kappa'
        output=k;
        
end
end
%plot(auto_smile_values);hold on;plot(video_manual_smile(:,2))


% auto_smile = IBS_get_sub_behavior_data('Smile_auto',Dyad_no,Sub_no,condition,raw_data_dir);
%
% video_manual_smile = table2array(IBS_get_sub_behavior_data('Video_manual_labelled',Dyad_no,Sub_no,condition,raw_data_dir));
%
% corresp_frames = IBS_eye_tracker_load_corresp_frames(Dyad_no,condition,raw_data_dir);
% if Sub_no==0
%
%     corresp_rows = ismember(table2array(auto_smile(:,2)), corresp_frames+1);
%     auto_smile_values = table2array(auto_smile(corresp_rows,3));
%     % auto_smile_values = table2array(auto_smile(corresp_frames+1,3));
%
% else
%     auto_smile_values = table2array(auto_smile(:,3));
% end
% try
%     accuracy = nansum(auto_smile_values == video_manual_smile(:,2))/length(video_manual_smile(:,2));
%
%     auto_smile_correct = auto_smile_values == 1;
%     accuracy_smile = nansum(video_manual_smile(auto_smile_correct,2))/length(video_manual_smile(auto_smile_correct,2));
%
%
%     video_smile_correct = video_manual_smile(:,2) == 1;
%     accuracy_video = nansum(auto_smile_values(video_smile_correct,1))/length(auto_smile_values(video_smile_correct,1));
%
%
%
% catch
%
%     % sum(video_manual_smile(:,2))
%     % sum(auto_smile_values)
%
%
%
%     accuracy = nansum(auto_smile_values(1:end-1) == video_manual_smile(:,2))/length(video_manual_smile(:,2));
%     auto_smile_correct = auto_smile_values(1:end-1) == 1;
%     accuracy_smile = nansum(video_manual_smile(auto_smile_correct,2))/length(video_manual_smile(auto_smile_correct,2));
%
%     video_smile_correct = video_manual_smile(:,2) == 1;
%
%     auto_smile_values = auto_smile_values(1:end-1);
%     accuracy_video = nansum(auto_smile_values(video_smile_correct,1))/length(auto_smile_values(video_smile_correct,1));
%
%
% end