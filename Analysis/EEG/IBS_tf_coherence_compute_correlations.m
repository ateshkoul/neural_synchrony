function [connectivity,conditions,connectivity_fname]= IBS_tf_coherence_compute_correlations(analysis_type,measure,Dyads)


if nargin <3
%     Dyads = [1:11 13:23];
    Dyads = 1:23;

end

if nargin <1
    analysis_type = 'no_aggressive_trialwise_CAR';
    measure = 'coh';
end


analysis_type_params = IBS_get_params_analysis_type(analysis_type);
data_dir = analysis_type_params.data_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
save_dir = analysis_type_params.save_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
coherence_fname = analysis_type_params.coherence_fname{1,1};
conditions = analysis_type_params.conditions;



connectivity_fname = IBS_change_connectivity_f_name(coherence_fname,measure);
clear coherence_fname;
% process_dir = 'D:\\Experiments\\IBS\\Processed\\EEG\\';
% process_dir = 'D:\\Atesh\\IBS\\';


if exist(connectivity_fname,'file')
    cur_analysis_type = analysis_type;
    load(connectivity_fname,'connectivity','conditions','analysis_type');
    assert(strcmp(analysis_type,cur_analysis_type)==1);
else
    
    for Dyd_no = 1:length(Dyads)
        data = IBS_load_tf_coherence(Dyads(Dyd_no),analysis_type,data_dir);
                
        %         save([ save_dir sprintf('Dyd_%0.2d_trialwise_time_freq_',Dyads(Dyd_no)) analysis_type '.mat'],...
        %             'data_ica_clean_S1_tf','data_ica_clean_S2_tf','-v7.3')
%         if Dyads(Dyd_no) == 12
%            [data_ica_clean_S1_tf,data_ica_clean_S2_tf] = IBS_correct_tf_data(data_ica_clean_S1_tf,data_ica_clean_S2_tf,conditions); 
%         end
        connectivity{1,Dyads(Dyd_no)} = cellfun(@(x,y) IBS_connectivity_analysis(x,measure),data.data_coherence,...
            'UniformOutput', false);
        
    end
    save(connectivity_fname,'connectivity','conditions','analysis_type');
    
end



end
