
function [instantaneous_correlation,conditions,correlation_fname] = IBS_save_dyad_tf_instantaneous_corr(data_analysis_type,Dyads)
if nargin <4
    %     Dyads = [1:11 13:18 20:23];
    %     Dyads = [1:11 13];
    Dyads = 1:23;
    
    %Dyads = [1:11 13:18];
    
end
analysis_type_params = IBS_get_params_analysis_type(data_analysis_type);
data_dir = analysis_type_params.data_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
data_dir = [data_dir 'moving_correlation\\'];
% save_power_dir = analysis_type_params.save_power_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
correlation_fname = analysis_type_params.correlation_fname{1,1};
correlation_fname = strrep(correlation_fname,'trialwise_correlations_','trialwise_instantaneous_correlations_');
conditions = analysis_type_params.conditions;

instantaneous_correlation = cell(1,length(Dyads));

moving_correlation_all_dyads = load(correlation_fname,'instantaneous_correlation','conditions','analysis_type');

for Dyad = 1:length(Dyads)
    instantaneous_correlation = moving_correlation_all_dyads.instantaneous_correlation(Dyads(Dyad));
%     instantaneous_correlations_process = moving_correlation_all_dyads.instantaneous_correlation{Dyad_no(Dyad)};
    
%     instantaneous_correlations_process{Dyad_no(Dyad)} = cellfun(@(x) squeeze(mean(mean(cat(4,x{:}),2),4)),instantaneous_correlations_process,'UniformOutput',false);
    
    
    save_fname = [data_dir sprintf('Dyd_%0.1d_trialwise_instantaneous_corr_all_dyads_baseline_normchange_0_120s_CAR.mat',Dyads(Dyad))];
    
    save(save_fname,'instantaneous_correlation','conditions','data_analysis_type','-v7.3');
    
end
% save(saved_fname_processed,'instantaneous_correlations_process','conditions','data_analysis_type','Dyad_no','-v7.3');


end