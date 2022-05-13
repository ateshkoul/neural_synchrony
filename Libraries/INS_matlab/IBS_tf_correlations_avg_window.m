function [correlations,conditions,correlation_fname]= IBS_tf_correlations_avg_window(analysis_type,Dyads,windowSize)


if nargin <2
%     Dyads = [1:11 13:23];
    Dyads = 1:23;

end

if nargin <1
    analysis_type = 'no_aggressive_trialwise_CAR';
end

if nargin <3
windowSize = 5;
end

analysis_type_params = IBS_get_params_analysis_type(analysis_type);
data_dir = analysis_type_params.data_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
% save_power_dir = analysis_type_params.save_power_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
correlation_fname = analysis_type_params.correlation_fname{1,1};
correlation_fname = strrep(correlation_fname,'trialwise_correlations_',['trialwise_correlations_avg_window_' num2str(windowSize) '_']);
conditions = analysis_type_params.conditions;
% process_dir = 'D:\\Experiments\\IBS\\Processed\\EEG\\';
% process_dir = 'D:\\Atesh\\IBS\\';


if exist(correlation_fname,'file')
    load(correlation_fname,'correlations','conditions');
else
    freq_bands = 1:95;
    moving_corr = IBS_load_dyad_tf_moving_corr(analysis_type,freq_bands,windowSize,Dyads,{'all'});
    correlations = cellfun(@(x) cellfun(@(y) squeeze(mean(mean(cat(4,y{:}),4),2)), x,'UniformOutput',0),moving_corr,'UniformOutput',0);

    save(correlation_fname,'correlations','conditions');
    
end



end
