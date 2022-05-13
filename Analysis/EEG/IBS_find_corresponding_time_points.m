function [corresponding_time_point_indices] =IBS_find_corresponding_time_points(high_fs_time,low_fs_time)
%% Atesh
% 22-01-2021

corresponding_time_point_indices = nan(1,length(low_fs_time));
for low_time_point = 1:length(low_fs_time)
    
    low_time = low_fs_time(low_time_point);
    
    
    cur_value_diff = high_fs_time-low_time;
    
    corresp_value = find(abs(cur_value_diff) == min(abs(cur_value_diff)));
    try
    corresponding_time_point_indices(low_time_point) = corresp_value(1); % in case two values are equidistant choose 1st
    catch
        bla = 1;
    end
end

end