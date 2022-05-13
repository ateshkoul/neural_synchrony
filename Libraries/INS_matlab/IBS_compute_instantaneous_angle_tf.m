function instantaneuos_angle = IBS_compute_instantaneous_angle_tf(tf_S1,tf_S2)

tf_S1_powspectrum = tf_S1.powspctrm;
tf_S2_powspectrum = tf_S2.powspctrm;

[nTrials,nChan,nFreq,~] = size(tf_S1_powspectrum);

for trial = 1:nTrials
    for chan = 1:nChan
        for freq = 1:nFreq
            
            trial_chan_freq_S1 = squeeze(tf_S1_powspectrum(trial,chan,freq,:));
            trial_chan_freq_S2 = squeeze(tf_S2_powspectrum(trial,chan,freq,:));
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
            % 20 corresponds to 2 sec
            trial_chan_freq_S1 = smoothdata(trial_chan_freq_S1,'movmean',20);
            trial_chan_freq_S2 = smoothdata(trial_chan_freq_S2,'movmean',20);
            
            instantaneuos_angle(trial,chan,freq,:) = IBS_compute_vector_angle(trial_chan_freq_S1,trial_chan_freq_S2);
            
            
        end
    end
end


end