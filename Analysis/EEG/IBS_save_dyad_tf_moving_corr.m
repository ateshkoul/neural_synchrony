%% A function to load the IBS dataset
function [moving_correlation_processed,conditions,saved_fname_processed] = IBS_save_dyad_tf_moving_corr(data_analysis_type,freq_bands,windowSize,Dyad_no)



if nargin <4
    %     Dyads = [1:11 13:18 20:23];
    %     Dyads = [1:11 13];
    Dyad_no = 1:23;
    
    %Dyads = [1:11 13:18];
    
end
analysis = 'Moving_window';
analysis_type_params = IBS_get_params_analysis_type(data_analysis_type,analysis);



data_dir = analysis_type_params.data_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
analysis_save_dir = analysis_type_params.analysis_save_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
conditions = analysis_type_params.conditions;
data_dir = [data_dir 'moving_correlation\\'];

% conditions = {'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'};
%     conditions = {'FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task'};
% freq_bands = [30:55];
% windowSize = 4;% in sec


select_string = sprintf('trialwise_moving_centered_corr_%0.1d_window_%0.1d_%0.1d_all_dyads_baseline_normchange_0_120s_CAR.mat', windowSize,freq_bands(1),freq_bands(end));
select_fnames = IBS_select_files([analysis_save_dir 'Subwise\\'],select_string);


saved_fname = [analysis_save_dir sprintf('trialwise_moving_centered_corr_%0.1d_window_%0.1d_%0.1d_all_dyads_baseline_normchange_0_120s_CAR.mat',windowSize,freq_bands(1),freq_bands(end))];
saved_fname_processed = strrep(saved_fname,'trialwise_moving_centered_corr','avg_trialwise_moving_centered_corr');

moving_correlation_processed = cell(1,length(Dyad_no));

if length(select_fnames)==length(Dyad_no)
    if exist(saved_fname_processed,'file')
        load(saved_fname_processed,'moving_correlation_processed','conditions','data_analysis_type','Dyad_no');
    else
        for Dyad = 1:length(Dyad_no)
            save_fname = [data_dir sprintf('Dyd_%0.1d_trialwise_moving_centered_corr_%0.1d_window_%0.1d_%0.1d_all_dyads_baseline_normchange_0_120s_CAR.mat',Dyad_no(Dyad), windowSize,freq_bands(1),freq_bands(end))];
            
            %             moving_correlation_dyad = load(save_fname,'moving_correlation','conditions','analysis_type');
            moving_correlation{Dyad_no(Dyad)} = moving_correlation_dyad.moving_correlation;
            moving_correlation_processed{Dyad_no(Dyad)} = cellfun(@(x) squeeze(mean(mean(cat(4,x{:}),2),4)),moving_correlation{Dyad_no(Dyad)},'UniformOutput',false);
            
        end
        %         save(saved_fname_processed,'moving_correlation_processed','conditions','analysis_type','Dyad_no','-v7.3');
    end
    
else
    if exist(saved_fname_processed,'file')
        load(saved_fname_processed,'moving_correlation_processed','conditions','data_analysis_type','Dyad_no');
    else
        
        moving_correlation_all_dyads = load(saved_fname,'moving_correlation','conditions','analysis_type');
        for Dyad = 1:length(Dyad_no)
            moving_correlation = moving_correlation_all_dyads.moving_correlation(Dyad_no(Dyad));
            moving_correlation_process = moving_correlation_all_dyads.moving_correlation{Dyad_no(Dyad)};
            
            moving_correlation_processed{Dyad_no(Dyad)} = cellfun(@(x) squeeze(mean(mean(cat(4,x{:}),2),4)),moving_correlation_process,'UniformOutput',false);
            
            
            save_fname = [data_dir sprintf('Dyd_%0.1d_trialwise_moving_centered_corr_%0.1d_window_%0.1d_%0.1d_all_dyads_baseline_normchange_0_120s_CAR.mat',Dyad_no(Dyad), windowSize,freq_bands(1),freq_bands(end))];
            
            save(save_fname,'moving_correlation','conditions','data_analysis_type','-v7.3');
            
        end
        save(saved_fname_processed,'moving_correlation_processed','conditions','data_analysis_type','Dyad_no','-v7.3');
    end
end

end