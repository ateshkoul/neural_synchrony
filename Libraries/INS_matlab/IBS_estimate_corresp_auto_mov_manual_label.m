function [results] = IBS_estimate_corresp_auto_mov_manual_label(Dyad_no,Sub_no,condition,raw_data_dir)
%IBS_ESTIMATE_CORRESP_AUTO_MOV_MANUAL_LABEL
%
% SYNOPSIS: IBS_estimate_corresp_auto_mov_manual_label
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
% DATE: 05-MAY-2021
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin <4
    raw_data_dir = 'D:\\iannettilab_dropbox\\Dropbox\\Koul_Atesh\\IBS\\';
end
% Dyad_no = 1;
% condition = 'FaNoOcc_1';
% Sub_no = 0;
sub = table();
sub.behav_analysis = 'joint_XOR';
auto_mov = IBS_get_sub_behavior_data('video_openpose_landmarks_manual_cleaned',Dyad_no,Sub_no,condition,raw_data_dir,sub);
mov_algo = auto_mov.Properties.VariableNames{contains(auto_mov.Properties.VariableNames,'ALL')};
% smile_algo = ['smile_pca_' num2str(Sub_no)];
% smile_algo = ['smile_' num2str(Sub_no)];
video_manual_mov = table2array(IBS_get_sub_behavior_data('Video_manual_labelled',Dyad_no,Sub_no,condition,raw_data_dir,sub));
video_manual_mov = video_manual_mov(:,[1 3]);

corresp_frames = IBS_find_corresponding_time_points(auto_mov.timestamps,video_manual_mov(:,1));

auto_smile_values = auto_mov.(mov_algo)(corresp_frames,:);


    

try
    accuracy = nansum(auto_smile_values == video_manual_mov(:,2))/length(video_manual_mov(:,2));
    
    auto_smile_correct = auto_smile_values == 1;
    if sum(auto_smile_correct) >0 %&& sum(video_manual_smile(:,2)) >0
    accuracy_smile = nansum(video_manual_mov(auto_smile_correct,2))/length(video_manual_mov(auto_smile_correct,2));
    else
        accuracy_smile = nan;
    end
    
    video_smile_correct = video_manual_mov(:,2) == 1;
    accuracy_video = nansum(auto_smile_values(video_smile_correct,1))/length(auto_smile_values(video_smile_correct,1));
    
   all_accuracy = auto_smile_values == video_manual_mov(:,2);
   accuracy_0 = nansum(all_accuracy(video_manual_mov(:,2)==0))/length(all_accuracy(video_manual_mov(:,2)==0));
   accuracy_1 = nansum(all_accuracy(video_manual_mov(:,2)==1))/length(all_accuracy(video_manual_mov(:,2)==1));
       balanced_accuracy = nanmean([accuracy_0 accuracy_1]);
       
%        kappa_comp = [sum(auto_smile_values) length(auto_smile_values)-sum(auto_smile_values);sum(video_manual_smile(:,2)) length(video_manual_smile(:,2))-sum(video_manual_smile(:,2))];
% p = kappa(kappa_comp);
[k,p] = kappa(confusionmat(1*auto_smile_values,video_manual_mov(:,2)));

catch

    % sum(video_manual_smile(:,2))
    % sum(auto_smile_values)
    
    
    
    accuracy = nansum(auto_smile_values(1:end-1) == video_manual_mov(:,2))/length(video_manual_mov(:,2));
    auto_smile_correct = auto_smile_values(1:end-1) == 1;
    if sum(auto_smile_correct) >0 %&& sum(video_manual_smile(:,2)) >0
    accuracy_smile = nansum(video_manual_mov(auto_smile_correct,2))/length(video_manual_mov(auto_smile_correct,2));
    else
                accuracy_smile = nan;
    end
    
        
    video_smile_correct = video_manual_mov(:,2) == 1;
    
    auto_smile_values = auto_smile_values(1:end-1);
    accuracy_video = nansum(auto_smile_values(video_smile_correct,1))/length(auto_smile_values(video_smile_correct,1));
    
    
   all_accuracy = auto_smile_values == video_manual_mov(:,2);
   accuracy_0 = nansum(all_accuracy(video_manual_mov(:,2)==0))/length(all_accuracy(video_manual_mov(:,2)==0));
   accuracy_1 = nansum(all_accuracy(video_manual_mov(:,2)==1))/length(all_accuracy(video_manual_mov(:,2)==1));


    
    
    balanced_accuracy = nanmean([accuracy_0 accuracy_1]);
%        kappa_comp = [sum(auto_smile_values) length(auto_smile_values)-sum(auto_smile_values);sum(video_manual_smile(:,2)) length(video_manual_smile(:,2))-sum(video_manual_smile(:,2))];
[k,p] = kappa(confusionmat(1*auto_smile_values,video_manual_mov(:,2)));

end

results = array2table([accuracy accuracy_0 accuracy_1 balanced_accuracy k p],...
    'VariableNames',{'accuracy', 'accuracy_0' 'accuracy_1' 'balanced_accuracy' 'k' 'p'});


% output_result = results.Properties.VariableNames{contains(results.Properties.VariableNames,output_variable)};
end