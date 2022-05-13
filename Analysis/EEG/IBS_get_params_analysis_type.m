function [varargout_table] = IBS_get_params_analysis_type(data_analysis_type,analysis)
%% Atesh Koul


if nargin <2
    analysis = 'Power_correlation_analysis';
end
comp_name = getenv('computername');

baseline_start = 11:13;
FaOcc = [21 22 23];
FaNoOcc = [31 32 33];
NeOcc = [41 42 43];
NeNoOcc = [51 52 53];
Task = [61 62 63];
baseline_end = 71:73;

% important that the string is exact otherwise the values are not possible
% to obtain
mapObj = containers.Map({'11  12  13','21  22  23','31  32  33','41  42  43',...
    '51  52  53','61  62  63','71  72  73' },...
    {'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'});

trial_nos = {baseline_start, FaOcc,FaNoOcc, NeOcc, NeNoOcc, Task, baseline_end};


varargout_table = table();

%% within analysis
switch comp_name
    case 'DESKTOP-ALIEN'
        
        within_save_dir = 'E:\\Projects\\IBS\\Results\\EEG\\Within_analysis\\';
        
    case 'DESKTOP-79H684G'
        
        within_save_dir = 'D:\\Atesh\\IBS\\within_analysis\\';
        
end
within_save_dir = [within_save_dir data_analysis_type '\\'];


%% power correlation analysis
switch comp_name
    case 'DESKTOP-ALIEN'


                root_result_dir = 'E:\\Projects\\IBS\\Results\\EEG\\';

        data_dir = 'E:\\Projects\\IBS\\Data\\Processed\\';
        %                 save_dir = 'Y:\\Inter-brain synchrony\\Results\\EEG\\within_analysis\\';
        save_power_dir = 'E:\\Projects\\IBS\\Results\\EEG\\Power_correlation_analysis\\';
        save_connectivity_dir = 'E:\\Projects\\IBS\\Results\\EEG\\Connectivity_analysis\\';
        raw_data_dir = 'D:\\iannettilab_dropbox\\Dropbox\\Koul_Atesh\\IBS\\';
        
    case 'DESKTOP-79H684G'
        root_result_dir = 'D:\\Atesh\\IBS\\Data\\';
        data_dir = 'D:\\Atesh\\IBS\\Data\\';
        save_power_dir = 'D:\\Atesh\\IBS\\Data\\';
        save_connectivity_dir = 'D:\\Atesh\\IBS\\Data\\';
        raw_data_dir = 'Z:\\Dropbox\\Koul_Atesh\\IBS\\';
        
end
data_dir = [data_dir data_analysis_type '\\'];
save_power_dir = [save_power_dir data_analysis_type '\\'];
save_connectivity_dir = [save_connectivity_dir data_analysis_type '\\'];


