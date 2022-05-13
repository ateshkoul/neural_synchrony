%% function that saves image, multiplots and topoplot videos from correlations

function IBS_tf_correlation_analysis_freqwise(analysis_type,cor_fun,varargin_table)

if nargin <2
    cor_fun = @IBS_tf_correlations;% IBS_process_tf_connectivity
end


try
    cor_fun_args = table2cell(varargin_table.cor_fun_args);
    limit_args =  table2cell(varargin_table.limit_args);
catch
    cor_fun_args = {};
    limit_args = {};
    

end

%%
% save_dir = IBS_get_params_analysis_type(analysis_type).save_dir{1,1};
% save_dir = [save_dir 'figures\\'];

% load the dataset
[correlations_cell,conditions,cor_fname] = cor_fun(analysis_type,cor_fun_args{:});
% [correlations_cell,conditions] = IBS_tf_correlations_trialwise(3,analysis_type);



%% get save dir and title
[save_dir,f_name] = fileparts(cor_fname);
save_dir = [save_dir 'figures\\'];

find_delimiters = strfind(f_name,'_');
plot_title = f_name(1:find_delimiters(2));

%% process pwr correlations
freq_type = 'freqwise';
data_type = 'mean';
[~,mean_pwr_correlation] = IBS_process_pwr_correlations(correlations_cell,data_type,analysis_type,freq_type);


% mean_pwr_correlation = cellfun(@(x,y) (x+y)./2,mean_pwr_correlation,mean_pwr_correlation1,'UniformOutput',false)
data_type = 't_value';
[~,t_value_pwr_correlation] = IBS_process_pwr_correlations(correlations_cell,data_type,analysis_type,freq_type);

%%  
if any(contains(conditions,'Baseline'))
baseline_start_loc = find(strcmp(conditions,'Baseline start'));
baseline_end_loc = find(strcmp(conditions,'Baseline end'));

mean_pwr_correlation{1,end+1} = (mean_pwr_correlation{1, baseline_start_loc}+mean_pwr_correlation{1, baseline_end_loc})/2;
conditions{end+1} = 'Baseline';
end
FaNoOcc_loc = find(strcmp(conditions,'FaNoOcc'));
NeNoOcc_loc = find(strcmp(conditions,'NeNoOcc'));
mean_pwr_correlation{1,end+1} = (mean_pwr_correlation{1, FaNoOcc_loc}+mean_pwr_correlation{1, NeNoOcc_loc})/2;
conditions{end+1} = 'Vision';

%% plotting

% analysis_type = '_no_aggressive_trialwise_CAR_normchange_';  
% plot_types = {'images','multiplot','movie_topoplot'};
plot_types = {'images','multiplot'};

% plot_types = {'movie_topoplot'};
% plot_types = {'multiplot'};
plot_types = {'images'};

[mean_limits,t_value_limits,varargout_table] = IBS_get_corr_limits(cor_fun,limit_args);

cluster_freq_table = IBS_get_params_analysis_type(analysis_type).cluster_freq_table;
%                 xtick_values = cellfun(@(x) x(1),table2array(cluster_freq_table),'UniformOutput',false);
%                 varargin_table = addvars(varargin_table,cat(2,xtick_values{:}),'NewVariableNames',{'xticklabels'});

xtick_values = cellfun(@(x) [num2str(x(1)) '-' num2str(x(2))],table2array(cluster_freq_table),'UniformOutput',false);
varargout_table = addvars(varargout_table,xtick_values,'NewVariableNames',{'xticklabels'});

data_type = 'mean';

cellfun(@(z) cellfun(@(x,y) IBS_plot_correlation_map(x,[plot_title freq_type '_' y ],...
    z,data_type,analysis_type,mean_limits,save_dir,varargout_table),mean_pwr_correlation,conditions),plot_types)

close all
% data_type = 't_value';
% 
% cellfun(@(z) cellfun(@(x,y) IBS_plot_correlation_map(x,[plot_title freq_type '_' y  ],z,data_type,analysis_type,t_value_limits,save_dir,varargout_table),t_value_pwr_correlation,conditions),plot_types)
% close all
end

% %% power point save
% % root_dir = 'Y:\\Inter-brain synchrony\\Results\\EEG\\power correlations\\';
% % root_dir = 'Y:\\Research projects 2020\\Inter-brain synchrony\\Results\\EEG\\power correlations\\';
% presentation_save_dir = 'Y:\\Inter-brain synchrony\\Results\\EEG\\IBS_EEG_presentations\\';
% import mlreportgen.ppt.*
% plot_types = {'images','multiplot'};
% data_type = 't_value';
% % data_type = 'mean';
% ppt = Presentation([presentation_save_dir 'results_power_correlation_' analysis_type   '_0_120s_' data_type '.pptx'],'C:\\Users\\Atesh\\Documents\\Custom Office Templates\\standard.potx');
% 
% cellfun(@(x) IBS_powerpoint_plots_tf_correlations(ppt,save_dir,data_type,x,analysis_type,conditions),plot_types)
% close(ppt);
% 
% data_type = 'mean';
% ppt = Presentation([presentation_save_dir 'results_power_correlation_' analysis_type   '_0_120s_' data_type '.pptx'],'C:\\Users\\Atesh\\Documents\\Custom Office Templates\\standard.potx');
% 
% cellfun(@(x) IBS_powerpoint_plots_tf_correlations(ppt,save_dir,data_type,x,analysis_type,conditions),plot_types)
% close(ppt);
%%
% Dyads = [1:11 13:18 20:23];
% laughing_subs = [5 6 14 22 23];
% 
% 
% correlations_cell(ismember(Dyads,laughing_subs)) = [];