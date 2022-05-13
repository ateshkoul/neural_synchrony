function instantaneuos_angle = IBS_compute_instantaneous_angle_tf_freqwise(tf_S1,tf_S2)

tf_S1_powspectrum = tf_S1.powspctrm;
tf_S2_powspectrum = tf_S2.powspctrm;

[nTrials,nChan,nFreq,~] = size(tf_S1_powspectrum);
%% for variable 1s smoothing
smoothing_freq = 1-(ones(length(95),1) .* linspace(.5,.1,95)');

for trial = 1:nTrials
    
    
    cur_trial_S1 = squeeze(tf_S1_powspectrum(trial,:,:,:));
    cur_trial_S2 = squeeze(tf_S2_powspectrum(trial,:,:,:));
    

    %% to create avg freqwise
%     cur_trial_S1 = IBS_compute_freqwise('no_aggressive_CAR_ASR_10_ICA_appended_trials',cur_trial_S1);
%     cur_trial_S2 = IBS_compute_freqwise('no_aggressive_CAR_ASR_10_ICA_appended_trials',cur_trial_S2);
%%    
    [nChan,nFreq,~] = size(cur_trial_S1);

    for chan = 1:nChan
        for freq = 1:nFreq
%             trial_chan_freq_S1 = cur_trial_S1(chan,freq,:);
%             trial_chan_freq_S2 = cur_trial_S2(chan,freq,:);

%% for detrended (all has to be run!!)


            S1_value = squeeze(cur_trial_S1(chan,freq,:))';
            S2_value = squeeze(cur_trial_S2(chan,freq,:))';

            S1_nan = isnan(S1_value);
            S2_nan = isnan(S2_value);
            S1_value(S1_nan) = [];
            S2_value(S2_nan) = [];
    
            trial_chan_freq_S1 = Giac_detrend_Vector(S1_value);
            trial_chan_freq_S2 = Giac_detrend_Vector(S2_value);

            trial_chan_freq_S1(S1_nan) = nan;
            trial_chan_freq_S2(S2_nan) = nan;
%%%%%%%%%%%%%%%%%%%%%%            
%             trial_chan_freq_S1 = squeeze(tf_S1_powspectrum(trial,chan,freq,:));
%             trial_chan_freq_S2 = squeeze(tf_S2_powspectrum(trial,chan,freq,:));

%% 31-08-2021 
% this is done in the function itself now
            % important to consider that in this case 0.5 means no
            % correlation and 0 or 1 mean good corr. 
            % makes sense to change this to remove 0.5 from the values
%             % based on the bats paper - normalize to unit length
%             trial_chan_freq_S1 = trial_chan_freq_S1 -nanmean(trial_chan_freq_S1);
%             trial_chan_freq_S2 = trial_chan_freq_S2 -nanmean(trial_chan_freq_S2);
% 
%             
%             trial_chan_freq_S1 = normalize(trial_chan_freq_S1,'norm');
%             trial_chan_freq_S2 = normalize(trial_chan_freq_S2,'norm');

%%
            % 20 corresponds to 2 sec
%             trial_chan_freq_S1 = smoothdata(trial_chan_freq_S1,'movmean',50);
%             trial_chan_freq_S2 = smoothdata(trial_chan_freq_S2,'movmean',50);

%             trial_chan_freq_S1 = movingmean(trial_chan_freq_S1,8,3,[]);
%             trial_chan_freq_S2 = movingmean(trial_chan_freq_S2,8,3,[]); 
%             trial_chan_freq_S1 = smoothdata(trial_chan_freq_S1,'lowess',0.8,'SamplePoints',tf_S1.time);
%             trial_chan_freq_S2 = smoothdata(trial_chan_freq_S2,'lowess',0.8,'SamplePoints',tf_S2.time);
            

%             trial_chan_freq_S1 = smoothdata(trial_chan_freq_S1,'lowess',smoothing_freq(freq,1),'SamplePoints',tf_S1.time);
%             trial_chan_freq_S2 = smoothdata(trial_chan_freq_S2,'lowess',smoothing_freq(freq,1),'SamplePoints',tf_S2.time);

%               trial_chan_freq_S1 = smoothdata(trial_chan_freq_S1,'movmean',smoothing_freq(freq,1),'SamplePoints',tf_S1.time);
%               trial_chan_freq_S2 = smoothdata(trial_chan_freq_S2,'movmean',smoothing_freq(freq,1),'SamplePoints',tf_S2.time);
       %%               
            instantaneuos_angle(trial,chan,freq,:) = IBS_compute_vector_angle(trial_chan_freq_S1,trial_chan_freq_S2);
%             instantaneuos_angle(trial,chan,freq,:) = IBS_compute_behav_vector_angle(trial_chan_freq_S1,trial_chan_freq_S2);
        
            
        end
    end
end


end