function [clusters] = IBS_select_stat_subclusters(data_analysis_type,analysis,stats_main,stats_interaction)
%% Atesh Koul
% 04-02-2021
detrended_data = 'yes';
switch(data_analysis_type)
    
    
    case 'no_aggressive_trialwise_CAR'
        switch(contains(analysis,'freqwise'))
            case 0
                %                 stats.posclusterslabelmat(stats.posclusterslabelmat==2) = nan;
                %                 stats.posclusterslabelmat(stats.posclusterslabelmat==3) = nan;
                %
                %                 stats.posclusterslabelmat(stats.posclusterslabelmat==0) = nan;
                %
                %                 clusters = {stats.posclusterslabelmat};
                
            case 1
                %                 cluster_1_freq_col =9:11; % alpha band - this is not based on freq but the cols. see stats.freq
                %                 cluster_1 = nan(size(stats.mask));
                %                 cluster_1(:,cluster_1_freq_col) = stats.mask(:,cluster_1_freq_col);
                %                 cluster_1(cluster_1==0) = nan;
                %
                %                 %% cluster 3
                %                 % easier to make cluster 3 before
                %                 cluster_3 = nan(size(stats.mask));
                %                 cluster_3_freq_col = 14;
                %                 frontal_chans = find(contains(stats.label,'F'));
                %
                %                 cluster_3(frontal_chans,cluster_3_freq_col) = stats.mask(frontal_chans,cluster_3_freq_col);
                %                 cluster_3(cluster_3==0) = nan;
                %                 %% cluster 2
                %                 % get all the channels from the last one - there are some channels
                %                 % that are extra but this is taken care because the mask is used to
                %                 % select the channels finally, everything else is converted to NaN
                %                 [all_sig_chans, ~] = find(stats.mask(:,14));
                %
                %                 % seperate the frontal cluster from the posterior one
                %                 sel_chans_cluster_2_no = setdiff(all_sig_chans,frontal_chans);
                %
                %
                %                 cluster_2 = nan(size(stats.mask));
                %                 cluster_2_freq_col = [12:14];
                %                 cluster_2(sel_chans_cluster_2_no,cluster_2_freq_col) = stats.mask(sel_chans_cluster_2_no,cluster_2_freq_col);
                %                 cluster_2(cluster_2==0) = nan;
                %
                %                 clusters = {cluster_1 cluster_2 cluster_3 };
        end
    case 'no_aggressive_CAR_ASR_5_ICA_appended_trials'
        switch(contains(analysis,'freqwise'))
            case 0
                
            case 1
                %                                 % cluster 1
                %                 cluster_1_freq_col = 7:8; % alpha band - this is not based on freq but the cols. see stats.freq
                %                 cluster_1 = nan(size(stats.mask));
                %                 cluster_1(:,cluster_1_freq_col) = stats.mask(:,cluster_1_freq_col);
                %                 cluster_1(cluster_1==0) = nan;
                %
                %                 %% cluster 3
                %                 % easier to make cluster 3 before
                %                 cluster_3 = nan(size(stats.mask));
                %                 cluster_3_freq_col = 14;
                %                 frontal_chans = find(contains(stats.label,'F'));
                %
                %                 cluster_3(frontal_chans,cluster_3_freq_col) = stats.mask(frontal_chans,cluster_3_freq_col);
                %                 cluster_3(cluster_3==0) = nan;
                %                 %% cluster 2
                %                 % get all the channels from the last one - there are some channels
                %                 % that are extra but this is taken care because the mask is used to
                %                 % select the channels finally, everything else is converted to NaN
                %                 [all_sig_chans, ~] = find(stats.mask(:,14));
                %
                %                 % seperate the frontal cluster from the posterior one
                %                 sel_chans_cluster_2_no = setdiff(all_sig_chans,frontal_chans);
                %
                %
                %                 cluster_2 = nan(size(stats.mask));
                %                 cluster_2_freq_col = [12:14];
                %                 cluster_2(sel_chans_cluster_2_no,cluster_2_freq_col) = stats.mask(sel_chans_cluster_2_no,cluster_2_freq_col);
                %                 cluster_2(cluster_2==0) = nan;
                %
                %                 clusters = {cluster_1 cluster_2 cluster_3 };
        end
        
        
    case 'no_aggressive_CAR_ASR_10_ICA_appended_trials'
        switch(contains(analysis,'freqwise'))
            case 0
                
            case 1
                switch(detrended_data)
                    case 'no'
                        %                            cluster 1
                        stats = stats_main;
                        cluster_1_freq_col = 10:11; % beta band - this is not based on freq but the cols. see stats.freq
                        cluster_1 = nan(size(stats.mask));
                        cluster_1(:,cluster_1_freq_col) = stats.mask(:,cluster_1_freq_col);
                        cluster_1(cluster_1==0) = nan;
                        
                        %% cluster 3
                        % easier to make cluster 3 before
