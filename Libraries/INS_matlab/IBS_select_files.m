function select_fnames = IBS_select_files(dirname,select_string)


file_list = dir(dirname);
file_list_cell = struct2cell(file_list);
file_list_names = file_list_cell(1,:);
select_files = contains(file_list_names,select_string);
select_fnames = file_list_names(select_files);

end