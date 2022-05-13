
function [Task_baseline_ttest] = IBS_power_t_stats_freqwise(data_analysis_type,analysis,cor_fun,varargin_table)
%% Atesh

% 14-12-2020


if nargin <1
    data_analysis_type = 'no_aggressive_trialwise_CAR';
end
if nargin <2
    analysis = 'Power_correlation_analysis';
    varargin_table = table();
    varargin_table.measure = 'corr';
end

if nargin <3
    cor_fun = @IBS_tf_correlations;% IBS_process_tf_connectivity
    
end


try
    plot_type = varargin_table.plot_type;
catch
    varargin_table.plot_type = 'topoplots';
end


cur_func_params = {'plot_type','measure'};

varargin_cell = table2cell(removevars(varargin_table,cur_func_params));


%%




cluster_t_effects_baseline_freqwise_fname = IBS_get_params_analysis_type(data_analysis_type,analysis).cluster_t_effects_baseline_freqwise_fname{1,1};


cluster_t_stats_baseline_freqwise_fname = IBS_get_params_analysis_type(data_analysis_type,analysis).cluster_t_stats_baseline_freqwise_fname{1,1};
%% cluster based



cluster_t_effects_baseline_freqwise_fname = IBS_update_stat_fname(cluster_t_effects_baseline_freqwise_fname,data_analysis_type,cor_fun,varargin_table);
cluster_t_stats_baseline_freqwise_fname = IBS_update_stat_fname(cluster_t_stats_baseline_freqwise_fname,data_analysis_type,cor_fun,varargin_table);


%%
if exist(cluster_t_stats_baseline_freqwise_fname,'file')
    
    cur_analysis_type = data_analysis_type;
    load(cluster_t_stats_baseline_freqwise_fname,'t_stats','test_cond','pair_test_conds','paired_t_tests','data_analysis_type','vision_stat','Task_baseline_ttest','cluster_freq_table','NeNoOcc_Task_ttest');
    assert(strcmp(cur_analysis_type,data_analysis_type) ==1);
        cluster_t_effects_conds_freqwise_fname = cellfun(@(x) strrep(cluster_t_effects_baseline_freqwise_fname,'baseline',[x '_baseline']),...
        test_cond,'UniformOutput',0);
    