analysis_save_dir = [root_result_dir analysis '\\' data_analysis_type '\\'];
analysis_save_dir_figures = [analysis_save_dir 'figures\\'];
switch(data_analysis_type)
    
    %% no_aggressive_trialwise_CAR
    case 'no_aggressive_trialwise_CAR'
        
        pre_trig_time = -1;
        post_trig_time = 120;
        CAR_performed = false;
        conditions = {'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'};
        %         lw_anova_fname = 'anova_F_values_no_aggressive_trialwise_Occ_Dist_2x2';
        
        contrasts = {'F value main Occ','F value main Dist','F value Interaction'};
        
        correlation_fname = [ save_power_dir 'trialwise_correlations_all_dyads_baseline_normchange_0_120s_CAR.mat'];
        Dyd_12_trials = 14;
        blocks = {'baseline_1','blocks','baseline_2'};
    case 'aggressive_trialwise_CAR'
        
        pre_trig_time = -1;
        post_trig_time = 120;
        CAR_performed = false;
        conditions = {'FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task'};
        
        %         lw_anova_fname = 'anova_F_values_aggressive_trialwise_Occ_Dist_2x2';
        contrasts = {'F value main Occ','F value main Dist','F value Interaction'};
        
        correlation_fname = [ save_power_dir 'trialwise_correlations_aggressive_ICA_all_dyads_baseline_normchange_0_120s_CAR.mat'];
        Dyd_12_trials = 14;
        blocks = {'blocks'};
        
        
        mapObj = containers.Map({'21  22  23','31  32  33','41  42  43',...
            '51  52  53','61  62  63'},...
            {'FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task'});
        
        trial_nos = { FaOcc,FaNoOcc, NeOcc, NeNoOcc, Task};
        
        
        
        
    case  'no_aggressive_CAR_ASR_5_ICA_appended_trials'
        
        pre_trig_time = -3;
        post_trig_time = 123;
        cutoff = 5;
        CAR_performed = true;
        %         lw_anova_fname = 'anova_F_values_no_aggressive_CAR_ASR_5_ICA_appended_trials_Occ_Dist_2x2';
        
        contrasts = {'F value main Occ','F value main Dist','F value Interaction'};
        
        conditions = {'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'};
        correlation_fname = [ save_power_dir 'trialwise_correlations_CAR_ASR_5_ICA_appended_trials_correlations_all_dyads_baseline_normchange_0_120s_CAR.mat'];
        %         correlation_fname = [ save_dir 'CAR_ASR_5_ICA_appended_trials_comp_CAR_trialwise_correlations_1_11_13_23_dyads_baseline_normchange_0_120s_CAR.mat'];
        Dyd_12_trials = 13;
        blocks = {'baseline_1','blocks','baseline_2'};
        varargout_table = addvars(varargout_table,cutoff);
        
        
    case  'no_aggressive_CAR_ASR_10_ICA_appended_trials'
        
        pre_trig_time = -3;
        post_trig_time = 123;
        cutoff = 10;
        CAR_performed = true;
        %         lw_anova_fname = 'anova_F_values_no_aggressive_CAR_ASR_10_ICA_appended_trials_Occ_Dist_2x2';
        
        contrasts = {'F value main Occ','F value main Dist','F value Interaction'};
        
        conditions = {'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'};
        correlation_fname = [ save_power_dir 'trialwise_correlations_CAR_ASR_10_ICA_appended_trials_correlations_all_dyads_baseline_normchange_0_120s_CAR.mat'];
        %         save_dir = [process_dir 'ASR_cleaned\\'];
        
        Dyd_12_trials = 13;
        blocks = {'baseline_1','blocks','baseline_2'};
        varargout_table = addvars(varargout_table,cutoff);
    case  'no_aggressive_CAR_ASR_20_ICA_appended_trials'
        
        pre_trig_time = -3;
        post_trig_time = 123;
        cutoff = 20;
        CAR_performed = true;
        %         lw_anova_fname = 'anova_F_values_no_aggressive_CAR_ASR_10_ICA_appended_trials_Occ_Dist_2x2';
        
        contrasts = {'F value main Occ','F value main Dist','F value Interaction'};
        
        conditions = {'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'};
        correlation_fname = [ save_power_dir 'trialwise_correlations_CAR_ASR_20_ICA_appended_trials_correlations_all_dyads_baseline_normchange_0_120s_CAR.mat'];
        %         save_dir = [process_dir 'ASR_cleaned\\'];
        
        Dyd_12_trials = 13;
        blocks = {'baseline_1','blocks','baseline_2'};
        varargout_table = addvars(varargout_table,cutoff);
    case  'no_aggressive_CAR_ASR_5_ICA_appended_trials_Dyad_12'
        
        pre_trig_time = -3;
        post_trig_time = 122;
        
end

pointwise_anova_fname = [ save_power_dir 'anova_correct_correlation_' data_analysis_type '.mat'];

lw_anova_fname = ['anova_F_values_' data_analysis_type '_Occ_Dist_2x2'];

%%


