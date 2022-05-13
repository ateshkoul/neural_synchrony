%% A function to load the IBS dataset
function [dataset] = save_exported_IBS_data()


% Dyads = [1 2 3 4 5];
% Dyads = [1:11 13:18 20:23];

Dyads = [23];

blocks = {'baseline_1','blocks','baseline_2'};
% blocks = {'blocks'};
comp_name = getenv('computername');

switch comp_name
    case 'DESKTOP-ALIEN'
processed_dir = 'D:\\Experiments\\IBS\\Processed\\EEG\\raw_unfiltered\\';
case 'DESKTOP-79H684G'
    processed_dir = 'X:\\Experiments\\IBS\\Processed\\EEG\\raw_unfiltered\\';

end
for Dyd_no = 1:length(Dyads)
    %% load the raw data first
    % ('UniformOutput', false) is requred for next steps
    dataset = cellfun(@(x) IBS_load_raw_sub_data(Dyads(Dyd_no),x),blocks,'UniformOutput', false);
    
    dataset = cellfun(@IBS_resampledata,dataset,'UniformOutput', false);
    
    %% clean the dataset
    
    %% remove extra channels
    dataset = cellfun(@IBS_remove_extra_chans,dataset,'UniformOutput', false);
    
    
    %% separate the datasets
    cfg_S1.channel = {'1-*','-1-EXG*'};
    cfg_S2.channel = {'2-*','-2-EXG*'};
    data_S1  = cellfun(@(x) ft_selectdata(cfg_S1, x),dataset,'UniformOutput',false);
    data_S2  = cellfun(@(x) ft_selectdata(cfg_S2, x),dataset,'UniformOutput',false);
    %% save the dataset
    IBS_save_datasets(Dyads(Dyd_no),data_S1,data_S2,'raw_unfiltered',processed_dir)
end