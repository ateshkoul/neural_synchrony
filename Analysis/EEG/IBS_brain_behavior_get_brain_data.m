function [brain_data,brain_data_sub] = IBS_brain_behavior_get_brain_data(data_analysis_type,analysis,Dyads,condition,analysis_sub_type)


switch(analysis_sub_type)
    case '_IBS_moving_win'
        %% load brain data
        freq_bands = 1:95;
        windowSize = 5;
        brain_data_sub = IBS_load_dyad_tf_moving_corr(data_analysis_type,freq_bands,windowSize,Dyads,condition);
        
        
        if contains(analysis,'freqwise')
            brain_data_sub = IBS_remove_empty_dyads(brain_data_sub);
            
            brain_data_sub = cellfun(@(y) IBS_compute_freqwise(data_analysis_type,permute(y,[1 3 2])),...
                brain_data_sub,'UniformOutput',false);
            brain_data_sub = cellfun(@(x) permute(x,[1 3 2]),brain_data_sub,'UniformOutput',false);
            
        end
        
    case {'_insta','_insta_20','_insta_50'}
        %% this is possibly better compared to moving win because it seems to capture the changes in tf at the same time
        brain_data_sub = IBS_load_dyad_tf_insta_corr(data_analysis_type,Dyads,condition,analysis_sub_type);
        
        
        if contains(analysis,'freqwise')
            brain_data_sub = IBS_remove_empty_dyads(brain_data_sub);
            
            brain_data_sub = cellfun(@(y) IBS_compute_freqwise(data_analysis_type,permute(y,[1 3 2])),...
                brain_data_sub,'UniformOutput',false);
            brain_data_sub = cellfun(@(x) permute(x,[1 3 2]),brain_data_sub,'UniformOutput',false);
            
        end
    case {'_insta_abs_detrend','_insta_abs_detrend_mov_1s',...
            '_insta_abs_detrend_gamma_200avg','_insta_abs_detrend_gamma_200avg_lowess',...
            '_insta_abs_detrend_lowess_variable','_insta_abs_detrend_movmean_variable'}
        %% this is possibly better compared to moving win because it seems to capture the changes in tf at the same time
        brain_data_sub = IBS_load_dyad_tf_insta_corr(data_analysis_type,Dyads,condition,analysis_sub_type);
        if contains(analysis,'freqwise')
            brain_data_sub = IBS_remove_empty_dyads(brain_data_sub);
            
            brain_data_sub = cellfun(@(y) IBS_compute_freqwise(data_analysis_type,permute(y,[1 3 2])),...
                brain_data_sub,'UniformOutput',false);
            brain_data_sub = cellfun(@(x) permute(x,[1 3 2]),brain_data_sub,'UniformOutput',false);
            
        end
   case {'_insta_abs_detrend_movmean_causal','_insta_abs_detrend_movmean_acausal',...
           '_insta_abs_detrend_movmean_acausal_brain','_insta_abs_detrend_movmean_causal_brain'}
       analysis_sub_type =  '_insta_abs_detrend';
       %% this is possibly better compared to moving win because it seems to capture the changes in tf at the same time
        brain_data_sub = IBS_load_dyad_tf_insta_corr(data_analysis_type,Dyads,condition,analysis_sub_type);
        if contains(analysis,'freqwise')
            brain_data_sub = IBS_remove_empty_dyads(brain_data_sub);
            
            brain_data_sub = cellfun(@(y) IBS_compute_freqwise(data_analysis_type,permute(y,[1 3 2])),...
                brain_data_sub,'UniformOutput',false);
            brain_data_sub = cellfun(@(x) permute(x,[1 3 2]),brain_data_sub,'UniformOutput',false);
            
        end 
    case {'_insta_abs_no_detrend'}
        %% this is possibly better compared to moving win because it seems to capture the changes in tf at the same time
        
        brain_data_sub = IBS_load_dyad_tf_insta_corr(data_analysis_type,Dyads,condition,analysis_sub_type);
        
        
        if contains(analysis,'freqwise')
            brain_data_sub = IBS_remove_empty_dyads(brain_data_sub);
            
            brain_data_sub = cellfun(@(y) IBS_compute_freqwise(data_analysis_type,permute(y,[1 3 2])),...
                brain_data_sub,'UniformOutput',false);
            brain_data_sub = cellfun(@(x) permute(x,[1 3 2]),brain_data_sub,'UniformOutput',false);
            
        end
    case '_insta_20_data_smoothed'
        %% this is possibly better compared to moving win because it seems to capture the changes in tf at the same time
        brain_data_sub = IBS_load_dyad_tf_insta_corr_data_smoothed(data_analysis_type,Dyads,condition);
        
        
        if contains(analysis,'freqwise')
            brain_data_sub = IBS_remove_empty_dyads(brain_data_sub);
            
            brain_data_sub = cellfun(@(y) IBS_compute_freqwise(data_analysis_type,permute(y,[1 3 2])),...
                brain_data_sub,'UniformOutput',false);
            brain_data_sub = cellfun(@(x) permute(x,[1 3 2]),brain_data_sub,'UniformOutput',false);
            
        end
    case {'_insta_corr_avg_freqwise','_insta_abs_corr_avg_freqwise','_insta_abs_behav_corr_avg_freqwise',...
            '_insta_abs_no_detrend_behav_corr_avg_freqwise'}
        
        brain_data_sub = IBS_load_dyad_tf_insta_corr_avg_freqwise(data_analysis_type,Dyads,condition,analysis_sub_type);
    case {'_insta_abs_anti_corr_avg_freqwise','_insta_abs_ind_corr_avg_freqwise','_insta_abs_xor_corr_avg_freqwise'}
        analysis_sub_type ='_insta_abs_corr_avg_freqwise';
        brain_data_sub = IBS_load_dyad_tf_insta_corr_avg_freqwise(data_analysis_type,Dyads,condition,analysis_sub_type);
        
    case {'_insta_abs_detrend_behav_corr_avg_freqwise','_insta_abs_detrend_corr_avg_freqwise'}
        analysis_sub_type = '_insta_abs_detrend_corr_avg_freqwise';
        brain_data_sub = IBS_load_dyad_tf_insta_corr_avg_freqwise(data_analysis_type,Dyads,condition,analysis_sub_type);
    case '_insta_abs_detrend_freqwise'
        
        analysis_sub_type = '_insta_abs_detrend';
        brain_data_sub = IBS_load_dyad_tf_insta_corr_avg_freqwise(data_analysis_type,Dyads,condition,analysis_sub_type);
        if contains(analysis,'freqwise')
            brain_data_sub = IBS_remove_empty_dyads(brain_data_sub);
            
            brain_data_sub = cellfun(@(y) IBS_compute_freqwise(data_analysis_type,permute(y,[1 3 2])),...
                brain_data_sub,'UniformOutput',false);
            brain_data_sub = cellfun(@(x) permute(x,[1 3 2]),brain_data_sub,'UniformOutput',false);
            
        end
    case '_insta_corr_avg_freqwise_50'
        % right now set for 50
        brain_data_sub = IBS_load_dyad_tf_insta_corr_avg_freqwise(data_analysis_type,Dyads,condition,analysis_sub_type);