switch(contains(analysis,'fig'))
    %     case {'Power_correlation_analysis','Connectivity_analysis','Brain_behavior_glm','Moving_window'}
    case 0
        analysis_folder = analysis;
        add_pic_slide_fun_conds = @IBS_add_pic_slide;
        add_pic_slide_fun_anova = @IBS_addPicSlide;
        
        if strcmp(data_analysis_type,'aggressive_trialwise_CAR')
            plot_loc = 'multi_5';
        else
            plot_loc = 'multi_7';
        end
    case 1
        %     case {'Power_correlation_analysis_fig','Connectivity_analysis_fig'}
        analysis_folder = strrep(analysis,'_fig','');
        add_pic_slide_fun_conds = @IBS_add_pic_slide_fig;
        add_pic_slide_fun_anova = @IBS_addPicSlide_combined;
        
        if strcmp(data_analysis_type,'aggressive_trialwise_CAR')
            plot_loc = 'same_5';
        else
            plot_loc = 'same_7';
        end
        fig_conds = {'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Baseline end'};
        varargout_table = addvars(varargout_table,fig_conds);
        
end

varargout_table = addvars(varargout_table,{analysis_folder},{add_pic_slide_fun_conds},{plot_loc},{add_pic_slide_fun_anova},...
    'NewVariableNames',{'analysis_folder','add_pic_slide_fun_conds','plot_loc','add_pic_slide_fun_anova'});

%% Natural frequencies
nf_conditions = {'Baseline','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task'};
dat_mask_alpha = [1 0.01];
nf_Dyads = 1:23;


stim_time_s = {[0 59],[60 119]};
band_ranges = get_band_ranges('IBS');
switch(comp_name)
    case 'DESKTOP-ALIEN'
        nf_save_dir = ['E:\\Projects\\IBS\\Results\\EEG\\Natural_frequencies\\' data_analysis_type '\\'];
        Template_dir ='C:\Users\Atesh\OneDrive - Fondazione Istituto Italiano Tecnologia\Research projects 2020\Inter-brain synchrony\Libraries\IBS_matlab';
        
    case   'DESKTOP-79H684G'
        nf_save_dir = ['D:\\Atesh\\IBS\\Natural_frequencies\\' data_analysis_type '\\'];
        Template_dir = 'D:\\Atesh\\IBS\\Libraries\\IBS_matlab';
        
end

if numel(stim_time_s) <10
    pre_stim_id     = cell_2_name(stim_time_s);
else
    pre_stim_id = ['moving_win_' num2str(stim_time_s{1}(1,1)) num2str(stim_time_s{end}(1,1))];
end


if numel(band_ranges) <10
    band_id     = cell_2_name(band_ranges);
else
    band_id = ['all_bands_' num2str(band_ranges{1}(1,1)) '-' num2str(band_ranges{end}(1,1))];
end

varargout_table = addvars(varargout_table,nf_conditions,dat_mask_alpha,nf_Dyads,stim_time_s,band_ranges);
varargout_table = addvars(varargout_table,{Template_dir},{nf_save_dir},{pre_stim_id},{band_id},...
    'NewVariableNames',{'Template_dir','nf_save_dir','pre_stim_id','band_id'});



%% cluster results
% cluster_main_effects_fname = {[ 'cluster_plot_correlation_main_effects_Dist_' data_analysis_type ],[ 'cluster_plot_correlation_main_effects_Occ_' data_analysis_type ]};
% cluster_interaction_fname = [  'cluster_plot_correlation_interaction_' data_analysis_type ];
%
% cluster_stats_fname = [  'cluster_plot_correlation_stats_' data_analysis_type '.mat'];

cluster_main_effects_fname = {[ analysis_save_dir_figures 'cluster_plot_correlation_all_freq_anova_main_effects_Dist_' data_analysis_type ],[ analysis_save_dir_figures 'cluster_plot_correlation_all_freq_anova_main_effects_Occ_' data_analysis_type ]};
cluster_interaction_fname = [ analysis_save_dir_figures 'cluster_plot_correlation_all_freq_anova_interaction_' data_analysis_type ];

cluster_stats_fname = [ analysis_save_dir 'cluster_plot_correlation_stats_' data_analysis_type '.mat'];




varargout_table = addvars(varargout_table,{cluster_main_effects_fname},{cluster_interaction_fname},{cluster_stats_fname},...
    'NewVariableNames',{'cluster_main_effects_fname','cluster_interaction_fname','cluster_stats_fname'});

%% one way anova

cluster_main_effects_analysis = [ analysis_save_dir_figures 'cluster_plot_all_freq_main_effects_' analysis '_' data_analysis_type ];
cluster_stats_analysis = [analysis_save_dir 'cluster_stats_all_freq_' analysis '_' data_analysis_type '.mat'];


