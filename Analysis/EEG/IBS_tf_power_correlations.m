function [data_ica_clean_S1_tf,data_ica_clean_S2_tf] =  IBS_tf_power_correlations(data_struct_S1,data_struct_S2,trial_nos)
%% Atesh
% wrapper function for IBS_tf_mtmconvol


data_ica_clean_S1_tf   = IBS_tf_mtmconvol(data_struct_S1,trial_nos);
data_ica_clean_S2_tf   = IBS_tf_mtmconvol(data_struct_S2,trial_nos);

end