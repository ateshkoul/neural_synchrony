function [clean_asr_data]= IBS_clean_data_asr(Dyads)



if nargin <1
    Dyads = [1:11 13:18 20:23];
    %     Dyads = [1:11 13];
    
    %Dyads = [1:11 13:18];
    
end

processed_dir = 'D:\\Experiments\\IBS\\Processed\\EEG\\Only_eye_artefacts\\';
blocks = {'baseline_1','blocks','baseline_2'};

for Dyd_no = 1:length(Dyads)
    
    load([processed_dir sprintf('Dyd_%0.2d_ICA_func_clean_bp_03_95_120s.mat',Dyads(Dyd_no))],'data_ica_clean_S1','data_ica_clean_S2')
    
    
    data_ica_clean_S1 = cellfun(@IBS_clean_asr_ft_struct,data_ica_clean_S1,'UniformOutput', false);
    data_ica_clean_S2 = cellfun(@IBS_clean_asr_ft_struct,data_ica_clean_S2,'UniformOutput', false);    
    
    
    save([processed_dir sprintf('Dyd_%0.2d_ASR_ICA_cleaned.mat',Dyad_no)],'data_ica_clean_S1','data_ica_clean_S2','-v7.3')
    
    
end