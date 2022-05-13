%% A function to load the IBS dataset
function [dataset] = save_cleaned_IBS_data(analysis_type,Dyads)



%% Atesh Koul
if nargin <1
    analysis_type = 'no_aggressive_trialwise_CAR';
end
if nargin <2
% Dyads = [1 2 3 4 5];
Dyads = [1:11 13:18 20:23];

% Dyads = [6:8];
end
blocks = {'baseline_1','blocks','baseline_2'};
% blocks = {'blocks'};

save_dir = IBS_get_params_analysis_type(analysis_type).save_dir{1,1};




for Dyd_no = 1:length(Dyads)
    % for Dyd_no = 6:8
    
    %% load the raw data first
    % ('UniformOutput', false) is requred for next steps
    dataset = cellfun(@(x) IBS_load_raw_sub_data(Dyads(Dyd_no),x,[],[],analysis_type),blocks,'UniformOutput', false);
    
%         dataset = cellfun(@IBS_resampledata,dataset,'UniformOutput', false);
    
    %% clean the dataset
    
    %% remove extra channels
    dataset = cellfun(@IBS_remove_extra_chans,dataset,'UniformOutput', false);
    
    %% filter the data
    dataset_filt = cellfun(@IBS_filter_raw_data,dataset,'UniformOutput', false);
    
    % otherwise there is out of memory error
    clear dataset
    % Interpolate and ICA
    %% in case together
    % checked that while interpolating, the interpolation used is only
    % using the electrodes of the specific subject in the dyad. not all of
    % them - unless u try to remove wrong channels from wrong participant
%     [data_ica_clean_S1,data_ica_clean_S2] = cellfun(@IBS_EEG_CleanSignal,dataset_filt,'UniformOutput', false);
    
    %% In case just save the componemts
    dataset_filt = cellfun(@IBS_EEG_Interpolate,dataset_filt,'UniformOutput', false);
    
    % additing this only for the aggressive analysis
    if strcmp(analysis_type,'aggressive_trialwise_CAR')
            dataset_filt = cellfun(@IBS_resampledata,dataset_filt,'UniformOutput', false);
    end
    cfg_S1.channel = {'1-*'};
    cfg_S2.channel = {'2-*'};
    data_clean_S1  = cellfun(@(x) ft_selectdata(cfg_S1, x),dataset_filt,'UniformOutput',false);
    data_clean_S2  = cellfun(@(x) ft_selectdata(cfg_S2, x),dataset_filt,'UniformOutput',false);
    
    [data_ica_clean_S1,data_ica_clean_S2] = cellfun(@IBS_EEG_ICA,data_clean_S1,data_clean_S2,'UniformOutput', false);

    %% save the dataset
    IBS_save_datasets(Dyads(Dyd_no),data_ica_clean_S1,data_ica_clean_S2,analysis_type,save_dir)
    
    % save('D:\\Atesh\\IBS\\ASR_cleaned\\Dyd_23_ICA_cleaned_then_ASR_cleaned_cutoff_5.mat','data_ica_clean_S1','data_ica_clean_S2','-v7.3')
end

end