cluster_main_effects_freqwise_analysis = [ analysis_save_dir_figures 'cluster_plot_freqwise_main_effects_' analysis '_' data_analysis_type ];
cluster_stats_freqwise_analysis = [analysis_save_dir 'cluster_stats_freqwise_' analysis '_' data_analysis_type '.mat'];


varargout_table = addvars(varargout_table,{cluster_main_effects_analysis},{cluster_stats_analysis},{cluster_main_effects_freqwise_analysis},{cluster_stats_freqwise_analysis},...
    'NewVariableNames',{'cluster_main_effects_analysis','cluster_stats_analysis','cluster_main_effects_freqwise_analysis','cluster_stats_freqwise_analysis'});


%% coherence analysis

coherence_fname = [ save_connectivity_dir 'coherence_analysis_' data_analysis_type '.mat'];

varargout_table = addvars(varargout_table,{coherence_fname},'NewVariableNames',{'coherence_fname'});
%% cluster freqwise

cluster_freq_table = table();
cluster_freq_table.delta = {[1 2] [2 3]};
cluster_freq_table.theta = {[3 4] [ 5 6] [7 8]};
cluster_freq_table.alpha = {[8 9] [ 10 11] [11 12]};
cluster_freq_table.beta = {[13 18] [ 19 25] [26 31]};
cluster_freq_table.gamma = {[31 47] [52 72] [73 95]};


varargout_table = addvars(varargout_table,cluster_freq_table);

cluster_main_effects_freqwise_fname = {[ analysis_save_dir_figures 'cluster_plot_correlation_freqwise_anova_main_effects_Dist_' data_analysis_type ],[ analysis_save_dir_figures 'cluster_plot_correlation_freqwise_anova_main_effects_Occ_' data_analysis_type ]};
cluster_interaction_freqwise_fname = [ analysis_save_dir_figures 'cluster_plot_correlation_freqwise_anova_interaction_' data_analysis_type ];


cluster_main_effects_freqwise_fnames = cellfun(@(x) cellfun(@(y) [y '_' x],cluster_main_effects_freqwise_fname,...
    'UniformOutput',false),cluster_freq_table.Properties.VariableNames,'UniformOutput',false);

cluster_interaction_freqwise_fnames = cellfun(@(x) [cluster_interaction_freqwise_fname '_' x],...
    cluster_freq_table.Properties.VariableNames,'UniformOutput',false);


cluster_stats_freqwise_fname = [ analysis_save_dir 'cluster_plot_correlation_freqwise_stats_' data_analysis_type '.mat'];
varargout_table = addvars(varargout_table,{cluster_main_effects_freqwise_fname},{cluster_interaction_freqwise_fname},{cluster_stats_freqwise_fname},...
    'NewVariableNames',{'cluster_main_effects_freqwise_fname','cluster_interaction_freqwise_fname','cluster_stats_freqwise_fname'});

%%

cluster_t_effects_baseline_freqwise_fname = [ analysis_save_dir_figures 'cluster_plot_correlation_freqwise_t_effects_baseline_' data_analysis_type];
cluster_t_stats_baseline_freqwise_fname = [ analysis_save_dir 'cluster_plot_correlation_freqwise_t_stats_' data_analysis_type '.mat'];

varargout_table = addvars(varargout_table,{cluster_t_effects_baseline_freqwise_fname},{cluster_t_stats_baseline_freqwise_fname},...
    'NewVariableNames',{'cluster_t_effects_baseline_freqwise_fname','cluster_t_stats_baseline_freqwise_fname'});


