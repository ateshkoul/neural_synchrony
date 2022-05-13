

function [stats] = IBS_monkey_power_stats_freqwise_one_way_anova(data_analysis_type,analysis,cor_fun,varargin_table)

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
    cor_fun = @IBS_monkey_tf_correlations;% IBS_process_tf_connectivity
    
end


try
    plot_type = varargin_table.plot_type;
catch
    
    varargin_table.plot_type = 'topoplots';
end


cur_func_params = {'plot_type','measure'};


varargin_cell = table2cell(removevars(varargin_table,cur_func_params));
cluster_main_effects_freqwise_analysis = IBS_monkey_get_params_analysis_type(data_analysis_type,analysis).cluster_main_effects_freqwise_analysis{1,1};
cluster_stats_freqwise_analysis = IBS_monkey_get_params_analysis_type(data_analysis_type,analysis).cluster_stats_freqwise_analysis{1,1};


%% cluster based

if exist(cluster_stats_freqwise_analysis,'file')
    
    cur_analysis_type = data_analysis_type;
    load(cluster_stats_freqwise_analysis,'stats_anova_sex','stats_f_f_vs_m_m','stats_partners_friends','test_cond','data_analysis_type','analysis','cor_fun','test_freq','f_name');
    assert(strcmp(cur_analysis_type,data_analysis_type) ==1);
    
else
    
    
    cluster_freq_table = IBS_monkey_get_params_analysis_type(data_analysis_type).cluster_freq_table;
    
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
    
    
       test_cond = {'FaOcc','FaNoOcc' };
        
%     test_cond = {'NeNoOcc' };

    % independent test - male-males dyads might be a big better than female-female in alpha (for freqwise) and in high gamma (for all freq)?
    % for anova - close to significance for freqwise in alpha, a bit far
    % (0.08) negative clusters
    % for all freq in high gamma but in same electrodes.
    % test_type = 'independent';
    test_cond_data = combined_correlations(:,ismember(cond,test_cond));
    
    
    % for mixed 2x2
    levels = IBS_monkey_get_params_analysis_type(data_analysis_type,analysis).levels;
    anova_table = IBS_monkey_get_params_analysis_type(data_analysis_type,analysis).anova_table;
    
    [stats] = IBS_cluster_main_effects_general(test_cond_data,levels,test_freq,anova_table);
    
    
    
%     test_cond = {'NeNoOcc' };
%     % independent test - female-female dyads might be a big better than male-males in alpha (for freqwise) and in high gamma (for all freq)?
%     % for anova - close to significance for freqwise in alpha, a bit far (0.08)
%     % for all freq in high gamma but in same electrodes.
%     % test_type = 'independent';
%     test_cond_data = combined_correlations(:,ismember(cond,test_cond));
%     % checked with eyetracker combined videos that the pairs are correct
%     s_female_female = test_cond_data([1,5,7,8,12,13,19,22],:);% female-female [1,5,7,8,12,13,19,22]
%     s_female_male = test_cond_data([3,6,10,11,15,17,18,20,21,23],:); % males [2,4,9,14,16] % male-female [3,6,10,11,15,17,18,20,21,23]
%     s_male_male = test_cond_data([2,4,9,14,16],:);% female-female [1,5,7,8,12,13,19,22]
%     
%     combined_correlations = [s_female_female;s_female_male;s_male_male ];
%     levels = [repmat(1,1,length(s_female_female)) repmat(2,1,length(s_female_male)) repmat(3,1,length(s_male_male))];
%     % [stat] = IBS_cluster_two_sample(combined_correlations,test_freq,levels,test_type);
%     [stats_anova_sex] = IBS_cluster_one_way_anova(combined_correlations,test_freq,levels);
%     
%     
%     %%
%     test_type = 'independent';
%     combined_correlations = [s_female_female;s_male_male ];
%     levels = [repmat(1,1,length(s_female_female)) repmat(2,1,length(s_male_male))];
%     test_freq = 1:size(s_female_female{1,1},2);
%     % [stat] = IBS_cluster_two_sample(combined_correlations,test_freq,levels,test_type);
%     [stats_f_f_vs_m_m] = IBS_cluster_two_sample(combined_correlations,test_freq,levels,test_type);
%     s_partners = test_cond_data([1,9,11,18,20,21,6],:);%
%     s_friends = test_cond_data([7,8,10,12,15,16,17,22,19,16,13,23],:);
%     
%     
%     test_type = 'independent';
%     combined_correlations_test_cond = [s_partners;s_friends ];
%     levels = [repmat(1,1,length(s_partners)) repmat(2,1,length(s_friends))];
%     test_freq = 1:size(s_partners{1,1},2);
%     % [stat] = IBS_cluster_two_sample(combined_correlations,test_freq,levels,test_type);
%     [stats_partners_friends] = IBS_cluster_two_sample(combined_correlations_test_cond,test_freq,levels,test_type);
%     
%     save(cluster_stats_freqwise_analysis,'stats_anova_sex','stats_f_f_vs_m_m','stats_partners_friends','test_cond','data_analysis_type','analysis','test_freq','f_name','cor_fun');
%     save(cluster_stats_analysis,'stats','test_cond','data_analysis_type','analysis','test_freq','f_name','cor_fun','levels','anova_table');
  
end

% cellfun(@(x,y) IBS_cluster_plot(x,[cluster_main_effects_analysis y],...
%     [],varargin_table.plot_type),stats,anova_table.main_effect_names)

cellfun(@(x,y) IBS_cluster_plot(x,'no',...
    [],varargin_table.plot_type,analysis),stats,anova_table.main_effect_names)

close all


end