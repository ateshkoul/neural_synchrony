function [IBS_sub_data] = load_ICA_clean_IBS_sub_data(Dyad_no,Sub)

if nargin <2
   Sub = 'S1_'; 
end

processed_dir = 'D:\\Experiments\\IBS\\Processed\\EEG\\';


IBS_sub_data = load([processed_dir Sub sprintf('Dyd_%0.2d_ICA_blocks_only_neck_artefact_clean_bp_03_95_120s.mat.mat',Dyad_no)],'data_onlyEEG');
% S1_Dyd_01_ICA_blocks_only_neck_artefact_clean_bp_03_95_120s.mat


end