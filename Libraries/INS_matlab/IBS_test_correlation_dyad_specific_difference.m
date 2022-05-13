function [correlations_cell,conditions,pseudo_correlation_fname] = IBS_test_correlation_dyad_specific_difference(analysis_type,Dyads)
%
% created with MATLAB ver.: 9.8.0.1359463 (R2020a) Update 1 on Microsoft Windows 10 Pro Version 10.0 (Build 19042)
%
% created by: Atesh
% DATE: 11-Apr-2021
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin <2
    Dyads = [1:23];
end

if nargin <1
    analysis_type = 'no_aggressive_trialwise_CAR';
end


analysis_type_params = IBS_get_params_analysis_type(analysis_type);
data_dir = analysis_type_params.data_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
% save_power_dir = analysis_type_params.save_power_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
correlation_fname = analysis_type_params.correlation_fname{1,1};
% pseudo_correlation_fname = strrep(correlation_fname,'trialwise_correlations','pseudo_trialwise_correlations');
% pseudo_correlation_fname_temp = strrep(correlation_fname,'trialwise_correlations','temp_pseudo_trialwise_correlations');

pseudo_correlation_fname = strrep(correlation_fname,'trialwise_correlations','pseudo_detrend_trialwise_correlations');
pseudo_correlation_fname_temp = strrep(correlation_fname,'trialwise_correlations','temp_pseudo_detrend_trialwise_correlations');



conditions = analysis_type_params.conditions;
% process_dir = 'D:\\Experiments\\IBS\\Processed\\EEG\\';
% process_dir = 'D:\\Atesh\\IBS\\';

avg_pseudo_correlations = cell(1,length(Dyads));


if exist(pseudo_correlation_fname,'file')
    correlations_permuted = load(pseudo_correlation_fname,'avg_pseudo_correlations','conditions');
    [correlations,conditions,correlation_fname]= IBS_tf_correlations(analysis_type,Dyads);
    correlations_cell = cellfun(@(x,y) cellfun(@(s,t) s-t, x,y,'UniformOutput',0),...
        correlations,correlations_permuted.avg_pseudo_correlations,'UniformOutput',0);

    
    
else
for Dyd_no = 1:length(Dyads)
    IBS_tf_data = IBS_load_datasets_tf(Dyads(Dyd_no),analysis_type,data_dir);
    data_ica_clean_S1_tf = IBS_tf_data.data_ica_clean_S1_tf;
    data_ica_clean_S2_tf = IBS_tf_data.data_ica_clean_S2_tf;
    
    other_Dyads = setdiff(Dyads,Dyads(Dyd_no));
    pseudo_dyad_correlations = cell(1,length(other_Dyads));
    sprintf('Dyd_%0.2d',Dyads(Dyd_no))
    parfor other_Dyd_no = 1:length(other_Dyads)
        
        
        IBS_tf_other_data = IBS_load_datasets_tf(other_Dyads(other_Dyd_no),analysis_type,data_dir);
        
        data_ica_clean_S1_other_tf = IBS_tf_other_data.data_ica_clean_S1_tf;
        data_ica_clean_S2_other_tf = IBS_tf_other_data.data_ica_clean_S2_tf;
       correlations_S1_S2_other = cellfun(@(x,y) IBS_power_correlation(x,y),data_ica_clean_S1_tf,data_ica_clean_S2_other_tf,...
            'UniformOutput', false);
       correlations_S1_other_S2 = cellfun(@(x,y) IBS_power_correlation(x,y),data_ica_clean_S1_other_tf,data_ica_clean_S2_tf,...
            'UniformOutput', false);    
        
       pseudo_dyad_correlations{1,other_Dyd_no} = cellfun(@(x,y) (x+y)/2,correlations_S1_S2_other,correlations_S1_other_S2,...
            'UniformOutput', false);    
        
    end
    combined_pseudo_dyad_correlations = cat(1,pseudo_dyad_correlations{:});
    
    avg_pseudo_correlations{1,Dyads(Dyd_no)} = arrayfun(@(x) mean(cat(3,combined_pseudo_dyad_correlations{:,x}),3), ...
        1:size(combined_pseudo_dyad_correlations,2),'UniformOutput',0);
    
    save(pseudo_correlation_fname_temp,'avg_pseudo_correlations','conditions','-v7.3');

end

    save(pseudo_correlation_fname,'avg_pseudo_correlations','conditions','-v7.3');
    [correlations,conditions,correlation_fname]= IBS_tf_correlations(analysis_type,Dyads);
    correlations_cell = cellfun(@(x,y) cellfun(@(s,t) s-t, x,y,'UniformOutput',0),...
        correlations,avg_pseudo_correlations,'UniformOutput',0);

end
end