%%
switch(analysis)
    case 'Dyad_classification_sex'
        
        % female-female [1,5,7,8,12,13,19,22] males [2,4,9,14,16] % male-female [3,6,10,11,15,17,18,20,21,23]
        sub_group_f_f = [1,5,7,8,12,13,19,22];
        sub_group_f_m = [3,6,10,11,15,17,18,20,21,23];
        sub_group_m_m = [2,4,9,14,16];
        
        all_sub = nan(1,23);
        all_sub(sub_group_f_f) = 1;
        all_sub(sub_group_f_m) = 2;
        all_sub(sub_group_m_m) = 3;
        
        levels = table();
        %     levels.Between = [repmat(1,1,8) repmat(2,1,10) repmat(3,1,5)];
        levels.Between = all_sub;
        levels.Within = [1 2];
        
        
        
        anova_table = table();
        anova_table.anova_design = '3x2';
        anova_table.test_type = {'one_way_anova_independent','two_sample_paired'};
        anova_table.main_effect_names = {'_sex_group','_FaNoOcc_NeNoOcc'};
        anova_table.behavior = 0;
        varargout_table = addvars(varargout_table,sub_group_f_f,sub_group_f_m,sub_group_m_m);
        
        
        varargout_table = addvars(varargout_table,levels,anova_table);
        
    case 'Dyad_classification_romantic'
        
        % female-female [1,5,7,8,12,13,19,22] males [2,4,9,14,16] % male-female [3,6,10,11,15,17,18,20,21,23]
        sub_group_romantic = [1,9,11,18,20,21];
        sub_group_friends = [2,3,4,5,6,7,8,10,12,13,14,15,16,17,19,22,23];
        
        all_sub = nan(1,23);
        all_sub(sub_group_romantic) = 1;
        all_sub(sub_group_friends) = 2;
        
        levels = table();
        %     levels.Between = [repmat(1,1,8) repmat(2,1,10) repmat(3,1,5)];
        levels.Between = all_sub;
        levels.Within = [1 2];
        
        
        
        anova_table = table();
        anova_table.anova_design = '2x2';
        anova_table.test_type = {'two_sample_independent','two_sample_paired'};
        anova_table.main_effect_names = {'_romantic_group','_FaNoOcc_NeNoOcc'};
        anova_table.behavior = 0;
        varargout_table = addvars(varargout_table,sub_group_romantic,sub_group_friends);
        
        
        varargout_table = addvars(varargout_table,levels,anova_table);
        
    case 'Dyad_classification_smile'
        % smile 1 all trials
        sub_group_1 = [2     5     6     8    10    12    13    17    18    21    23];
        sub_group_2 = [1     3     4     7     9    14    15    16    19    20    22];
        %         %joint
        %         sub_group_1 = [1     2     5     6     8    10    11    12    13    18    23];
        %         sub_group_2 = [3     4     7     9    14    15    16    19    20    21    22 ];
        % %         just first trial smile 1
        %         sub_group_1 = [1     2     5     6     8    13    14    16    18    19    23];
        %         sub_group_2 = [3     4     7     9    11    12    15    17    20    21    22];
        
        % %         just first trial smile 2
        %         sub_group_1 = [1     2     5     6    11    12    13    14    18    20    23];
        %         sub_group_2 = [3     4     7     8     9    15    16    17    19    21    22];
        %smile 2
        %         sub_group_1 = [1     2     5     6     8    11    12    13    18    20    23];
        %         sub_group_2 = [ 3     4     7     9    14    15    16    17    19    21    22];
        % smile 1> median all smile values (smile 1 and 2) works for only
        % NeNoOcc
        %                 sub_group_1 = [2     5     6     8    10    11    12    13    17    18    21    23];
        %                 sub_group_2 = [1     3     4     7     9    14    15    16    19    20    22];
        % smile 2> median all smile values (smile 1 and 2)
        %         sub_group_1 = [1     2     5     6     8    11    12    13    18    20    23];
        %         sub_group_2 = [3     4     7     9    10    14    15    16    17    19    21    22];
        
        
        all_sub = nan(1,23);
        all_sub(sub_group_1) = 1;
        all_sub(sub_group_2) = 2;
        
        levels = table();
        %     levels.Between = [repmat(1,1,8) repmat(2,1,10) repmat(3,1,5)];
        levels.Between = all_sub;
        levels.Within = [1 2];
        anova_table = table();
        anova_table.anova_design = '2x3';
        anova_table.test_type = {'two_sample_independent','two_sample_paired'};
        anova_table.main_effect_names = {'_smile_group','_FaNoOcc_NeNoOcc'};
        anova_table.behavior = 1;
        varargout_table = addvars(varargout_table,sub_group_1,sub_group_2);
        varargout_table = addvars(varargout_table,levels,anova_table);
        
        
        
    case 'Dyad_classification_eye_on_face'
        
        
        sub_group_1 = [1,9,11,18,20,21,6];
        sub_group_2 = [7,8,10,12,15,16,17,22,19,16,13,23];
        varargout_table = addvars(varargout_table,sub_group_1,sub_group_2);
        
        all_sub = nan(1,23);
        all_sub(sub_group_1) = 1;
        all_sub(sub_group_2) = 2;
        
        levels = table();
        %     levels.Between = [repmat(1,1,8) repmat(2,1,10) repmat(3,1,5)];
        levels.Between = all_sub;
        levels.Within = [1 2];
        
        
        anova_table = table();
        anova_table.anova_design = '2x3';
        anova_table.test_type = {'two_sample_independent','two_sample_paired'};
        anova_table.main_effect_names = {'_eye_on_face_group','_FaNoOcc_NeNoOcc'};
        anova_table.behavior = 1;
        varargout_table = addvars(varargout_table,sub_group_1,sub_group_2);
        varargout_table = addvars(varargout_table,levels,anova_table);
