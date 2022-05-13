
function dataset = IBS_correct_Dyad_data(dataset,Dyd_no,block,analysis_type)

% analysis_type_params = IBS_get_params_analysis_type(analysis_type);
%
% pre_trig_time = -analysis_type_params.pre_trig_time;


if Dyd_no == 12 && strcmp(block,'blocks')
    time_lost = 1.7173;%s
    % get the correct dataset - considering the time lost as 0 time
%     dataset_trial = IBS_load_raw_sub_data(Dyd_no,block,0,120-time_lost);
    dataset_trial_1 = IBS_load_raw_sub_data(Dyd_no,block,0,120);

    fsample = dataset_trial_1.fsample;
    switch analysis_type
        case 'no_aggressive_trialwise_CAR'
            % Giacomo suggestion
            % the dataset here has falsely labelled as -1 to 120 when it is 1.7173 to 120+1+1.7173
            
            
            prestim = 1;
            poststim = 120;
            case 'aggressive_trialwise_CAR'
            % Giacomo suggestion
            % the dataset here has falsely labelled as -1 to 120 when it is 1.7173 to 120+1+1.7173
            
            
            prestim = 1;
            poststim = 120;
        case 'no_aggressive_CAR_ASR_5_ICA_appended_trials'
             dataset_trial_15 = IBS_load_raw_sub_data(Dyd_no,block,-3,122,analysis_type);

            prestim = 3;
            poststim = 123;
            

            dataset_trial_1.trial{1,1}(:,end:end+(fsample*(poststim-120))) = dataset_trial_1.trial{1,1}(:,end -(fsample*(poststim-120)):end) ;

            
            dataset_trial_15.trial{1,14}(:,end:end+(fsample*(poststim-122))) = dataset_trial_15.trial{1,14}(:,end -(fsample*(poststim-122)):end) ;
            dataset.trial{1,14} = dataset_trial_15.trial{1,14};
            dataset.time(:,14) = dataset.time(:,1);
            dataset.sampleinfo(14,:) = dataset_trial_15.sampleinfo(14,:);
            dataset.trialinfo(14,:) = dataset_trial_15.trialinfo(14,:);
        case {'no_aggressive_CAR_ASR_10_ICA_appended_trials','no_aggressive_CAR_ASR_20_ICA_appended_trials'}
           dataset_trial_15 = IBS_load_raw_sub_data(Dyd_no,block,-3,122,analysis_type);

            prestim = 3;
            poststim = 123;
            

            dataset_trial_1.trial{1,1}(:,end:end+(fsample*(poststim-120))) = dataset_trial_1.trial{1,1}(:,end -(fsample*(poststim-120)):end) ;

            
            dataset_trial_15.trial{1,14}(:,end:end+(fsample*(poststim-122))) = dataset_trial_15.trial{1,14}(:,end -(fsample*(poststim-122)):end) ;
            dataset.trial{1,14} = dataset_trial_15.trial{1,14};
            dataset.time(:,14) = dataset.time(:,1);
            dataset.sampleinfo(14,:) = dataset_trial_15.sampleinfo(14,:);
            dataset.trialinfo(14,:) = dataset_trial_15.trialinfo(14,:);

            
    end
    warning('modifying the data for the dyd %0.3d',Dyd_no)
    % 3517 is the row_no when the actual data acquisition starts
    data_to_repeat_start = dataset_trial_1.trial{1,1}(:,1:(time_lost*fsample));
    dataset_trial_1.trial{1,1}(:,(3517+(fsample*prestim)+1):(fsample*(poststim+prestim))) = dataset_trial_1.trial{1,1}(:,1:((fsample*(poststim+prestim))-3517-(fsample*prestim)));

    dataset_trial_1.trial{1,1}(:,(fsample*prestim)+1:(3517+(fsample*prestim))) =data_to_repeat_start(:,1:3517);
    repeated_data = repmat(data_to_repeat_start,1,prestim);
    dataset_trial_1.trial{1,1}(:,1:(fsample*prestim)) =repeated_data(:,1:(fsample*prestim));

        warning('adding the trial for the dyd %0.3d',Dyd_no)

    dataset.trial(:,2:15) = dataset.trial(:,1:14);
    dataset.trial{1,1} = dataset_trial_1.trial{1,1};
    
    dataset.time(:,2:15) = dataset.time(:,1:14);
    dataset.time(:,1) = dataset.time(:,2);
    
    dataset.sampleinfo(2:15,:) = dataset.sampleinfo(1:14,:);
    dataset.sampleinfo(1,:) = dataset_trial_1.sampleinfo(1,:);

    dataset.trialinfo(2:15,:) = dataset.trialinfo(1:14,:);
    dataset.trialinfo(1,:) = dataset_trial_1.trialinfo(1,:);

end










% correct for the issue here. the dataset selects 120 seconds but takes
% the data after the end of the trial.
% the last sample where the code is sent (36) is 242243, converted to
% seconds is 242243/2048. which is 118.2827. so we lost around 1.7173s
% of trial. converted to samples this is 1.7173*2048 or 3.5170e+03
% samples

% adding this much NaNs at the begining and removing from the end of
% the trial
% I get 122.7173 because of this:
% 1.7173+(247808*(dataset.time{1,1}(1,2)-dataset.time{1,1}(1,1)))
% ideally should be 122.7173 but this leads to more values
%     dataset.time{1,1} = 1.7173:(dataset.time{1,1}(1,2)-dataset.time{1,1}(1,1)):122.7170;


%     dataset.trial{1,1}(:,(247808-3517):247808) = [];
%     dataset.trial{1,1}(:,(247808-3517):247808)
%     dataset.trial{1,1}(:,(3517+1):247808) = dataset.trial{1,1}(:,1:(247808-3517));
%     dataset.trial{1,1}(:,1:3517) = NaN(size(dataset.trial{1,1},1),3517);