%                         cluster_3 = nan(size(stats.mask));
%                         cluster_3_freq_col = 14;
                        frontal_chans = find(contains(stats.label,'F'));
%                         
%                         cluster_3(frontal_chans,cluster_3_freq_col) = stats.mask(frontal_chans,cluster_3_freq_col);
%                         cluster_3(cluster_3==0) = nan;
                        
                        
                        %%
                        cluster_3_freq_col = 7:8; % beta band
                        cluster_3 = nan(size(stats_interaction.mask));
                        cluster_3(:,cluster_3_freq_col) = stats_interaction.mask(:,cluster_3_freq_col);
                        cluster_3(cluster_3==0) = nan;
                        %% cluster 2
                        % get all the channels from the last one - there are some channels
                        % that are extra but this is taken care because the mask is used to
                        % select the channels finally, everything else is converted to NaN
                        [all_sig_chans, ~] = find(stats.mask(:,14));
                        
                        % seperate the frontal cluster from the posterior one
                        sel_chans_cluster_2_no = setdiff(all_sig_chans,frontal_chans);
                        
                        
                        cluster_2 = nan(size(stats.mask));
                        cluster_2_freq_col = [12:14];
                        cluster_2(sel_chans_cluster_2_no,cluster_2_freq_col) = stats.mask(sel_chans_cluster_2_no,cluster_2_freq_col);
                        cluster_2(cluster_2==0) = nan;
                        
                        clusters = {cluster_1 cluster_2 cluster_3 };

                    case 'yes'
                        % cluster 1
                        cluster_1_freq_col = 10; % beta band
                        cluster_1 = nan(size(stats_main.mask));
                        cluster_1(:,cluster_1_freq_col) = stats_main.mask(:,cluster_1_freq_col);
                        cluster_1(cluster_1==0) = nan;
                        
                        
                        cluster_2_freq_col = 12:14; % beta band
                        cluster_2 = nan(size(stats_main.mask));
                        cluster_2(:,cluster_2_freq_col) = stats_main.mask(:,cluster_2_freq_col);
                        cluster_2(cluster_2==0) = nan;
                        
                        
                        cluster_3_freq_col = 7; % alpha band
                        cluster_3 = nan(size(stats_interaction.mask));
                        cluster_3(:,cluster_3_freq_col) = stats_interaction.mask(:,cluster_3_freq_col);
                        cluster_3(cluster_3==0) = nan;
                        
                        clusters = {cluster_1 cluster_2 cluster_3};
                        %% channel confirmation
                        %         cfg= [];cfg.layout = 'IBS_S1_layout_64.mat';s = ft_prepare_layout(cfg);
                        
                        %         [c,d] = find(cluster_1>0)
                        %         [c,d] = find(cluster_2>0)
                        %         [c,d] = find(cluster_3>0)
                        %         ft_plot_layout(s,'box','no','chanindx',unique(c))
                        
                end
        end
end


end
