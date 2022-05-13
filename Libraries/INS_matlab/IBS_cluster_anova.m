function [stat_main_effects,stat_interaction] = IBS_cluster_anova(combined_correlations,cond,anova_cond,cond_nos,test_freq,levels)

anova_cond_no = ismember(cond,anova_cond);

%% main_effects 

% grandavg = arrayfun(@(x) IBS_freqgrandaverage(combined_correlations(:,x)),1:length(cond),'UniformOutput',false);
% grandavg_anova = grandavg(:,anova_cond_no);
% grandavg = table(grandavg{:},'VariableNames',cond);
combined_correlations_anova = combined_correlations(:,anova_cond_no);

% grandavg_main_effects = table2cell(grandavg_anova(:,anova_cond));
[stat_main_effects] = arrayfun(@(x) IBS_cluster_main_effects(combined_correlations_anova,x,test_freq,levels),cond_nos,'UniformOutput',false);

%% interaction
[stat_interaction] = IBS_cluster_interaction(combined_correlations_anova,test_freq,levels);
end