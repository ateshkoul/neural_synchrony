function [results] = IBS_compute_brain_behavior_glm_shifts(data_analysis_type,analysis,brain_data,behavior_data_predictors)

% behavior_data_predictors - cell array of all the predictors

%% first bring into same sampling rate

behavior_data_aligned = cellfun(@(x,varargin) [x varargin{:}], behavior_data_predictors{:},'UniformOutput',false);

%% perform channel and frequency wise glm

% varargin_table.save_figure = false;
% figure;IBS_plot_correlation_map(betas(:,:,3),'glm','movie_topoplot','mean','CAR_baseline_normchange_0_120s_',[-0.01 0.01],[],varargin_table)


% [betas,deviances,stat_cell] = cellfun(@(x,y) IBS_compute_chan_freq_wise_glm(x,y),...
%     brain_data,behavior_data_aligned,'UniformOutput',false);


%% all subjects

% behavior_data_aligned = cellfun(@(x) normalize(x),behavior_data_aligned,'UniformOutput',false);
% this is for cases where all dyads are not used. the error is because the
% data can't be concatanated as it is a table.

% An error occurred when concatenating the table variable 'Dyad_no_Eye_tracker_gaze_positions_on_body' using
% VERTCAT.

empty_dyads = find(cell2mat(cellfun(@(x) isempty(x),behavior_data_aligned,'UniformOutput',false)));
behavior_data_aligned(empty_dyads) = [];

behavior_data_aligned = cat(1,behavior_data_aligned{:});


[betas,deviances,stat_cell] = IBS_compute_chan_freq_wise_glm_shifts(data_analysis_type,analysis,brain_data,behavior_data_aligned);



results = table();
results.betas = betas;
results.deviances = deviances;
results.stats_cell = stat_cell;

end
