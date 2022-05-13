
function [stat_main_effects,stat_interaction] = IBS_monkey_power_stats_freqwise(data_analysis_type,analysis,cor_fun,varargin_table)
%% Atesh

% 14-12-2020


if nargin <1
    data_analysis_type = 'no_aggressive_CAR_ASR_5_ICA_appended_trials';
end
if nargin <2
    analysis = 'Power_correlation_analysis';
varargin_table = table();
varargin_table.measure = 'corr';
end

if nargin <3
    cor_fun = @IBS_monkey_tf_correlations;% IBS_process_tf_connectivity

end


try
    plot_type = varargin_table.plot_type;
catch
    varargin_table.plot_type = 'topoplots';
end


cur_func_params = {'plot_type','measure'};

varargin_cell = table2cell(removevars(varargin_table,cur_func_params));


%%



cluster_effects_freqwise_fname = IBS_monkey_get_params_analysis_type(data_analysis_type,analysis).cluster_effects_freqwise_fname{1,1};


cluster_stats_freqwise_fname = IBS_monkey_get_params_analysis_type(data_analysis_type,analysis).cluster_stats_freqwise_fname{1,1};

%%
cluster_stats_freqwise_fname = IBS_update_stat_fname(cluster_stats_freqwise_fname,data_analysis_type,cor_fun,varargin_table);
cluster_effects_freqwise_fname = IBS_update_stat_fname(cluster_effects_freqwise_fname,data_analysis_type,cor_fun,varargin_table);

%%
if exist(cluster_stats_freqwise_fname,'file')
    
    cur_analysis_type = data_analysis_type;
    load(cluster_stats_freqwise_fname,'stat','anova_cond','data_analysis_type','cluster_freq_table');
    assert(strcmp(cur_analysis_type,data_analysis_type) ==1);
    
else
    
    
    cluster_freq_table = IBS_monkey_get_params_analysis_type(data_analysis_type).cluster_freq_table;
    
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
    
    anova_cond = {'FaOcc','FaNoOcc'};
    
    test_type = 'paired';
    levels = [repmat(1,1,size(combined_correlations,1)) repmat(2,1,size(combined_correlations,1))];
    [stat] = IBS_cluster_two_sample(combined_correlations,test_freq,levels,test_type);
    


    save(cluster_stats_freqwise_fname,'stat','anova_cond','data_analysis_type','cluster_freq_table');
    
end


IBS_cluster_plot(stat,cluster_effects_freqwise_fname,[],varargin_table.plot_type)
close all

end


% avg_freq_data = varfun(@(z) cellfun(@(t) cellfun(@(x) cellfun(@(y) mean_col_mat(y,t(1),t(2)),x,'UniformOutput', false),...
%     correlations_cell,'UniformOutput', false),z,'UniformOutput', false),freq_table);



% arrayfun(@(z) cellfun(@(x,y) IBS_cluster_plot(x,y),stat_main_effects{z},cluster_main_effects_freqwise_fnames{z}),...
%     1:width(cluster_freq_table))



% cellfun(@(x,y) IBS_cluster_plot(x,y),stat_interaction,cluster_interaction_freqwise_fnames)
%     [stat_main_effects,stat_interaction]  = arrayfun(@(x) IBS_cluster_anova(combined_avg_freq{:,x},...
%         cond,anova_cond,cond_nos,cell2mat(test_freq{:,x})),...
%         1:width(combined_avg_freq),'UniformOutput',false);
% for i = 1:23
%
%     for j = 1:7
%
%         A{i,j} = [avg_freq_data.Fun_alpha{1}{i,j} avg_freq_data.Fun_alpha{2}{i,j} avg_freq_data.Fun_alpha{3}{i,j}];
%     end
% end

% cellfun(@(x,y,z) [x y z],avg_freq_data.Fun_alpha{1},avg_freq_data.Fun_alpha{2},avg_freq_data.Fun_alpha{3})
