function [results_S1,results_S2] = IBS_align_eeg_pupil_blinker(analysis_type,Dyads,conditions,varargin_table)


analysis_params = IBS_get_params_analysis_type(analysis_type);
raw_data_dir = analysis_params.raw_data_dir{1,1}; %'D:\\iannettilab_dropbox\\Dropbox\\Koul_Atesh\\IBS\\';
% Dyads = 1:3 ;
Subs = [0 1];
% condition = 'NeNoOcc_1';

% condition_map = {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'};
condition_map = {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3','Task_1','Task_2','Task_3'};

cur_stdThreshold = varargin_table.blink_EEG.stdThreshold;
% 
% mapObj = containers.Map(condition_map,...
%     {'31',  '32',  '33','51',  '52',  '53'});


mapObj = containers.Map(condition_map,...
    {'31',  '32',  '33','51',  '52',  '53','61','62','63'});
% delays_S1 = nan(length(Dyads),length(conditions),3);
% delays_S2 =  nan(length(Dyads),length(conditions),3);



condition_nos = find(contains(condition_map,conditions));
results_S1 = cell(length(Dyads),length(conditions));
results_S2 = cell(length(Dyads),length(conditions));

for Dyad_no = 1:length(Dyads)
    dataset = IBS_load_raw_sub_data(Dyads(Dyad_no),'blocks');
%     cfg_select.latency = [0 120];dataset = ft_selectdata(cfg_select,dataset);
    %% remove extra channels
%     dataset = IBS_remove_extra_chans(dataset);
    
    %% filter the data
    %     dataset = IBS_filter_raw_data(dataset);
    
    % otherwise there is out of memory error
    
    cfg_S1.channel = {'1-*'};
    cfg_S2.channel = {'2-*'};
    cfg_S1.latency = [0 120];
    cfg_S2.latency = [0 120];
    data_clean_S1  = ft_selectdata(cfg_S1,dataset);
    data_clean_S2  = ft_selectdata(cfg_S2,dataset);
    
    clear dataset dataset_filt
    for condition_no = 1:numel(condition_nos)
        
        
        
        
        %%
        trial_no = find(ismember(data_clean_S1.trialinfo,str2num(mapObj(conditions{condition_no}))));
        data_S1 = data_clean_S1.trial{1,trial_no}(1:64,:);
        data_times_S1 = data_clean_S1.time{1,1};
        
        data_S2 = data_clean_S2.trial{1,trial_no}(1:64,:); 
%         trial_no = find(ismember(data_ica_clean_S2{1,1}.trialinfo,str2num(mapObj(conditions{condition_no}))));
        %data_S2 = data_ica_clean_S2{1,1}.comp.trial{1,trial_no}(2,:);
        %data_times_S2 = data_ica_clean_S2{1,1}.comp.time{1,trial_no};
        data_times_S2 = data_clean_S2.time{1,1};
        
        [blink_data_EEG_S1,blinks_EEG_times_S1,blink_data_S1,blinks_EEG_S1] = IBS_blink_detect_EEG(data_S1,data_times_S1,Dyads(Dyad_no),varargin_table.blink_EEG);
        clear data_S1
        if Dyads(Dyad_no) == 1 && sum(condition_no == [2,3,4,5,6])>0 
            % for far near conditions
%              varargin_table.blink_EEG.goodRatioThreshold = 0.7;
%         varargin_table.blink_EEG.stdThreshold =1;
%         varargin_table.blink_EEG.blinkAmpRange= [1.5 50];%2.05
        % only for task condition
        varargin_table.blink_EEG.stdThreshold = cur_stdThreshold;
%         varargin_table.blink_EEG.blinkAmpRange= [];%2.05

        else 
            % reset it back to the input threshold
            varargin_table.blink_EEG.stdThreshold = cur_stdThreshold;
%             varargin_table.blink_EEG.blinkAmpRange= [];
        end
        if (Dyads(Dyad_no) == 1 && contains(conditions,'Task')) || (Dyads(Dyad_no) == 20 && contains(conditions,'Task'))
        varargin_table.blink_EEG.goodRatioThreshold = 0.95;
       varargin_table.blink_EEG.blinkAmpRange= [2.25 50];
        
        % for dyad 22 cond 2, threshold = 5 works - use multiple times to
        % get the blinks
        [blink_data_EEG_S2,blinks_EEG_times_S2,blink_data_S2,blinks_EEG_S2] = IBS_blink_detect_EEG(data_S2,data_times_S2,Dyads(Dyad_no),varargin_table.blink_EEG);
        % reset it again othewise bad consequences happen (06/07/2021
        % vaccine day :))
        varargin_table.blink_EEG.blinkAmpRange= [];
        varargin_table.blink_EEG.goodRatioThreshold = [];
        else
                    [blink_data_EEG_S2,blinks_EEG_times_S2,blink_data_S2,blinks_EEG_S2] = IBS_blink_detect_EEG(data_S2,data_times_S2,Dyads(Dyad_no),varargin_table.blink_EEG);

        end
        
        clear data_S2
        
        [blinks_start_time_S1,blinks_start_loc_S1,all_timepoints_S1] = IBS_blink_detect_eye_tracker(Dyads(Dyad_no),0,conditions{condition_no},raw_data_dir);
        
        [blinks_start_time_S2,blinks_start_loc_S2,all_timepoints_S2] = IBS_blink_detect_eye_tracker(Dyads(Dyad_no),1,conditions{condition_no},raw_data_dir);
        
        
        
        
        if ~isnan(blink_data_EEG_S1)
            results_S1{Dyads(Dyad_no),condition_nos(condition_no)} = IBS_blink_compute_lag(blinks_start_time_S1,blink_data_EEG_S1);
            results_S1{Dyads(Dyad_no),condition_nos(condition_no)}.blinks_EEG_times = blinks_EEG_times_S1;
            results_S1{Dyads(Dyad_no),condition_nos(condition_no)}.blink_data = blink_data_S1;
            results_S1{Dyads(Dyad_no),condition_nos(condition_no)}.blinks_EEG = blinks_EEG_S1;
            results_S1{Dyads(Dyad_no),condition_nos(condition_no)}.all_timepoints = all_timepoints_S1;
            results_S1{Dyads(Dyad_no),condition_nos(condition_no)}.blinks_start_loc = blinks_start_loc_S1;
        else
            results_S1{Dyads(Dyad_no),condition_nos(condition_no)}.delay_rms = nan;
            results_S1{Dyads(Dyad_no),condition_nos(condition_no)}.deviance_delay_rms = nan;
        end
        if ~isnan(blink_data_EEG_S2)
            results_S2{Dyads(Dyad_no),condition_nos(condition_no)} = IBS_blink_compute_lag(blinks_start_time_S2,blink_data_EEG_S2);
            results_S2{Dyads(Dyad_no),condition_nos(condition_no)}.blinks_EEG_times = blinks_EEG_times_S2;
            results_S2{Dyads(Dyad_no),condition_nos(condition_no)}.blink_data = blink_data_S2;
            results_S2{Dyads(Dyad_no),condition_nos(condition_no)}.blinks_EEG = blinks_EEG_S2;
            results_S2{Dyads(Dyad_no),condition_nos(condition_no)}.all_timepoints = all_timepoints_S2;
            results_S2{Dyads(Dyad_no),condition_nos(condition_no)}.blinks_start_loc = blinks_start_loc_S2;
%             IBS_blink_plot_results(results_S2,Dyads(Dyad_no),condition_nos(condition_no))
            [p,q] = sort(results_S2{Dyads(Dyad_no),condition_nos(condition_no)}.cur_delay);
            results_S2{Dyads(Dyad_no),condition_nos(condition_no)}.actual_delays(q)
        else
            results_S2{Dyads(Dyad_no),condition_nos(condition_no)}.delay_rms = nan;
            results_S2{Dyads(Dyad_no),condition_nos(condition_no)}.deviance_delay_rms = nan;
        end
        clear blink_data_EEG_S1 blink_data_EEG_S2 blink_data_S1 blink_data_S2 blinks_EEG_S1 blinks_EEG_S2
        
        %%
        
    end
    
end
end