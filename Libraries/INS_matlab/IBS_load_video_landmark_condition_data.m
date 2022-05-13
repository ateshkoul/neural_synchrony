function IBS_load_video_landmark_condition_data()
%% Atesh


behavior = 'Video_landmarks';
raw_data_folder = 'D:\\iannettilab_dropbox\\Dropbox\\Koul_Atesh\\IBS\\';
raw_save_folder = 'E:\\Raw_data\\';


Dyads = [16 22 23];
Subs = [0 1];
conditions = {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'};


varargin_table = table();
varargin_table.import_fun = @IBS_import_video_hand_landmarks;
% varargin_table.body_part = 'hand';
varargin_table.body_part = 'body';

varargin_table.import_fun = @IBS_import_video_landmarks;

varargin_table.behav_analysis = 'joint_XOR'; % has nothing to do with this analysis
varargin_table.analysis_sub_type ='_insta_corr_avg_freqwise';


for Dyad_no = 1:length(Dyads)
    for Sub_no = 1:length(Subs)
        
        for condition_no = 1:numel(conditions)
            %             data_table = IBS_get_sub_behavior_data(behavior,Dyads(Dyad_no),Subs(Sub_no),conditions{condition_no},raw_data_folder,varargin_table);
            
            sub_dir = IBS_get_sub_behavior_dir(behavior,Dyads(Dyad_no),Subs(Sub_no),conditions{condition_no});
            sub_data_dir = [raw_data_folder sub_dir];
            sub_save_dir = [raw_save_folder strrep(sub_dir,'Ses_001\\','')];
            if ~exist(sub_save_dir,'dir')
                mkdir(sub_save_dir)
            end
            loadmat_file = [sub_data_dir 'results_video_' num2str(Subs(Sub_no)) '_' conditions{condition_no} '_pose_' varargin_table.body_part '_unprocessed.mat'];
            try
                load(loadmat_file,'data_table')
                
                
                save([sub_save_dir 'results_video_Sub_' num2str(Subs(Sub_no)) '_' conditions{condition_no} '_pose_' varargin_table.body_part '.mat'],...
                    'data_table');
            catch
                disp( [loadmat_file ' not found'])
            end
        end
    end
end

end