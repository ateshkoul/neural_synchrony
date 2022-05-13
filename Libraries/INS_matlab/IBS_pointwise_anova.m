function [F,P] = IBS_pointwise_anova(combined_correlations,cond,anova_cond)

% checked that F values for chan 1 and freq 1 are crrect using jamovi
anova_cond_no = ismember(cond,anova_cond);

%% main_effects 

grandavg = arrayfun(@(x) IBS_freqgrandaverage(combined_correlations(:,x)),1:length(cond),'UniformOutput',false);
grandavg_anova = grandavg(:,anova_cond_no);
% 1st trial of F is main effect of Occ, 
% 2nd trial of F is main effect of Distance, 
% {'FaOcc','FaNoOcc','NeOcc', 'NeNoOcc' }
levels = {{'1','2','1','2'}',{'1','1','2','2'}'};

% [F,P] = Giac_rmANOVA(grandavg_anova,'2x2',levels,1:64,'powspctrm');


% faster
[F,P] = Giac_rmANOVA_par(grandavg_anova,'2x2',levels,1:64,'powspctrm');



end