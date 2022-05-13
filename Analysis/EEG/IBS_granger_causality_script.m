startup_IBS('granger')


% analysis_sub_type = {'_insta_abs_detrend_corr_avg_freqwise','_insta_abs_detrend'};
analysis_sub_type = {'_insta_abs_detrend'};

glm_type = {'glm'};% {'glm','glm_mod'}
sigtest = {'signrank'};%{'ttest','ranksum','signtest'};% signrank
cellfun(@(glm) cellfun(@(analysis_sub) cellfun(@(test) IBS_Granger_causality(1,analysis_sub,glm,test),sigtest,...
    'UniformOutput',0),analysis_sub_type,'UniformOutput',0),glm_type,'UniformOutput',0)

% close all
cellfun(@(glm) cellfun(@(analysis_sub) cellfun(@(test) IBS_Granger_causality(2,analysis_sub,glm,test),sigtest,...
    'UniformOutput',0),analysis_sub_type,'UniformOutput',0),glm_type,'UniformOutput',0)

% close all
cellfun(@(glm) cellfun(@(analysis_sub) cellfun(@(test) IBS_Granger_causality(3,analysis_sub,glm,test),sigtest,...
    'UniformOutput',0),analysis_sub_type,'UniformOutput',0),glm_type,'UniformOutput',0)



close all
%%

startup_IBS('granger')


% analysis_sub_type = {'_insta_abs_detrend_corr_avg_freqwise','_insta_abs_detrend'};
% analysis_sub_type = {'_insta_abs_detrend_mov_1s'};
% analysis_sub_type = {'_insta_abs_detrend_gamma_200avg'};
% analysis_sub_type = {'_insta_abs_detrend_gamma_200avg_lowess'};
analysis_sub_type = {'_insta_abs_detrend_lowess_variable'};% 
analysis_sub_type = {'_insta_abs_detrend'};
% analysis_sub_type = {'_insta_abs_detrend_movmean_variable'};% 
% analysis_sub_type = {'_insta_abs_detrend_movmean_causal'};% 
analysis_sub_type = {'_insta_abs_detrend_movmean_acausal'};% 
% analysis_sub_type = {'_insta_abs_detrend_movmean_acausal_brain'};% 
% analysis_sub_type = {'_insta_abs_detrend_movmean_causal_brain'};% 

glm_type = {'glm'};% {'glm','glm_mod'}
sigtest = {'signtest'};%{'ttest','ranksum','signtest'};
cellfun(@(glm) cellfun(@(analysis_sub) cellfun(@(test) IBS_Granger_causality(1,analysis_sub,glm,test),sigtest,...
    'UniformOutput',0),analysis_sub_type,'UniformOutput',0),glm_type,'UniformOutput',0)

% close all
cellfun(@(glm) cellfun(@(analysis_sub) cellfun(@(test) IBS_Granger_causality(2,analysis_sub,glm,test),sigtest,...
    'UniformOutput',0),analysis_sub_type,'UniformOutput',0),glm_type,'UniformOutput',0)

% close all
cellfun(@(glm) cellfun(@(analysis_sub) cellfun(@(test) IBS_Granger_causality(3,analysis_sub,glm,test),sigtest,...
    'UniformOutput',0),analysis_sub_type,'UniformOutput',0),glm_type,'UniformOutput',0)



close all
%%

IBS_Granger_causality(1,'_insta_abs_detrend','glm_mod','ttest')



IBS_Granger_causality_dim(1)
IBS_Granger_causality_dim(2)
IBS_Granger_causality_dim(3)

