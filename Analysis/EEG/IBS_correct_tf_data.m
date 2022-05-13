function [data_ica_clean_S1_tf,data_ica_clean_S2_tf] = IBS_correct_tf_data(data_ica_clean_S1_tf,data_ica_clean_S2_tf,conditions)


FaNoOcc_loc = find(strcmp('FaNoOcc',conditions));
repeated_data_col = max(find(data_ica_clean_S1_tf{1,FaNoOcc_loc}.time<1.7173));
data_size = size(data_ica_clean_S1_tf{1,FaNoOcc_loc}.powspctrm(1,:,:,1:repeated_data_col));
% correct only for the first FaNoOcc trial (31)
data_ica_clean_S1_tf{1,FaNoOcc_loc}.powspctrm(1,:,:,1:repeated_data_col) = NaN(data_size);
data_ica_clean_S2_tf{1,FaNoOcc_loc}.powspctrm(1,:,:,1:repeated_data_col) = NaN(data_size);

end