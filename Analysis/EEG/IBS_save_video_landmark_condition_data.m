function IBS_save_video_landmark_condition_data()
%% Atesh


behavior = 'Video_landmarks';
raw_data_folder = 'D:\\iannettilab_dropbox\\Dropbox\\Koul_Atesh\\IBS\\';
raw_save_folder = 'E:\\Davide_shared\\IBS\\';
Dyads = 19;
Subs = [1];
% condition = 'NeNoOcc_1';

% conditions = {'Task_1','Task_2','Task_3','FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3','FaOcc_1','FaOcc_2','FaOcc_3','NeOcc_1','NeOcc_2','NeOcc_3'};
conditions = {'Task_3','FaNoOcc_3','NeNoOcc_3','FaOcc_3'};
%  conditions = {'FaOcc_3',}
% only for hand
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
            data_table = IBS_get_sub_behavior_data(behavior,Dyads(Dyad_no),Subs(Sub_no),conditions{condition_no},raw_data_folder,varargin_table);
            
%             S = vartype('numeric');
%             
%             data_table = data_table(:,S);
%             data_colnames = data_table.Properties.VariableNames;
%             data = table2array(data_table);
            
            
            
%             data_table = IBS_clean_video_landmark_data(data_table);
            sub_dir = IBS_get_sub_behavior_dir(behavior,Dyads(Dyad_no),Subs(Sub_no),conditions{condition_no});
            sub_dir = [raw_save_folder sub_dir];
            if ~exist(sub_dir,'dir')
                mkdir(sub_dir)
            end
            data_colnames = data_table.Properties.VariableNames;
            
            S = vartype('numeric');
            
            data = data_table(:,S);
            data = table2array(data); % so that python can load it
            
            save([sub_dir 'results_video_' num2str(Subs(Sub_no)) '_' conditions{condition_no} '_pose_' varargin_table.body_part '_unprocessed.mat'],...
                'data','data_colnames','data_table');
            %             csvwrite([sub_dir 'results_video_' num2str(Subs(Sub_no)) '_' conditions{condition_no} '_pose_body_processed.csv'],...
            %                 'data');
        end
    end
end

end