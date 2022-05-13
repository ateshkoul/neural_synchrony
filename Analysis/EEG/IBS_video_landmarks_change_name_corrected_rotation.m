behavior = 'Video_landmarks';
raw_data_dir = 'D:\\iannettilab_dropbox\\Dropbox\\Koul_Atesh\\IBS\\';
Dyads = 22:23; %12:21
Subs = [0 1];
% condition = 'NeNoOcc_1';
conditions = {'Task_1','Task_2','Task_3','FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3','FaOcc_1','FaOcc_2','FaOcc_3','NeOcc_1','NeOcc_2','NeOcc_3'};



for Dyad_no = 1:length(Dyads)
    
    
        
        
        sub_dir = IBS_get_sub_behavior_dir(behavior,Dyads(Dyad_no),0,'FaNoOcc_1');
        sub_dir = [raw_data_dir sub_dir];
        behav_fname_1 = [sub_dir '\\results_video_' num2str(0) '_pose_body_processed.csv'];
        
        behav_fname_2 = [sub_dir '\\results_video_' num2str(1) '_pose_body_processed.csv'];
        
%         new_behav_fname_1 = [sub_dir '\\results_video_' num2str(0) '_pose_body_corrected_camera.csv'];
%         
%         new_behav_fname_2 = [sub_dir '\\results_video_' num2str(1) '_pose_body_corrected_camera.csv'];
%         
        
        old_behav_fname_1 = [sub_dir '\\results_video_' num2str(0) '_pose_body.csv'];
        
        old_behav_fname_2 = [sub_dir '\\results_video_' num2str(1) '_pose_body.csv'];
        
        delete(old_behav_fname_1)
        delete(old_behav_fname_2)
        
        movefile(behav_fname_1,old_behav_fname_1)
        movefile(behav_fname_2,old_behav_fname_2)     
        
%         delete(behav_fname_1)
%         delete(behav_fname_2)
        
%         movefile(new_behav_fname_1,behav_fname_1)
%         movefile(new_behav_fname_2,behav_fname_2)
        
%         %%
%         cellfun(@(x) delete([sub_dir '\\results_video_0_' x '_pose_body_processed.mat']),conditions,'UniformOutput',false);
% cellfun(@(x) delete([sub_dir '\\results_video_1_' x '_pose_body_processed.mat']),conditions,'UniformOutput',false);


%         cellfun(@(x) delete([sub_dir '\\results_video_0_' x '_pose_body_unprocessed.mat']),conditions,'UniformOutput',false);
% cellfun(@(x) delete([sub_dir '\\results_video_1_' x '_pose_body_unprocessed.mat']),conditions,'UniformOutput',false);

end



