function [label_type_data] = IBS_load_video_manual_labelled(Dyad_no,Sub_no,condition,label_types,raw_data_dir)
if nargin<4
   label_types = {'Smile'};
   raw_data_dir = 'Y:\\Inter-brain synchrony\\Results\\Eye_tracking\\Labeling\\';

end
if nargin<5
   raw_data_dir = 'Y:\\Inter-brain synchrony\\Results\\Eye_tracking\\Labeling\\';

end



condition_split = strsplit(condition,'_');
condition_name = condition_split{1};
block_no = str2num(condition_split{2});

mapObj = containers.Map({'NeNoOcc','FaNoOcc','Task'},...
{'NearNoOcc','FarNoOcc','Task' });



% data_f_name = [raw_data_dir sprintf('Dyad_%0.2d',Dyad_no) '\\' num2words(Dyad_no,'case','upper') '_' mapObj(condition_name) '_' num2str(block_no) '_LABELS.mat'];
data_f_name = [raw_data_dir sprintf('Dyad_%0.2d',Dyad_no) '\\' mapObj(condition_name) '_' num2str(block_no) '_LABELS.mat'];

video_manual_label = load(data_f_name);

gTruth_data = video_manual_label.gTruth.LabelData;

label_types_sub = cellfun(@(x) arrayfun(@(y)  [x '_S' num2str(y)],Sub_no,'UniformOutput',false),label_types,'UniformOutput',false);
label_type_cols = contains(gTruth_data.Properties.VariableNames,cat(2,label_types_sub{:}));

label_type_data = gTruth_data(:,label_type_cols);


all_movement_cols = contains(label_type_data.Properties.VariableNames,{'Mov','Hands'});
label_type_data.All_mov = sum(table2array(label_type_data(:,all_movement_cols)),2)>0;


label_type_data = timetable2table(label_type_data);
% convert to array
label_type_data.Time = seconds(label_type_data.Time) + IBS_get_behav_delay(Dyad_no,Sub_no,condition);

% label_type_data.timepoints = seconds(label_type_data.Time);

% label_type_data = [seconds(label_type_data.Time) table2array(label_type_data)];




end