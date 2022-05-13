function [behav_data] = IBS_get_sub_behavior_data(behavior,Dyad_no,Sub,condition,raw_data_dir,varargin_table)
% behavior_params = IBS_get_behavior_type(behavior,varargin_table.behav_analysis);
behavior_params = IBS_get_behavior_type(behavior);

norm_fun = behavior_params.norm_fun{1,1};
%
% e.g. import_fun = @IBS_import_pupil_csv_data
% e.g. import_fun = @IBS_import_gaze_positions_on_body_data
% varargin_table.norm_method = @(x) normalize(x);
varargin_table.norm_method = 'zscore';
switch(behavior)
    case 'Eye_tracker_pupil'
        import_fun = @IBS_import_pupil_csv_data;
        varargin_table.cols_to_keep = {'pupil_timestamp','diameter'};
        sub_dir = IBS_get_sub_behavior_dir(behavior,Dyad_no,Sub,condition);
        sub_dir = [raw_data_dir sub_dir];
        behav_data = import_fun([sub_dir '\\pupil_positions.csv']);
        behav_data = behav_data(:,ismember(behav_data.Properties.VariableNames,varargin_table.cols_to_keep));
        behav_data = rmmissing(behav_data);
        behav_data.pupil_timestamp = behav_data.pupil_timestamp - behav_data.pupil_timestamp(1,1);
        behav_data.Properties.VariableNames = cellfun(@(x) [x '_' num2str(Sub)],behav_data.Properties.VariableNames,'UniformOutput',false);
        % keep as a table
        %         behav_data = table2array(behav_data);
        %         behav_data(:,1) = behav_data(:,1)-behav_data(1,1);
        % may be it's better to normalize them just before the glm
        %         behav_data(:,2:end) = norm_fun(behav_data(:,2:end),varargin_table.norm_method);
        
%     case 'Eye_tracker_gaze_positions_on_body'
    case 'Eye_tracker_gaze'
        % this doesn't work for a table because table.import_fun(x) where x
        % is an argument to function is taken as an index for a table
%         varargin_table.import_fun = @IBS_import_pupil_csv_data;
        import_fun = @IBS_import_gaze_positions_on_body_data;
        % eye_on_body for a lot of subjects is always 1
        %         varargin_table.cols_to_keep = {'time_stamps','eye_on_body','eye_on_face','eye_on_face_ellipse'};
%         varargin_table.cols_to_keep = {'time_stamps','eye_on_face','eye_on_face_ellipse','eye_on_eye_ellipse'};
        varargin_table.cols_to_keep = {'time_stamps','eye_on_face_ellipse'};

        sub_dir = IBS_get_sub_behavior_dir(behavior,Dyad_no,Sub,condition);
        sub_dir = [raw_data_dir sub_dir];
        behav_data = import_fun([sub_dir '\\results_ellipse_eye_gaze_api_full.csv']);
        behav_data = behav_data(:,ismember(behav_data.Properties.VariableNames,varargin_table.cols_to_keep));
        behav_data = rmmissing(behav_data);
        behav_data.time_stamps = behav_data.time_stamps - behav_data.time_stamps(1,1);
		
        %behav_data.time_stamps = behav_data.time_stamps + IBS_get_behav_delay(Dyad_no,Sub,condition);
        % this is useful when merging columns across behavioral tasks
        behav_data.Properties.VariableNames = cellfun(@(x) [x '_' num2str(Sub)],behav_data.Properties.VariableNames,'UniformOutput',false);
        % to reduce the name in lme
        
        behav_data.Properties.VariableNames = strrep(behav_data.Properties.VariableNames,'_on_','');
        behav_data.Properties.VariableNames = strrep(behav_data.Properties.VariableNames,'_ellipse','_e');
        
        % this helps in keeping them unique
        %         behav_data = table2array(behav_data);
        %         behav_data(:,1) = behav_data(:,1)-behav_data(1,1);
        % may be it's better to normalize them just before the glm
        %         behav_data(:,2:end) = norm_fun(behav_data(:,2:end),varargin_table.norm_method);
    case 'Eye_tracker_blink'
        import_fun = @IBS_import_blink;
        varargin_table.cols_to_keep = {'start_timestamp','end_timestamp','duration'};
        sub_dir = IBS_get_sub_behavior_dir(behavior,Dyad_no,Sub,condition);
        sub_dir = [raw_data_dir sub_dir];
        behav_data = import_fun([sub_dir '\\blinks.csv']);
        behav_data = behav_data(:,ismember(behav_data.Properties.VariableNames,varargin_table.cols_to_keep));
        behav_data = rmmissing(behav_data);
