function start_time = IBS_import_eye_tracker_blink_info(f_name)
export_string = fileread(f_name);


start_segment = strfind(export_string,'Absolute Time Range');
end_segment = strfind(export_string,'-');


start_time = str2num(export_string(start_segment+20:(end_segment(end)-1)));

end