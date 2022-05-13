function avg_cond = IBS_within_brain_analysis_lw(analysis_type,Dyads)
%% Atesh Koul

% checked that parallel processing for LW generates same results. although there was a bug that reveresed p and F values. 

if nargin <1
    analysis_type = 'no_aggressive_trialwise_CAR';
    %     analysis_type = 'no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR';
end

if nargin <2
    
    %     Dyads = [1:11 13:23];
    Dyads = 1:23;
    
end
% save_dir = 'D:\\Atesh\\IBS\\ASR_cleaned\\fft_ASR\\';
%%
analysis_type_params = IBS_get_params_analysis_type(analysis_type);
within_save_dir = analysis_type_params.within_save_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
CAR_performed = analysis_type_params.CAR_performed;

trial_nos = analysis_type_params.trial_nos;

mapObj = analysis_type_params.mapObj{1,1};

% for trial_no = 1:numel(trial_nos)
all_sub_S1_cond_data = cell(1,length(Dyads));
all_sub_S2_cond_data = cell(1,length(Dyads));
for Dyd_no = 1:length(Dyads)
    
    data = IBS_load_clean_IBS_data(Dyads(Dyd_no),analysis_type);
    cfg_remove_epoch = [];
    cfg_remove_epoch.toilim = [0 120];
    
    data_ica_clean_S1 = cellfun(@(x) ft_redefinetrial(cfg_remove_epoch,x),data.data_ica_clean_S1,'UniformOutput', false);
    data_ica_clean_S2 = cellfun(@(x) ft_redefinetrial(cfg_remove_epoch,x),data.data_ica_clean_S2,'UniformOutput', false);
    
    if ~CAR_performed
        disp('Perfoming Common Average Referencing (CAR)')
        [data_ica_clean_S1] = cellfun(@IBS_re_reference_data,data_ica_clean_S1,'UniformOutput', false);
        [data_ica_clean_S2] = cellfun(@IBS_re_reference_data,data_ica_clean_S2,'UniformOutput', false);
    end
    cfg_segment = [];
    cfg_segment.length = 5;
    cfg_segment.overlap = 0;
    
    data_S1 = cellfun(@(x) ft_redefinetrial(cfg_segment,x),data_ica_clean_S1,'UniformOutput', false);
    data_S2 = cellfun(@(x) ft_redefinetrial(cfg_segment,x),data_ica_clean_S2,'UniformOutput', false);
    
    data_S1 = cellfun(@(x) Giac_changeLabel(x,'remove','1-'),data_S1,'UniformOutput', false);
    data_S2 = cellfun(@(x) Giac_changeLabel(x,'remove','2-'),data_S2,'UniformOutput', false);
    
