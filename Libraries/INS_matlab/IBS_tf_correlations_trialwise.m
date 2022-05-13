function [correlations,conditions,correlation_fname]= IBS_tf_correlations_trialwise(trial_no,analysis_type,Dyads)

if nargin <2
  analysis_type = 'no_aggressive_trialwise_CAR';
end
if nargin <3
%      Dyads = [1:11 13:18 20:23];
    %Dyads = [1:11 13:18];
     Dyads = 1:23;

end

analysis_type_params = IBS_get_params_analysis_type(analysis_type);
data_dir = analysis_type_params.data_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
correlation_fname = analysis_type_params.correlation_fname{1,1};
correlation_fname = strrep(correlation_fname,'trialwise_correlations',sprintf('trialwise_trial_%0.1d_correlations',trial_no));
conditions = analysis_type_params.conditions;

%%

cfg_select.trials = trial_no;


if exist(correlation_fname,'file')
    load(correlation_fname,'correlations','conditions');
else

    for Dyd_no = 1:length(Dyads)

        
        data = IBS_load_datasets_tf(Dyads(Dyd_no),analysis_type,data_dir);
        % tf data is always rereferenced whether it is no aggressive, aggressive or ASR 5, ASR 10
        [data_ica_clean_S1_tf] = cellfun(@(x) ft_selectdata(cfg_select,x),data.data_ica_clean_S1_tf,'UniformOutput', false);
        [data_ica_clean_S2_tf] = cellfun(@(x) ft_selectdata(cfg_select,x),data.data_ica_clean_S2_tf,'UniformOutput', false);
        
        correlations{1,Dyd_no} = cellfun(@(x,y) IBS_power_correlation(x,y),data_ica_clean_S1_tf,data_ica_clean_S2_tf,...
            'UniformOutput', false);
    end
    save(correlation_fname,'correlations','conditions');

end



end