%         behav_data.Properties.VariableNames = cellfun(@(x) [x '_' num2str(Sub)],behav_data.Properties.VariableNames,'UniformOutput',false);
        % keep as a table
        %         behav_data = table2array(behav_data);
        %         behav_data(:,1) = behav_data(:,1)-behav_data(1,1);
        % may be it's better to normalize them just before the glm
        %         behav_data(:,2:end) = norm_fun(behav_data(:,2:end),varargin_table.norm_method);
        
%         import_fun_info = @(x) jsondecode(fileread(x));
        import_fun_info = @IBS_import_eye_tracker_blink_info;

 
        behav_data_starttime = import_fun_info([sub_dir '\\export_info.csv']);
%         import_fun_pupil = @IBS_import_pupil_csv_data;
%         varargin_table.cols_to_keep = {'pupil_timestamp'};
%         sub_dir = IBS_get_sub_behavior_dir('Eye_tracker_pupil',Dyad_no,Sub,condition);
%         sub_dir = [raw_data_dir sub_dir];
%         behav_data_pupil = import_fun_pupil([sub_dir '\\pupil_positions.csv']);
%         behav_data_pupil = behav_data_pupil(:,ismember(behav_data_pupil.Properties.VariableNames,varargin_table.cols_to_keep));
%         behav_data_starttime = behav_data_pupil.pupil_timestamp(1,1);
        
        
        
        behav_data.start_timestamp = round(behav_data.start_timestamp - behav_data_starttime,4);
        behav_data.end_timestamp = round(behav_data.end_timestamp - behav_data_starttime,4);
 
    case 'Video_landmarks'
        import_fun = @IBS_import_video_landmarks;
        %         varargin_table.cols_to_keep = {'time_stamps','eye_on_face','eye_on_face_ellipse','eye_on_eye_ellipse'};
        
        sub_dir = IBS_get_sub_behavior_dir(behavior,Dyad_no,Sub,condition);
        sub_dir = [raw_data_dir sub_dir];
        behav_data = import_fun([sub_dir '\\results_video_' num2str(Sub) '_pose_body_processed.csv']);
        %         behav_data = behav_data(:,ismember(behav_data.Properties.VariableNames,varargin_table.cols_to_keep));
        
        behav_data = behav_data(contains(behav_data.Unnamed0,condition),:);
%         behav_data = IBS_clean_video_landmark_data(behav_data);
%         behav_data.timepoints = linspace(0,120,size(behav_data,1))';
    case 'Video_manual_labelled'
        import_fun = @IBS_load_video_manual_labelled;
%         varargin_table.label_types = {'Smile','Hands_Feet','Mov_head'}; 

        varargin_table.label_retain_types = {'Time','Smile','All_mov'}; 
        varargin_table.label_types = {'Smile','Hands_Feet','Mov_head','Mov_arms','Mov_trunk','Mov_legs'};
        
        mapObj = containers.Map({0,1},{1,2});
        behav_data = import_fun(Dyad_no,mapObj(Sub),condition,varargin_table.label_types);
        
        behav_data = behav_data(:,contains(behav_data.Properties.VariableNames,varargin_table.label_retain_types));
end



end