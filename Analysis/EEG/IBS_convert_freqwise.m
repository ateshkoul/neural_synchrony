function [combined_correlations] = IBS_convert_freqwise(correlations_cell,analysis_type,mean_col_mat,analysis)
if nargin <3
    mean_col_mat = @(x,a,b) mean(x(:,a:b),2);
end
cluster_freq_table = IBS_get_params_analysis_type(analysis_type).cluster_freq_table;


combined_correlations = cat(1,correlations_cell{:});
% this function averages for all the subjects and all conditions i.e.
% for all chan x freq
avg_freq_data = varfun(@(z) cellfun(@(t) cellfun(@(y) mean_col_mat(y,t(1),t(2)),combined_correlations,'UniformOutput', false),...
    z,'UniformOutput', false),cluster_freq_table);



% this statement took sooooo long to get!!
combined_avg_freq = table2cell(varfun(@(z) cellfun(@(x,varargin) [x varargin{:}],z{:},'UniformOutput',false),avg_freq_data));

combined_avg_all_freq = arrayfun(@(z) cellfun(@(x,varargin) [x varargin{:}], combined_avg_freq{z,:}, 'UniformOutput', false),[1:size(combined_avg_freq,1)]','UniformOutput',false);

combined_correlations = cat(1,combined_avg_all_freq{:});combined_correlations = cat(1,correlations_cell{:});
% this function averages for all the subjects and all conditions i.e.
% for all chan x freq
avg_freq_data = varfun(@(z) cellfun(@(t) cellfun(@(y) mean_col_mat(y,t(1),t(2)),combined_correlations,'UniformOutput', false),...
    z,'UniformOutput', false),cluster_freq_table);



% this statement took sooooo long to get!!
combined_avg_freq = table2cell(varfun(@(z) cellfun(@(x,varargin) [x varargin{:}],z{:},'UniformOutput',false),avg_freq_data));

combined_avg_all_freq = arrayfun(@(z) cellfun(@(x,varargin) [x varargin{:}], combined_avg_freq{z,:}, 'UniformOutput', false),[1:size(combined_avg_freq,1)]','UniformOutput',false);

combined_correlations = cat(1,combined_avg_all_freq{:});
end