function class_small_med_large = IBS_classify_sub_mov_based
%IBS_CLASSIFY_SUB_MOV_BASED
%
% SYNOPSIS: IBS_classify_sub_mov_based
%
% INPUT function that classifies subjects as high, low med moving subjects.
%
% OUTPUT
%
% REMARKS
%
% created with MATLAB ver.: 9.8.0.1359463 (R2020a) Update 1 on Microsoft Windows 10 Pro Version 10.0 (Build 19042)
%
% created by: Atesh
% DATE: 12-Jan-2022
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin <3
    
    conditions = {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','FaOcc_1','FaOcc_2','FaOcc_3'};
end
body_parts = {'Head','Torso','Left_Shoulder','Left_Elbow','Left_Wrist',...
    'Left_Knee','Left_Feet','Right_Shoulder','Right_Elbow','Right_Wrist','Right_Knee','Right_Feet'};

savemat_fname = ['E:\\Projects\\IBS\\Results\\Vicon\\vicon_video_corresp\\global_range_vicon.mat'];

all_subs = load(savemat_fname,'all_subs');
all_subs = all_subs.all_subs(:,1:12);

mov_sizes = @(x) {[min(x) quantile(x,1/3)],[quantile(x,1/3) quantile(x,2*(1/3))],...
    [quantile(x,2*(1/3)) max(x)]};

% mov_sizes = @(x) {[min(x) quantile(x,1/2)],[quantile(x,(1/2)) max(x)]};  

Dyads = 1:23;
mov_size_data = varfun(mov_sizes,all_subs);
% class_small_med_large = arrayfun(@(Dyads) arrayfun(@(sub) IBS_classify_mov_all_sub(Dyads,sub,conditions,mov_size_data),...
%     0:1,'UniformOutput',0),Dyads,'UniformOutput',0);


class_small_med_large = arrayfun(@(Dyads) arrayfun(@(sub) arrayfun(@(cond_no) IBS_classify_mov_all_sub(Dyads,sub,conditions(cond_no),mov_size_data),...
    1:length(conditions),'UniformOutput',0),0:1,'UniformOutput',0),Dyads,'UniformOutput',0);

class_small_med_large = cat(2,class_small_med_large{:});
% needs to be done twice
class_small_med_large = cat(2,class_small_med_large{:});


all_class = cat(1,class_small_med_large{:});
find_fun = @(x) find(cell2mat(x));

class_small_med_large = cell2mat(cellfun(@(x) subset_fun(find_fun(x)), all_class,'UniformOutput',0));

class_small_med_large = array2table(class_small_med_large,'VariableNames',body_parts);

Dyad_nos = repmat(Dyads,2,1);
Dyad_nos = Dyad_nos(:);
Sub_nos = repmat([0 1],1,23)';
class_small_med_large = addvars(class_small_med_large,Dyad_nos,Sub_nos);
savecsv_fname = ['E:\\Projects\\IBS\\Results\\Vicon\\vicon_video_corresp\\classify_mov_sub_three_splits.csv'];
writetable(class_small_med_large,savecsv_fname)

end


function cur_size = IBS_classify_mov_sub(mov_data,data_split,body_partname)
if ~sum(any(isnan(data_split)))
    body_part = strrep(body_partname,'Fun_','');
    
    mov_data = mov_data.(body_part);
    low_lim_indices = find(mov_data>=data_split(1));
    upper_lim_indices = find(mov_data<=data_split(2));
    
    if ~isempty(intersect(low_lim_indices,upper_lim_indices))
        cur_size = 1;
    else
        cur_size = 0;
    end
else
    cur_size = NaN;
end

end




function range = IBS_get_all_movement_vicon(Dyad_no,Sub_no,conditions)

for condition_no = 1:length(conditions)
    % this is tricky here - we don't want the actual locations of where the
    % body parts were but like how much did they move. so we can't use
    % vicon_movement but the averaged change of body part (13-01-2022)
    [~,averaged_variation,~] = IBS_compute_body_movement_vicon(Dyad_no,Sub_no,conditions{condition_no});
    % cur_range_min(:,condition_no) = min(table2array(vicon_movement));
    % cur_range_max(:,condition_no) = max(table2array(vicon_movement));
    
    cur_vicon{condition_no} = averaged_variation;
end
% sub_min = squeeze(min(cur_range_min,[],2));
% sub_max = squeeze(min(cur_range_max,[],2));
% range = [sub_min sub_max];
% range = table2array(cat(1,cur_vicon{:}));
range = cat(1,cur_vicon{:});

end


function class_small_med_large= IBS_classify_mov_all_sub(dyad,sub,conditions,mov_size_data)


cur_dyad_data = IBS_get_all_movement_vicon(dyad,sub,conditions);
%
class_small_med_large = cellfun(@(x) cellfun(@(y) IBS_classify_mov_sub(cur_dyad_data,y,x),mov_size_data.(x),'UniformOutput',0),...
    mov_size_data.Properties.VariableNames,'UniformOutput',0);
end



function x = subset_fun(x)
if ~isempty(x)
%     x = x(2);
    if length(x)>1
        x= x(2);
    else
        x = x(1);
    end
else
    
    x = NaN;
end
end