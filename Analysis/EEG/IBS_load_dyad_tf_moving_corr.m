%% A function to load the tf moving corr subwise IBS dataset
function [moving_correlation,conditions,save_fname,moving_correlation_dyad] = IBS_load_dyad_tf_moving_corr(data_analysis_type,freq_bands,windowSize,Dyad_no,selected_conditions)
%% Atesh
% 23-12-2020
% updated 28-01-2021: added possibility of having more than 1 condition
% added in inner loop so that the matfiles are loaded only once - for time
% efficiency

if nargin <4
    %     Dyads = [1:11 13:18 20:23];
    %     Dyads = [1:11 13];
    Dyad_no = 1:23;
    
    %Dyads = [1:11 13:18];
    
end
analysis = 'Moving_window';
analysis_type_params = IBS_get_params_analysis_type(data_analysis_type,analysis);


% data_dir = analysis_type_params.data_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
analysis_save_dir = analysis_type_params.analysis_save_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
conditions = analysis_type_params.conditions;
analysis_save_dir = [analysis_save_dir 'Subwise\\'];

if strcmp(selected_conditions{1,1},'all')
    moving_correlation = cell(1,length(Dyad_no));

    for Dyad = 1:length(Dyad_no)
    
    
    
    save_fname = [analysis_save_dir sprintf('Dyd_%0.1d_trialwise_moving_centered_corr_%0.1d_window_%0.1d_%0.1d_all_dyads_baseline_normchange_0_120s_CAR.mat',Dyad_no(Dyad), windowSize,freq_bands(1),freq_bands(end))];
    
    moving_correlation_dyad = load(save_fname,'moving_correlation','conditions');
    moving_correlation{Dyad} = moving_correlation_dyad.moving_correlation{1,1};
    end
else





moving_correlation = cell(1,length(Dyad_no));
% cur_condition = selected_conditions{condition_no};

condition_split = cellfun(@(x) strsplit(x,'_'),selected_conditions,'UniformOutput',false);
condition_names = cellfun(@(x) x(1),condition_split,'UniformOutput',false);
block_nos = cell2mat(cellfun(@(x) str2num(x{2}),condition_split,'UniformOutput',false));
condition_nos = cell2mat(cellfun(@(x) find(ismember(conditions,x)),condition_names,'UniformOutput',false));
% condition_nos = unique(cell2mat(cellfun(@(x) find(ismember(conditions,x)),condition_names,'UniformOutput',false)));

unique_conds = unique(condition_nos);
for Dyad = 1:length(Dyad_no)
    
    
    
    save_fname = [analysis_save_dir sprintf('Dyd_%0.1d_trialwise_moving_centered_corr_%0.1d_window_%0.1d_%0.1d_all_dyads_baseline_normchange_0_120s_CAR.mat',Dyad_no(Dyad), windowSize,freq_bands(1),freq_bands(end))];
    
    moving_correlation_dyad = load(save_fname,'moving_correlation','conditions');
    %         moving_correlation{Dyad_no(Dyad)}{condition_no} = moving_correlation_dyad.moving_correlation{1,1}{ismember(conditions,condition_name)}{block_no};
    moving_correlation_condition = cell(1,length(unique(condition_nos)));
    for condition_no = 1:length(unique(condition_nos))
        cur_condition_no = unique_conds(condition_no);
        cur_blocks = block_nos(condition_nos == cur_condition_no);
        moving_correlation_all_cond_blocks = cat(2,moving_correlation_dyad.moving_correlation{1,1}{cur_condition_no});
        moving_correlation_condition{condition_no} = cat(2,moving_correlation_all_cond_blocks{cur_blocks});
    end
    moving_correlation{Dyad_no(Dyad)} = cat(2,moving_correlation_condition{:});
    
end
%         save(saved_fname_processed,'moving_correlation_processed','conditions','analysis_type','Dyad_no','-v7.3');
end
end