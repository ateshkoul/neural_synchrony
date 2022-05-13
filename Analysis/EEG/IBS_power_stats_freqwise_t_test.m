

function [stats] = IBS_power_stats_freqwise_t_test(data_analysis_type,analysis,cor_fun,varargin_table)

% https://www.fieldtriptoolbox.org/tutorial/cluster_permutation_timelock/#the-format-of-the-output
% analysis_type = 'no_aggressive_trialwise_CAR';
% analysis_type = 'no_aggressive_ASR_clean_trialwise_CAR';
% analysis_type = 'no_aggressive_ASR_8_clean_trialwise_CAR';

if nargin <1
    data_analysis_type = 'no_aggressive_trialwise_CAR';
end

if nargin <2
    analysis = 'Power_correlation_analysis';
    varargin_table = table();
    varargin_table.measure = 'corr';
end

if nargin <3 || isempty(cor_fun)
    cor_fun = @IBS_tf_correlations;% IBS_process_tf_connectivity
    
end


try
    plot_type = varargin_table.plot_type;
catch
    
    varargin_table.plot_type = 'topoplots';
end


cur_func_params = {'plot_type','measure'};


varargin_cell = table2cell(removevars(varargin_table,cur_func_params));
cluster_main_effects_freqwise_analysis = IBS_get_params_analysis_type(data_analysis_type,analysis).cluster_main_effects_freqwise_analysis{1,1};
cluster_stats_freqwise_analysis = IBS_get_params_analysis_type(data_analysis_type,analysis).cluster_stats_freqwise_analysis{1,1};


sub_group_1 = IBS_get_params_analysis_type(data_analysis_type,analysis).sub_group_1;
sub_group_2 = IBS_get_params_analysis_type(data_analysis_type,analysis).sub_group_2;

% sub_group_1 = [1,9,11,18,20,21,6];
% sub_group_2 = [7,8,10,12,15,16,17,22,19,16,13,23];

%% cluster based

if exist(cluster_stats_freqwise_analysis,'file')
    
    cur_analysis_type = data_analysis_type;
    load(cluster_stats_freqwise_analysis,'stats','test_cond','data_analysis_type','analysis','cor_fun','test_freq','f_name');
    assert(strcmp(cur_analysis_type,data_analysis_type) ==1);
    
else
    cluster_freq_table = IBS_get_params_analysis_type(data_analysis_type).cluster_freq_table;
    
    mean_col_mat = @(x,a,b) mean(x(:,a:b),2);
    [correlations_cell,cond,f_name] = cor_fun(data_analysis_type,varargin_cell{:});
    
    combined_correlations = cat(1,correlations_cell{:});
    
    avg_freq_data = varfun(@(z) cellfun(@(t) cellfun(@(y) mean_col_mat(y,t(1),t(2)),combined_correlations,'UniformOutput', false),...
        z,'UniformOutput', false),cluster_freq_table);  
    
    
    
    % this statement took sooooo long to get!!
    combined_avg_freq = table2cell(varfun(@(z) cellfun(@(x,varargin) [x varargin{:}],z{:},'UniformOutput',false),avg_freq_data));
    
    combined_avg_all_freq = arrayfun(@(z) cellfun(@(x,varargin) [x varargin{:}], combined_avg_freq{z,:}, 'UniformOutput', false),[1:size(combined_avg_freq,1)]','UniformOutput',false);
    
    combined_correlations = cat(1,combined_avg_all_freq{:});
    
    
    test_freq = table2array(varfun(@(x) cellfun(@(y) y(1),x,'uniformOutput',false),cluster_freq_table));
    test_freq = cat(2,test_freq{:});
    
    test_cond = {'NeNoOcc' };
    % independent test - male-males dyads might be a big better than female-female in alpha (for freqwise) and in high gamma (for all freq)?
    % for anova - close to significance for freqwise in alpha, a bit far
    % (0.08) negative clusters
    % for all freq in high gamma but in same electrodes.
    % test_type = 'independent';
    test_cond_data = combined_correlations(:,ismember(cond,test_cond));

    %%

    s_group_1 = test_cond_data(sub_group_1,:);% 
    s_group_2 = test_cond_data(sub_group_2,:); 
    
    
    test_type = 'independent';
    combined_correlations_test_cond = [s_group_1;s_group_2 ];
    levels = [repmat(1,1,length(s_group_1)) repmat(2,1,length(s_group_2))];
%     test_freq = 1:size(s_group_1{1,1},2);
    % [stat] = IBS_cluster_two_sample(combined_correlations,test_freq,levels,test_type);
    [stats] = IBS_cluster_two_sample(combined_correlations_test_cond,test_freq,levels,test_type);
    
    save(cluster_stats_freqwise_analysis,'stats','test_cond','data_analysis_type','analysis','test_freq','f_name','cor_fun');
end


IBS_cluster_plot(stats,cluster_main_effects_freqwise_analysis,[],varargin_table.plot_type,analysis)
% IBS_cluster_plot(stats,'no',[],varargin_table.plot_type,analysis)

close all


end