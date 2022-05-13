function IBS_get_global_range_body_movement_video
%IBS_GET_GLOBAL_RANGE_BODY_MOVEMENT_VIDEO
%
% SYNOPSIS: IBS_get_global_range_body_movement_video
%
% INPUT function to get body movement range in video camera
%
% OUTPUT 
%
% REMARKS
%
% created with MATLAB ver.: 9.8.0.1359463 (R2020a) Update 1 on Microsoft Windows 10 Pro Version 10.0 (Build 19042)
%
% created by: Atesh
% DATE: 21-Jan-2022
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin <1
    output_type = 'global_range';
end
conditions = {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','FaOcc_1','FaOcc_2','FaOcc_3'};

body_parts = {'Head','Torso','Left_Shoulder','Left_Elbow','Left_Wrist',...
    'Left_Knee','Left_Feet','Right_Shoulder','Right_Elbow','Right_Wrist','Right_Knee','Right_Feet'};
Dyads = 1:23;
Subs = 0:1;
switch(output_type)
    case 'global_range'
        
        global_mov = arrayfun(@(dyad) arrayfun(@(sub) IBS_get_all_movement_vicon(dyad,sub,conditions),...
            Subs,'UniformOutput',0),Dyads,'UniformOutput',0);
        all_subs = cat(2,global_mov{:});
        all_subs = cat(1,all_subs{:});
%         global_range = array2table(all_subs(:,1:12),'VariableNames',body_parts);
%         save(savemat_fname,'global_range','all_subs')
        savemat_fname = ['E:\\Projects\\IBS\\Results\\Vicon\\vicon_video_corresp\\global_range_vicon.mat'];
        save(savemat_fname,'all_subs')
    case 'subwise'
        global_mov = arrayfun(@(dyad) arrayfun(@(sub) IBS_get_range_body_movement_vicon(dyad,sub,conditions),...
            Subs,'UniformOutput',0),Dyads,'UniformOutput',0);
        
        global_mov = cat(2,global_mov{:}); % sub is appended so it's dyad 1 0,1 then dyad 2 0,1 and so on
        global_mov = cat(3,global_mov{:});
        global_mov = permute(global_mov,[3 2 1]);
        global_range_min = array2table(squeeze(global_mov(:,1,1:12)),'VariableNames',body_parts);
        global_range_max = array2table(squeeze(global_mov(:,2,1:12)),'VariableNames',body_parts);
        global_range = {global_range_min global_range_max};
end



%% old
% all_subs = cat(3,all_subs{:});
% n_bodyparts = 12;
% global_min = squeeze(min(all_subs(1:n_bodyparts,1,:),[],3));
% global_max = squeeze(max(all_subs(1:n_bodyparts,2,:),[],3));
%
% %
% % global_min = squeeze(min(all_subs(:,1,:),[],3));
% % global_max = squeeze(max(all_subs(:,2,:),[],3));
% % global_range = [global_min global_max];
% global_range = arrayfun(@(x) linspace(global_min(x,1),global_max(x,1),1000),...
%     1:size(global_min,1),'UniformOutput',0);

% global_range = array2table(cat(1,global_range{:})','VariableNames',body_parts);

end
function range = IBS_get_range_body_movement_vicon(Dyad_no,Sub_no,conditions)

for condition_no = 1:length(conditions)
    [~,~,vicon_movement] = IBS_compute_body_movement_vicon(Dyad_no,Sub_no,conditions{condition_no});
    cur_range_min(:,condition_no) = min(table2array(vicon_movement));
    cur_range_max(:,condition_no) = max(table2array(vicon_movement));
end
sub_min = squeeze(min(cur_range_min,[],2));
sub_max = squeeze(min(cur_range_max,[],2));
range = [sub_min sub_max];
end

function range = IBS_get_all_movement_vicon(Dyad_no,Sub_no,conditions)

for condition_no = 1:length(conditions)
    [~,averaged_variation,~] = IBS_compute_body_movement_vicon(Dyad_no,Sub_no,conditions{condition_no});
    % cur_range_min(:,condition_no) = min(table2array(vicon_movement));
    % cur_range_max(:,condition_no) = max(table2array(vicon_movement));
    
    cur_vicon{condition_no} = averaged_variation;
    cur_vicon{condition_no}.Dyad_no = repmat(Dyad_no,size(averaged_variation,1),1);
    cur_vicon{condition_no}.Sub_no = repmat(Sub_no,size(averaged_variation,1),1);

end

% sub_min = squeeze(min(cur_range_min,[],2));
% sub_max = squeeze(min(cur_range_max,[],2));
% range = [sub_min sub_max];
range = cat(1,cur_vicon{:});
% important not to convert to array - the 2 subjects have different order
% of body parts (for some strange reason!). checked that using just table
% correctly appends to the corresponding bodyparts when u use cat in the
% main function (12-01-2022).
% range = table2array(cat(1,cur_vicon{:}));

end