end
%%
varargout_table = addvars(varargout_table,trial_nos);
varargout_table = addvars(varargout_table,{mapObj},'NewVariableNames','mapObj');
varargout_table = addvars(varargout_table,{save_power_dir},{data_dir},{within_save_dir},...
    {lw_anova_fname},{correlation_fname},{pointwise_anova_fname},{root_result_dir},{analysis_save_dir},...
    {analysis_save_dir_figures},{raw_data_dir},'NewVariableNames',{'save_dir','data_dir',...
    'within_save_dir','lw_anova_fname','correlation_fname','pointwise_anova_fname',...
    'root_result_dir','analysis_save_dir','analysis_save_dir_figures','raw_data_dir'});
varargout_table = addvars(varargout_table,conditions,CAR_performed,contrasts,pre_trig_time,post_trig_time,...
    Dyd_12_trials,blocks);

end


%         switch comp_name
%             case 'DESKTOP-ALIEN'
%                 data_dir = 'E:\\Projects\\IBS\\Data\\Processed\\';
%                 %                 save_dir = 'Y:\\Inter-brain synchrony\\Results\\EEG\\within_analysis\\';
%                 save_dir = 'E:\\Projects\\IBS\\Results\\EEG\\Power_correlation_analysis\\no_aggressive_trialwise_CAR\\';
%                 within_save_dir = 'E:\\Projects\\IBS\\Results\\EEG\\Within_analysis\\no_aggressive_trialwise_CAR\\';
%
%             case 'DESKTOP-79H684G'
%                 data_dir = 'D:\\Atesh\\IBS\';
%                 save_dir = 'D:\\Atesh\\IBS\\';
%                 within_save_dir = 'D:\\Atesh\\IBS\\within_analysis\\no_aggressive_trialwise_CAR\\';
%
%         end

%         switch comp_name
%             case 'DESKTOP-ALIEN'
%                 data_dir = 'E:\\Projects\\IBS\\Data\\Processed\\';
%                 %                 save_dir = 'Y:\\Inter-brain synchrony\\Results\\EEG\\within_analysis\\';
%                 save_dir = 'E:\\Projects\\IBS\\Results\\EEG\\Power_correlation_analysis\\aggressive_trialwise_CAR\\';
%                 within_save_dir = 'E:\\Projects\\IBS\\Results\\EEG\\Within_analysis\\aggressive_trialwise_CAR\\';
%
%             case 'DESKTOP-79H684G'
%                 data_dir = 'D:\\Atesh\\IBS\\Data\\';
%                 save_dir = 'D:\\Atesh\\IBS\\Data\\';
%                 within_save_dir = 'D:\\Atesh\\IBS\\within_analysis\\aggressive_trialwise_CAR\\';
%
%         end

