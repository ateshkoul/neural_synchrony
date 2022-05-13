function []= IBS_asr_clean_combined_trials(analysis_type,Dyads)

% 'no_aggressive_ASR_no_notch_clean_trialwise_CAR'
if nargin <2
    Dyads = [1:11 13:18 20:23];
end

if nargin <1
%     analysis_type = 'no_aggressive_trialwise_CAR';
    analysis_type = ' no_aggressive_CAR_ASR_5_ICA_appended_trials';
end

analysis_type_params = IBS_get_params_analysis_type(analysis_type);
processed_dir = analysis_type_params.data_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';



blocks = {'baseline_1','blocks','baseline_2'};

% blocks = {'blocks'};


% pre_trig_time = -6;
% have to reduce this because if I keep 125, in some of the recordings of baseline,
% there are only 2 trials

% Dyd 07 has issues with -4 124
pre_trig_time = -3;

post_trig_time = 123;

for Dyd_no = 1:length(Dyads)
    
    %% load the raw data first
    % ('UniformOutput', false) is requred for next steps
    dataset = cellfun(@(x) IBS_load_raw_sub_data(Dyads(Dyd_no),x,pre_trig_time,post_trig_time,analysis_type),blocks,'UniformOutput', false);
    
%     input('proceed');
    %     dataset = cellfun(@IBS_resampledata,dataset,'UniformOutput', false);
    
    %% clean the dataset
    
    %% remove extra channels
    dataset = cellfun(@IBS_remove_extra_chans,dataset,'UniformOutput', false);
    
    dataset_filt = cellfun(@IBS_filter_raw_data,dataset,'UniformOutput', false);
    
    dataset_filt = cellfun(@IBS_EEG_Interpolate,dataset_filt,'UniformOutput', false);
    
    %     dataset = cellfun(@IBS_filter_no_notch_raw_data,dataset,'UniformOutput', false);
    
    %% separate the datasets
    cfg_S1.channel = {'1-*','-1-EXG*'};
    cfg_S2.channel = {'2-*','-2-EXG*'};
    data_S1  = cellfun(@(x) ft_selectdata(cfg_S1, x),dataset_filt,'UniformOutput',false);
    data_S2  = cellfun(@(x) ft_selectdata(cfg_S2, x),dataset_filt,'UniformOutput',false);
    
    cfg_S1_eye.channel = {'1-EXG4*'};
    cfg_S2_eye.channel = {'2-EXG1*'};
    data_S1_eye  = cellfun(@(x) ft_selectdata(cfg_S1_eye, x),dataset_filt,'UniformOutput',false);
    data_S2_eye  = cellfun(@(x) ft_selectdata(cfg_S2_eye, x),dataset_filt,'UniformOutput',false);  
    
    
    
    if ~contains(analysis_type,'NoCAR')
        disp('Perfoming Common Average Referencing (CAR)')
        [data_S1] = cellfun(@IBS_re_reference_data,data_S1,'UniformOutput', false);
        [data_S2] = cellfun(@IBS_re_reference_data,data_S2,'UniformOutput', false);
        
    end
    
    data_clean_S1 = cellfun(@(x) IBS_clean_asr_combined_trials_ft_struct(x,analysis_type_params.cutoff),data_S1,'UniformOutput', false);
    data_clean_S2 = cellfun(@(x) IBS_clean_asr_combined_trials_ft_struct(x,analysis_type_params.cutoff),data_S2,'UniformOutput', false);
    
    
    
    cfg_append = [];
    data_clean_S1  = cellfun(@(x,y) ft_appenddata(cfg_append, x,y),data_clean_S1,data_S1_eye,'UniformOutput',false);
    data_clean_S2  = cellfun(@(x,y) ft_appenddata(cfg_append, x,y),data_clean_S2,data_S2_eye,'UniformOutput',false);
    
    
    [data_clean_S1,data_clean_S2] = cellfun(@IBS_EEG_ICA,data_clean_S1,data_clean_S2,'UniformOutput', false);
    
    
    cfg_latency.latency = [-1 120];
    data_clean_S1  = cellfun(@(x) ft_selectdata(cfg_latency, x),data_clean_S1,'UniformOutput',false);
    data_clean_S2  = cellfun(@(x) ft_selectdata(cfg_latency, x),data_clean_S2,'UniformOutput',false);
    
    
    
    IBS_save_datasets(Dyads(Dyd_no),data_clean_S1,data_clean_S2,analysis_type,processed_dir)
%     save('D:\\Atesh\\IBS\\ASR_cleaned\\Dyd_23_CAR_ASR_cleaned_cutoff_5_then_ICA_cleaned.mat','data_clean_S1','data_clean_S2','-v7.3')
    

    
end
end