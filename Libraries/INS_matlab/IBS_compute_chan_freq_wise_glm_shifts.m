function [betas,deviances,stat_cell] = IBS_compute_chan_freq_wise_glm_shifts(data_analysis_type,analysis,brain_data,behav_data)



stat_cluster = IBS_get_stat_cluster(data_analysis_type,analysis);
% [betas,stat_cell,deviances] = cellfun(@(x) IBS_compute_glm_cluster(brain_data,behav_data,x),...
%     stat_cluster,'UniformOutput',false);

[betas,stat_cell,deviances] = cellfun(@(x) IBS_compute_glm_cluster_shifts(brain_data,behav_data,x),...
    stat_cluster,'UniformOutput',false);

%% for each channel wise

% for chan = 1:n_chans
%     for freq = 1:n_freq
% %         [B,FitInfo] = lassoglm(behavior_data_aligned,squeeze(brain_data(chan,:,freq))');
% % if table
% %         [B,dev,stats] = glmfit(table2array(behav_data),squeeze(brain_data(chan,:,freq))');
%         cur_brain_data = table(squeeze(brain_data(chan,:,freq))','VariableNames',{'chan_freq_data'});
%         cur_brain_data = table(squeeze(nanmean(nanmean(cur_brain_data))),'VariableNames',{'chan_freq_data'});
%         all_data = [cur_brain_data behav_data];
%         all_data = rmmissing(all_data);
%         lme = fitlme(all_data,['chan_freq_data~' all_fixed_var_names '(1|' random_effects_var_name ')']);
%         
%         lme_null = fitlme(all_data,['chan_freq_data~1+(1|' random_effects_var_name ')']);
% 
%         B = lme.Coefficients.Estimate;
%         
%         dev = lme.ModelCriterion.BIC/lme_null.ModelCriterion.BIC;
%         stats = lme;
%         deviances(chan,freq) = dev;
%         stat_cell{chan,freq} = stats;
%         % this is important to track in case there are some features that
%         % are eliminated.
%         betas{chan,freq} = array2table(B','VariableNames',lme.CoefficientNames);
%         
% %         for beta_coef = 1:length(B)
% %             betas(chan,freq,beta_coef) = B(beta_coef);
% % %         betas{chan,freq} = B;
% %         end
%         
%     end
% end


end