%         switch comp_name
%             case 'DESKTOP-ALIEN'
%                 data_dir = 'D:\\Experiments\\IBS\\Processed\\EEG\\';
%                 save_dir = 'E:\\Projects\\IBS\\Results\\EEG\\Power_correlation_analysis\\no_aggressive_CAR_ASR_5_ICA_appended_trials\\';
%                 within_save_dir = 'E:\\Projects\\IBS\\Results\\EEG\\Within_analysis\\no_aggressive_CAR_ASR_5_ICA_appended_trials\\';
%             case 'DESKTOP-79H684G'
%                 data_dir = 'D:\\Atesh\\IBS\\Data\\';
%                 save_dir = 'D:\\Atesh\\IBS\\Data\\';
%                 within_save_dir = 'D:\\Atesh\\IBS\\within_analysis\\ASR_cleaned\\';
%
%         end
%         switch comp_name
%             case 'DESKTOP-ALIEN'
%                 data_dir = 'E:\\Projects\\IBS\\Data\\Processed\\';
%                 save_dir = 'E:\\Projects\\IBS\\Results\\EEG\\Power_correlation_analysis\\no_aggressive_CAR_ASR_5_ICA_appended_trials\\';
%                 within_save_dir = 'E:\\Projects\\IBS\\Results\\EEG\\Within_analysis\\no_aggressive_CAR_ASR_5_ICA_appended_trials\\';
%
%             case 'DESKTOP-79H684G'
%                 data_dir = 'D:\\Atesh\\IBS\\Data\\';
%                 save_dir = 'D:\\Atesh\\IBS\\Data\\';
%                 within_save_dir = 'D:\\Atesh\\IBS\\within_analysis\\no_aggressive_CAR_ASR_5_ICA_appended_trials\\';
%
%         end



%         switch comp_name
%             case 'DESKTOP-ALIEN'
%                 save_dir = 'E:\\Projects\\IBS\\Results\\EEG\\Power_correlation_analysis\\no_aggressive_CAR_ASR_10_ICA_appended_trials\\';
%                 data_dir = 'E:\\Projects\\IBS\\Data\\Processed\\';
%                 within_save_dir = 'E:\\Projects\\IBS\\Results\\EEG\\Within_analysis\\no_aggressive_CAR_ASR_10_ICA_appended_trials\\';
%
%             case 'DESKTOP-79H684G'
%                 save_dir = 'D:\\Atesh\\IBS\\Data\\';
%                 data_dir = 'D:\\Atesh\\IBS\\Data\\';
%                 within_save_dir = 'D:\\Atesh\\IBS\\within_analysis\\no_aggressive_CAR_ASR_10_ICA_appended_trials\\';
%
%         end
% switch(analysis_type)
%     % these are old wrong correlation analyses
%     % correlation_fname = 'D:\\Experiments\\IBS\\Processed\\EEG\\correlations_1_11_13_18_20_23_dyads_CAR.mat';
%     % correlation_fname = 'D:\\Experiments\\IBS\\Processed\\EEG\\correlations_1_11_13_18_20_23_dyads_baseline_rel_0_120s_CAR.mat';
%     % correlation_fname = 'D:\\Experiments\\IBS\\Processed\\EEG\\Only_eye_artefacts\\correlations_1_11_13_18_20_23_dyads_baseline_normchange_0_120s_NoCAR.mat';
%
%     % correlation_fname = 'D:\\Experiments\\IBS\\Processed\\EEG\\Only_eye_artefacts\\correlations_1_11_13_18_20_23_dyads_baseline_normchange_0_120s_CAR.mat';
%     % correlation_fname = 'D:\\Experiments\\IBS\\Processed\\EEG\\correlations_1_11_13_18_20_23_dyads_muscle_baseline_normchange_0_120s_NoCAR.mat';
%     % correlation_fname = 'D:\\Experiments\\IBS\\Processed\\EEG\\correlations_1_11_13_18_20_23_dyads_muscle_baseline_normchange_0_120s_CAR.mat';
%
%     case 'aggressive_trialwise_NoCAR'
%         conditions = {'FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task'};
%
%         correlation_fname = [process_dir 'trialwise_correlations_1_11_13_18_20_23_dyads_muscle_baseline_normchange_0_120s_NoCAR.mat'];
%
%     case 'aggressive_trialwise_CAR'
%         conditions = {'FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task'};
%
%         correlation_fname = 'D:\\Experiments\\IBS\\Processed\\EEG\\trialwise_correlations_1_11_13_18_20_23_dyads_muscle_baseline_normchange_0_120s_CAR.mat';
%
%     case 'no_aggressive_trialwise_CAR'
%         conditions = {'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'};
%
%         correlation_fname = [ process_dir 'trialwise_correlations_1_11_13_18_20_23_dyads_baseline_normchange_0_120s_CAR.mat'];
%     case 'no_aggressive_trialwise_NoCAR'
%         conditions = {'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'};
%         save_dir = [process_dir 'Only_eye_artefacts\\'];
%
%         correlation_fname = [process_dir 'trialwise_correlations_1_11_13_18_20_23_dyads_baseline_normchange_0_120s_NoCAR.mat'];
%     case 'no_aggressive_ASR_clean_trialwise_CAR'
%         conditions = {'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'};
%         correlation_fname = [ process_dir 'ASR_clean_trialwise_correlations_1_11_13_18_20_23_dyads_baseline_normchange_0_120s_CAR.mat'];
%         save_dir = [process_dir 'ASR_cleaned\\'];
%
%     case 'no_aggressive_ASR_re_notch_clean_trialwise_CAR'
%         conditions = {'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'};
%         correlation_fname = [ process_dir 'ASR_clean_re_notch_trialwise_correlations_1_11_13_18_20_23_dyads_baseline_normchange_0_120s_CAR.mat'];
%         save_dir = [process_dir 'ASR_cleaned\\'];
%     case 'no_aggressive_ASR_8_clean_trialwise_CAR'
%         conditions = {'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'};
%         correlation_fname = [ process_dir 'ASR_clean_8_trialwise_correlations_1_11_13_18_20_23_dyads_baseline_normchange_0_120s_CAR.mat'];
%         save_dir = [process_dir 'ASR_cleaned\\'];
%          case 'no_aggressive_ASR_20_clean_trialwise_CAR'
%         conditions = {'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'};
%         correlation_fname = [ process_dir 'ASR_clean_20_trialwise_correlations_1_11_13_18_20_23_dyads_baseline_normchange_0_120s_CAR.mat'];
%         save_dir = [process_dir 'ASR_cleaned\\'];
%
%    case 'no_aggressive_CAR_ASR_5_ICA_appended_trials_comp_CAR'