end
%%
% % remove dyads 7 and 13 that have lesser behav data.
% Dyads_full = setdiff(Dyads,[7,13]);
%
% % Dyads = 1:23;
% % Dyads = [1:6 8:12 14:23];
% % Dyads = 1:5;
%
% % data_analysis_type = 'no_aggressive_trialwise_CAR';
% % analysis = 'Brain_behavior_glm';
% % condition = 'NeNoOcc_1';
%
% %% load brain data
% freq_bands = 1:95;
% windowSize = 5;
% brain_data_sub = IBS_load_dyad_tf_moving_corr(data_analysis_type,freq_bands,windowSize,Dyads_full,condition);
%
% % condition_7 = condition([1 2 4 5 6]);
% if sum(Dyads == 7)
% condition_7 = setdiff(condition,'FaNoOcc_3');
% Dyad_7 = 7;
% brain_data_sub_7 = IBS_load_dyad_tf_moving_corr(data_analysis_type,freq_bands,windowSize,Dyad_7,condition_7);
% brain_data_sub{1,Dyad_7} = brain_data_sub_7{Dyad_7};
%
% end
% if sum(Dyads == 13)
% % condition_13 = condition([1 3 4 5 6]);
% condition_13 = setdiff(condition,'FaNoOcc_2');
% Dyad_13 = 13;
% brain_data_sub_13 = IBS_load_dyad_tf_moving_corr(data_analysis_type,freq_bands,windowSize,Dyad_13,condition_13);
%
% brain_data_sub{1,Dyad_13} = brain_data_sub_13{Dyad_13};
% end
%%
% if contains(analysis,'freqwise')
%     brain_data_sub = IBS_remove_empty_dyads(brain_data_sub);
%
%     brain_data_sub = cellfun(@(y) IBS_compute_freqwise(data_analysis_type,permute(y,[1 3 2])),...
%         brain_data_sub,'UniformOutput',false);
%     brain_data_sub = cellfun(@(x) permute(x,[1 3 2]),brain_data_sub,'UniformOutput',false);
%
% end


brain_data = cat(2,brain_data_sub{:});
end