function IBS_rename_video_manual_labelled()




arrayfun(@(x) IBS_rename_video_manual_labelled_dyad(x),1:23,'UniformOutput',false)

end

function IBS_rename_video_manual_labelled_dyad(Dyad_no)

raw_data_dir = 'Y:\\Inter-brain synchrony\\Results\\Eye_tracking\\Labeling\\';


raw_data_dir = 'C:\\Users\\Atesh\\OneDrive - Fondazione Istituto Italiano Tecnologia\\Research projects 2020\\Inter-brain synchrony\\Results\\Eye_tracking\\Labeling\\';
data_folder = [raw_data_dir sprintf('Dyad_%0.2d',Dyad_no) '\\'];

dir_files = IBS_select_files(data_folder,'.mat');

dyad_word = strsplit(dir_files{1,1},'_');

dyad_word = dyad_word{1,1};
newdir_f_names = strrep(dir_files,[dyad_word '_'],'');

cellfun(@(x,y) movefile([data_folder x],[data_folder y]),dir_files,newdir_f_names);

end