%     data_S1 = cellfun(@(x) Giac_changeLabel(x,'remove','1-'),data_ica_clean_S1,'UniformOutput', false);
%     data_S2 = cellfun(@(x) Giac_changeLabel(x,'remove','2-'),data_ica_clean_S2,'UniformOutput', false);
    
    subset_col_mat = @(x,y) x(:,1:y);
    fun = @(x) subset_col_mat(abs(fft(x,[],2))/(size(x,2)),size(x,2)/2);
    % fun = @(x) abs(fft(x,[],2));
    data_S1_fft_nomalized = cellfun(@(x) IBS_apply_fun_ft_struct(x,fun),data_S1,'UniformOutput', false);
    data_S2_fft_nomalized = cellfun(@(x) IBS_apply_fun_ft_struct(x,fun),data_S2,'UniformOutput', false);
    
    Hz = 95;
    crop_fun = @(x,Hz) subset_col_mat(x,Hz*2+1);
    crop_data_S1_fft_nomalized = cellfun(@(x) IBS_apply_fun_ft_struct(x,crop_fun,Hz),...
        data_S1_fft_nomalized,'UniformOutput', false);
    crop_data_S2_fft_nomalized = cellfun(@(x) IBS_apply_fun_ft_struct(x,crop_fun,Hz),...
        data_S2_fft_nomalized,'UniformOutput', false);
    
    
    crop_data_S1_fft_nomalized = cellfun(@(x) IBS_update_ft_struct(x,'time_range',[0 95]),crop_data_S1_fft_nomalized,'UniformOutput', false);
    crop_data_S2_fft_nomalized = cellfun(@(x) IBS_update_ft_struct(x,'time_range',[0 95]),crop_data_S2_fft_nomalized,'UniformOutput', false);
    
    data_cond_S1 = arrayfun(@(x) IBS_select_cond_from_cell_struct(crop_data_S1_fft_nomalized,trial_nos,x),...
        1:numel(trial_nos),'UniformOutput', false);
    data_cond_S2 = arrayfun(@(x) IBS_select_cond_from_cell_struct(crop_data_S2_fft_nomalized,trial_nos,x),...
        1:numel(trial_nos),'UniformOutput', false);
    
    
    
    avg_data_cond_S1 = cellfun(@(x) ft_timelockanalysis([],x),data_cond_S1,'UniformOutput', false);
    avg_data_cond_S2 = cellfun(@(x) ft_timelockanalysis([],x),data_cond_S2,'UniformOutput', false);
    
    
    all_sub_S1_cond_data{Dyd_no} = avg_data_cond_S1;
    all_sub_S2_cond_data{Dyd_no} = avg_data_cond_S2;
    
        saveFname_S1 = cellfun(@(x) strcat('Dyd_no_',num2str(Dyads(Dyd_no)),'_Sub_1_cond_',mapObj(num2str(unique(x.trialinfo)')),'_fft_crop_avg_5_sec'),...
        data_cond_S1,'UniformOutput', false);
    
    saveFname_S2 = cellfun(@(x) strcat('Dyd_no_',num2str(Dyads(Dyd_no)),'_Sub_2_cond_',mapObj(num2str(unique(x.trialinfo)')),'_fft_crop_avg_5_sec'),...
        data_cond_S2,'UniformOutput', false);
    
%     saveFname_S1 = cellfun(@(x) strcat('Dyd_no_',num2str(Dyads(Dyd_no)),'_Sub_1_cond_',mapObj(num2str(unique(x.trialinfo)')),'_fft_crop_avg'),...
%         data_cond_S1,'UniformOutput', false);
%     
%     saveFname_S2 = cellfun(@(x) strcat('Dyd_no_',num2str(Dyads(Dyd_no)),'_Sub_2_cond_',mapObj(num2str(unique(x.trialinfo)')),'_fft_crop_avg'),...
%         data_cond_S2,'UniformOutput', false);
    
    
    cellfun(@(x,y) rs_convert_ft2lw_V7(x,y,within_save_dir,[],[]),avg_data_cond_S1,saveFname_S1,'UniformOutput', false);
    cellfun(@(x,y) rs_convert_ft2lw_V7(x,y,within_save_dir,[],[]),avg_data_cond_S2,saveFname_S2,'UniformOutput', false);
    
end
% appending like this puts S2 at the end of S1.
% this has to be changed to bring all as seperate individuals
grandavgcond = cat(1,all_sub_S1_cond_data{:},all_sub_S2_cond_data{:});
cfg_grandavgcond = [];
cfg_grandavgcond.keepindividual = 'yes';
cfg_grandavgcond.parameter = 'avg';
avg_cond = arrayfun(@(x) ft_timelockgrandaverage(cfg_grandavgcond,grandavgcond{:,x}),...
    1:size(grandavgcond,2),'UniformOutput', false);

% fixing subject order
Dyads_combined = [1:2:2*length(Dyads) 2:2:2*length(Dyads)];
[~,sorted_order] = sort(Dyads_combined);

avg_cond = cellfun(@(x) IBS_sort_order(x,sorted_order),avg_cond,'UniformOutput', false);

% saveFname_avg_cond = arrayfun(@(x) strcat('merged_ft_script_',mapObj(num2str(trial_nos{x}))),...
%     1:numel(trial_nos),'UniformOutput', false);
saveFname_avg_cond = arrayfun(@(x) strcat('merged_ft_script_5_sec_',mapObj(num2str(trial_nos{x}))),...
    1:numel(trial_nos),'UniformOutput', false);

cellfun(@(x,y) rs_convert_ft2lw_V7(x,y,within_save_dir,[],[]),avg_cond,saveFname_avg_cond,'UniformOutput', false);


end