else
    
    
    cluster_freq_table = IBS_get_params_analysis_type(data_analysis_type).cluster_freq_table;
    
    mean_col_mat = @(x,a,b) mean(x(:,a:b),2);
    
    
    [correlations_cell,cond] = cor_fun(data_analysis_type,varargin_cell{:});
    %     [correlations_cell1,cond] = IBS_tf_correlations_trialwise(1,analysis_type);
    
    combined_correlations = cat(1,correlations_cell{:});
    % this function averages for all the subjects and all conditions i.e.
    % for all chan x freq
    avg_freq_data = varfun(@(z) cellfun(@(t) cellfun(@(y) mean_col_mat(y,t(1),t(2)),combined_correlations,'UniformOutput', false),...
        z,'UniformOutput', false),cluster_freq_table);
    
    
    
    % this statement took sooooo long to get!!
    combined_avg_freq = table2cell(varfun(@(z) cellfun(@(x,varargin) [x varargin{:}],z{:},'UniformOutput',false),avg_freq_data));
    
    combined_avg_all_freq = arrayfun(@(z) cellfun(@(x,varargin) [x varargin{:}], combined_avg_freq{z,:}, 'UniformOutput', false),[1:size(combined_avg_freq,1)]','UniformOutput',false);
    
    combined_correlations = cat(1,combined_avg_all_freq{:});
    
    
    test_freq = table2array(varfun(@(x) cellfun(@(y) y(1),x,'uniformOutput',false),cluster_freq_table));
    test_freq = cat(2,test_freq{:});
    test_cond = {'FaOcc','FaNoOcc','NeOcc', 'NeNoOcc' };
    
    levels = [repmat(1,1,size(combined_correlations,1)) repmat(2,1,size(combined_correlations,1))];
    baseline_start_loc = find(strcmp(cond,'Baseline start'));
    baseline_end_loc = find(strcmp(cond,'Baseline end'));
    test_type = 'paired';
    t_stats = cell(1,length(test_cond));
    [stat_baseline] = IBS_cluster_two_sample(combined_correlations(:,[baseline_end_loc baseline_start_loc]),test_freq,levels,test_type);
    
    
    combined_baseline  = combined_correlations(:,[baseline_start_loc baseline_end_loc]);
    combined_baseline_cond = arrayfun(@(x) mean(cat(3,combined_baseline{x,:}),3), ...
        1:size(combined_baseline,1),'UniformOutput',0);
    
    cluster_t_effects_conds_freqwise_fname = cellfun(@(x) strrep(cluster_t_effects_baseline_freqwise_fname,'baseline',[x '_baseline']),...
        test_cond,'UniformOutput',0);
    
    FaNoOcc_loc = find(strcmp(cond,'FaNoOcc'));
    NeNoOcc_loc = find(strcmp(cond,'NeNoOcc'));
    
    combined_vision  = combined_correlations(:,[FaNoOcc_loc NeNoOcc_loc]);
    combined_vision_cond = arrayfun(@(x) mean(cat(3,combined_vision{x,:}),3), ...
        1:size(combined_vision,1),'UniformOutput',0);
    test_type = 'paired';
    [vision_stat] = IBS_cluster_two_sample(cat(2,combined_vision_cond',combined_baseline_cond'),test_freq,levels,test_type);

    for cond_no = 1:length(test_cond)
        cur_cond = find(strcmp(cond,test_cond{cond_no}));
        [stat] = IBS_cluster_two_sample(cat(2,combined_correlations(:,cur_cond),combined_baseline_cond'),test_freq,levels,test_type);
%         [stat] = IBS_cluster_two_sample(combined_correlations(:,[cur_cond baseline_start_loc]),test_freq,levels,test_type);
        t_stats{cond_no} = stat;
    end
    
    % perform (all) post-hoc tests
    pair_test_conds = nchoosek(test_cond,2);
    
    for pair_test = 1:size(pair_test_conds,1)
        cond_1_no = find(strcmp(cond,pair_test_conds{pair_test,1}));
        cond_2_no = find(strcmp(cond,pair_test_conds{pair_test,2}));
        [cur_stat] = IBS_cluster_two_sample(cat(2,combined_correlations(:,cond_1_no),combined_correlations(:,cond_2_no)),test_freq,levels,test_type);
        paired_t_tests{pair_test} = cur_stat;
    end
    
    
    
    NeNoOcc_loc = find(strcmp(cond,'NeNoOcc'));
    Task_loc = find(strcmp(cond,'Task'));
    NeNoOcc_Task_ttest = IBS_cluster_two_sample(combined_correlations(:,[NeNoOcc_loc Task_loc]),test_freq,levels,test_type);
    
    % cluster 2 is the lateral left alpha 
    Task_baseline_ttest = IBS_cluster_two_sample(cat(2,combined_correlations(:,Task_loc),combined_baseline_cond'),test_freq,levels,test_type);
    
    
    save(cluster_t_stats_baseline_freqwise_fname,'t_stats','pair_test_conds','paired_t_tests','stat_baseline','vision_stat','NeNoOcc_Task_ttest','Task_baseline_ttest','test_cond','data_analysis_type','cluster_freq_table');
    
end

switch(varargin_table.plot_type)
    case {'topoplots','images'}
Vision_baseline_fname =  strrep(cluster_t_effects_baseline_freqwise_fname,'baseline','Vision_baseline');
IBS_cluster_plot(vision_stat,Vision_baseline_fname,[],varargin_table.plot_type);

cellfun(@(x,y) IBS_cluster_plot(x,y,[],varargin_table.plot_type),t_stats,cluster_t_effects_conds_freqwise_fname)

NeNoOcc_Task_fname = strrep(cluster_t_effects_baseline_freqwise_fname,'baseline','NeNoOcc_Task');
IBS_cluster_plot(NeNoOcc_Task_ttest,NeNoOcc_Task_fname,[],varargin_table.plot_type);

Task_fname = strrep(cluster_t_effects_baseline_freqwise_fname,'baseline','Task');
IBS_cluster_plot(Task_baseline_ttest,Task_fname,[],varargin_table.plot_type);


close all
end
end
