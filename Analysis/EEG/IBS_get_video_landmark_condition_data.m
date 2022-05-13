function data = IBS_get_video_landmark_condition_data(Dyads,Sub,condition,raw_data_folder)

behavior = 'Video_landmarks';
Dyad_no = 1;
Sub = 1;
condition = 'NeNoOcc_1';
if nargin <4    
    raw_data_folder = 'D:\\iannettilab_dropbox\\Dropbox\\Koul_Atesh\\IBS\\';
end
data = IBS_get_sub_behavior_data(behavior,Dyad_no,Sub,condition,raw_data_folder);


data = IBS_clean_video_landmark_data(data);
end