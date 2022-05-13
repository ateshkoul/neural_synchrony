function [combined_avg_freq] =  IBS_compute_freqwise(data_analysis_type,data_chan_freq)
%% Atesh Koul
% 04-02-2021
% data_freq_cell          (matrix) freq dataset chan x freq x time for all conditions

cluster_freq_table = IBS_get_params_analysis_type(data_analysis_type).cluster_freq_table;

mean_col_mat = @(x,a,b) mean(x(:,a:b,:),2);
% data_freq_cell = correlations_cell{1,1};

% combined_correlations = cat(1,data_tf_cell{:});


avg_freq_data = varfun(@(z) cellfun(@(t) mean_col_mat(data_chan_freq,t(1),t(2)),...
    z,'UniformOutput', false),cluster_freq_table);

% avg_freq_data = varfun(@(z) cellfun(@(t) cellfun(@(y) mean_col_mat(y,t(1),t(2)),data_freq_cell,'UniformOutput', false),...
%     z,'UniformOutput', false),cluster_freq_table);



% this statement took sooooo long to get!!
% combined_avg_freq = table2cell(varfun(@(z) cellfun(@(x,varargin) [x varargin{:}],z{:},'UniformOutput',false),avg_freq_data));
combined_avg_freq = table2array(varfun(@(z) cat(2,z{:}),avg_freq_data));

% combined_avg_all_freq = arrayfun(@(z) cellfun(@(x,varargin) [x varargin{:}], combined_avg_freq{z,:}, 'UniformOutput', false),[1:size(combined_avg_freq,1)]','UniformOutput',false);

% combined_correlations = cat(1,combined_avg_all_freq{:});

end