%% A function to load the IBS dataset
function [dataset] = save_cleaned_IBS_data()


% Dyads = [1 2 3 4 5];
Dyads = [1:11 13:18 20:23];

% Dyads = [12 19];

blocks = {'baseline_1','blocks','baseline_2'};
% blocks = {'blocks'};

for Dyd_no = 1:length(Dyads)
    %% load the raw data first
    % ('UniformOutput', false) is requred for next steps
    dataset = cellfun(@(x) IBS_load_raw_sub_data(Dyads(Dyd_no),x),blocks,'UniformOutput', false);
    
%     dataset = cellfun(@IBS_resampledata,dataset,'UniformOutput', false);

    %% clean the dataset
    
    %% remove extra channels
    dataset = cellfun(@IBS_remove_extra_chans,dataset,'UniformOutput', false);
    
    %% filter the data
    dataset_filt = cellfun(@IBS_filter_raw_data,dataset,'UniformOutput', false);

    % otherwise there is out of memory error
    clear dataset
    % Interpolate and ICA
    % checked that while interpolating, the interpolation used is only
    % using the electrodes of the specific subject in the dyad. not all of
    % them - unless u try to remove wrong channels from wrong participant
    [data_ica_clean_S1,data_ica_clean_S2] = cellfun(@IBS_EEG_CleanSignal,dataset_filt,'UniformOutput', false);
    

    %% save the dataset
    IBS_save_datasets(Dyads(Dyd_no),data_ica_clean_S1,data_ica_clean_S2)


end

end












