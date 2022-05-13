raw_data_folder = 'D:\\iannettilab_dropbox\\Dropbox\\Koul_Atesh\\IBS\\';
raw_save_folder = 'E:\\Davide_shared\\IBS\\';
Dyads = 20:23;
Subs = [0 1];
% condition = 'NeNoOcc_1';
behavior = 'Video_landmarks';

conditions = {'Task_1','Task_2','Task_3','FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3','FaOcc_1','FaOcc_2','FaOcc_3','NeOcc_1','NeOcc_2','NeOcc_3'};

for Dyad_no = 1:length(Dyads)
    for Sub_no = 1:length(Subs)
        
        for condition_no = 1:numel(conditions)
            sub_dir = IBS_get_sub_behavior_dir(behavior,Dyads(Dyad_no),Subs(Sub_no),conditions{condition_no});
            raw_sub_file = [raw_data_folder sub_dir 'Video_' num2str(Subs(Sub_no)) '_' conditions{condition_no} '.avi'];
            save_sub_file = [raw_save_folder sub_dir 'Video_' num2str(Subs(Sub_no)) '_' conditions{condition_no} '.avi'];

            copyfile(raw_sub_file,save_sub_file);
        end
    end
end

