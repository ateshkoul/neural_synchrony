function [dataset_files,subs,p2p_analysis,conds] = IBS_return_dataset_files(analysis_type)

if nargin<1
    analysis_type = 'no_aggressive_trialwise_CAR';
end

% from Giacomo email
% case 1 % 'LASER'
%             N = 200;
%             P = 350;
%         case 2 % 'ELECTR'
%             N = 125;
%             P = 250;
%         case 3 % 'VIDEO'
%             N = 150;
%             P = 350;
%         case 4 % 'AUDIO'
%             N = 100;
%             P = 200;

analysis_type_params = IBS_get_params_analysis_type(analysis_type);
data_dir = analysis_type_params.data_dir{1,1};


switch(analysis_type)
    
        case 'no_aggressive_trialwise_CAR'
        subs = 1:23;
        
        dataset_files = arrayfun(@(x) [data_dir sprintf('Dyd_%0.2d_ICA_func_clean_bp_03_95_120s.mat',x)],...
            subs,'UniformOutput',false);
        
        
        case 'aggressive_trialwise_CAR'
        subs = 1:23;
        
        dataset_files = arrayfun(@(x) [data_dir sprintf('Dyd_%0.2d_ICA_blocks_only_neck_artefact_clean_bp_03_95_120s.mat',x)],...
            subs,'UniformOutput',false);
        
        case 'no_aggressive_CAR_ASR_5_ICA_appended_trials'
        subs = 1:23;
        
        dataset_files = arrayfun(@(x) [data_dir sprintf('Dyd_%0.2d_CAR_ASR_5_ICA_appended_comp',x)],...
            subs,'UniformOutput',false);

        case 'no_aggressive_CAR_ASR_10_ICA_appended_trials'
        subs = 1:23;
        
        dataset_files = arrayfun(@(x) [data_dir sprintf('Dyd_%0.2d_CAR_ASR_10_ICA_appended_comp',x)],...
            subs,'UniformOutput',false);
        
end



end