% end

%     %% no_aggressive_ASR_8_clean_trialwise_CAR
%     case 'no_aggressive_ASR_8_clean_trialwise_CAR'
%         switch comp_name
%             case 'DESKTOP-ALIEN'
%                 save_dir = 'Y:\\Inter-brain synchrony\\Results\\EEG\\power correlations\\ASR_cleaned\\';
%             case 'DESKTOP-79H684G'
%                 save_dir = 'Z:\\Dropbox\\Koul_Atesh\\IBS\\';
%
%         end
%         varargout_table = addvars(varargout_table,{save_dir},'NewVariableNames','save_dir');
%


%     case 'no_aggressive_ASR_20_clean_trialwise_CAR'
%         switch comp_name
%             case 'DESKTOP-ALIEN'
%                 save_dir = 'D:\\Experiments\\IBS\\Processed\\EEG\\';
%             case 'DESKTOP-79H684G'
%                 save_dir = 'D:\\Atesh\\IBS\\ASR_cleaned\\';
%
%         end
%         cutoff = 20;
%         CAR_performed = true;
%
%         conditions = {'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'};
%
%         varargout_table = addvars(varargout_table,{save_dir},'NewVariableNames','save_dir');
%         varargout_table = addvars(varargout_table,cutoff,conditions,CAR_performed);

%
%
%         varargout_table = addvars(varargout_table,{save_dir},'NewVariableNames','save_dir');
%         varargout_table = addvars(varargout_table,{data_dir},'NewVariableNames','data_dir');
%         varargout_table = addvars(varargout_table,{within_save_dir},'NewVariableNames','within_save_dir');
%         varargout_table = addvars(varargout_table,{lw_anova_fname},'NewVariableNames','lw_anova_fname');
%         varargout_table = addvars(varargout_table,{correlation_fname},'NewVariableNames','correlation_fname');