function [data_electrodes] = combine_electrode_trial_data(data_struct,electrode_nos,time_cols)
%% Simple function to combine data from fieldtrip struct to a 3d matrix. 
% data from either 1 electrode or from multiple (specified as series as 
% e.g. 1:channel_no).

% if the no. of elctrodes is more than 1, the output structure would be
% nTrials x timepoints x channels . This is so that trials could be
% concatanated across individuals.

% unit tested - test_combine_electrode_trial_data_electrodes,test_combine_electrode_trial_data

% written by:
% Atesh Koul
% modified 24-04-2020
% ---------------------------------------------%

% time_cols might be useful in some of the cases. however, keep in mind
% when combining this information. the time cols might not be the same
% across the datasets. for instance, the peak to peak has been calculated
% on full data. so the mat file has time points from the entire data. 
if nargin <3
    % get the information about all the timepoints from the first trial
    time_cols = [1 size(data_struct.trial{1,1},2)];
end


nChannels = size(data_struct.trial{1,1},1);
nTimePoints = size(data_struct.trial{1,1},2);
nTrials = numel(data_struct.trial);

data_all_trials = reshape(cat(2,data_struct.trial{:}),[nChannels nTimePoints nTrials]);

% this should work because the second dimension is always the time
% irrespective of data structure
if numel(electrode_nos)>1
    data_electrodes = permute(data_all_trials,[3 2 1]);
    % important to use this otherwise the electrode_nos doesn't make sense
    % for more than 1 electrode.
    data_electrodes = data_electrodes(:,time_cols(1):time_cols(2),electrode_nos);
else
    data_electrodes = squeeze(data_all_trials(electrode_nos,time_cols(1):time_cols(2),:))';
end



end