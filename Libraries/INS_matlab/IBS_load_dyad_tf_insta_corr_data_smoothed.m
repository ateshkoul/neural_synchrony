%% A function to load the tf moving corr subwise IBS dataset
function [insta_correlation,conditions,save_fname,insta_correlation_dyad] = IBS_load_dyad_tf_insta_corr_data_smoothed(data_analysis_type,Dyads,selected_conditions)
%% Atesh
% 23-12-2020
% updated 28-01-2021: added possibility of having more than 1 condition
% added in inner loop so that the matfiles are loaded only once - for time
% efficiency

if nargin <2
    %     Dyads = [1:11 13:18 20:23];
    %     Dyads = [1:11 13];
    Dyads = 1:23;
    
    %Dyads = [1:11 13:18];
    
end
analysis = 'Moving_window';
analysis_type_params = IBS_get_params_analysis_type(data_analysis_type,analysis);


% data_dir = analysis_type_params.data_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
analysis_save_dir = analysis_type_params.analysis_save_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
conditions = analysis_type_params.conditions;
analysis_save_dir = [analysis_save_dir 'Subwise\\'];

% if strcmp(selected_conditions{1,1},'all')
%     insta_correlation = cell(1,length(Dyads));
%     
%     for Dyad = 1:length(Dyads)
%         
%         
%         
%         save_fname = [analysis_save_dir sprintf('Dyd_%0.1d_trialwise_instantaneous_corr_all_dyads_baseline_normchange_0_120s_CAR.mat',Dyads(Dyad))];
%         
%         insta_correlation_dyad = load(save_fname,'instantaneous_correlation','conditions');
%         insta_correlation_dyad = insta_correlation_dyad.instantaneous_correlation{1,1};
%         [nblocks,nChan,nFreq,nTimepoints] = size(insta_correlation_dyad{1,1});
%         reshape_fun = @(x) permute(reshape(shiftdim(x,1),[nChan nFreq nTimepoints*nblocks]),[1 3 2]);
%         insta_correlation_dyad = cellfun(@(x) reshape_fun(x),insta_correlation_dyad,'UniformOutput',0);
%         insta_correlation{Dyad} = cat(2,insta_correlation_dyad{:});
%         
%     end
% else
%     
    
    
    
    
    insta_correlation = cell(1,length(Dyads));
    % cur_condition = selected_conditions{condition_no};
    
    condition_split = cellfun(@(x) strsplit(x,'_'),selected_conditions,'UniformOutput',false);
    condition_names = cellfun(@(x) x(1),condition_split,'UniformOutput',false);
    block_nos = cell2mat(cellfun(@(x) str2num(x{2}),condition_split,'UniformOutput',false));
    condition_nos = cell2mat(cellfun(@(x) find(ismember(conditions,x)),condition_names,'UniformOutput',false));
    % condition_nos = unique(cell2mat(cellfun(@(x) find(ismember(conditions,x)),condition_names,'UniformOutput',false)));
    
    unique_conds = unique(condition_nos);
    
    windowSize = 2;%sec
    fs = 10; %Hz
    windowSize_cols = windowSize * fs;
    smooth_dim = 2;
    for Dyad = 1:length(Dyads)
        
        
        
%         save_fname = [analysis_save_dir sprintf('Dyd_%0.1d_trialwise_instantaneous_corr_all_dyads_baseline_normchange_0_120s_CAR.mat',Dyads(Dyad))];
        save_fname = [analysis_save_dir sprintf('Dyd_%0.1d_instantaneous_corr_smooth_2_s.mat',Dyads(Dyad))];

        insta_correlation_dyad = load(save_fname,'instantaneous_correlation','conditions');
        %         moving_correlation{Dyads(Dyad)}{condition_no} = moving_correlation_dyad.moving_correlation{1,1}{ismember(conditions,condition_name)}{block_no};
        insta_correlation_condition = cell(1,length(unique(condition_nos)));
        for condition_no = 1:length(unique(condition_nos))
            cur_condition_no = unique_conds(condition_no);
            cur_blocks = block_nos(condition_nos == cur_condition_no);
            %         insta_correlation_all_cond_blocks = cat(2,insta_correlation_dyad.instantaneous_correlation{1,1}{cur_condition_no});
            % this doesn't cat anything really. it just was possibly there
            % for previous analysis type
%             insta_correlation_all_cond_blocks = cat(2,insta_correlation_dyad.instantaneous_correlation{cur_condition_no});
            insta_correlation_all_cond_blocks = insta_correlation_dyad.instantaneous_correlation{cur_condition_no};

            [nblocks,nChan,nFreq,nTimepoints] = size(insta_correlation_all_cond_blocks);
            %             insta_correlation_condition{condition_no} = reshape(shiftdim(insta_correlation_all_cond_blocks(cur_blocks,:,:,:),1),[nChan nFreq nTimepoints*length(cur_blocks)]);
            %             insta_correlation_condition{condition_no} = permute(insta_correlation_condition{condition_no},[1 3 2]);
            %             insta_correlation_condition{condition_no} = smoothdata(insta_correlation_condition{condition_no},smooth_dim,'movmean',windowSize_cols);
            
            insta_correlation_condition_cur_block = cell(1,length(cur_blocks));
            for block = 1:length(cur_blocks)
                insta_correlation_condition_cur_block{block} = reshape(shiftdim(insta_correlation_all_cond_blocks(block,:,:,:),1),[nChan nFreq nTimepoints]);
                insta_correlation_condition_cur_block{block} = permute(insta_correlation_condition_cur_block{block},[1 3 2]);
                %% does it make sense to smooth it here?
                % better not to smooth the data - this is bacause insta
                % corr + smoothing change stuff
%                 insta_correlation_condition_cur_block{block} = smoothdata(insta_correlation_condition_cur_block{block},smooth_dim,'movmean',windowSize_cols);
                %% not necessary to normalize here because later have to average for the cluster
                % may be here is not the place to normalize the data - have to
                % average it for freqwise
                % normalize it here when it it easy to do. and do it block wise
                % not condition wise
                %             insta_correlation_condition_cur_block{block} = normalize(insta_correlation_condition_cur_block{block},'zscore');
            end
            
            insta_correlation_condition{condition_no} = cat(2,insta_correlation_condition_cur_block{:});
        end
%         insta_correlation{Dyads(Dyad)} = cat(2,insta_correlation_condition{:});
        insta_correlation{Dyad} = cat(2,insta_correlation_condition{:});
  
    end
    %         save(saved_fname_processed,'moving_correlation_processed','conditions','analysis_type','Dyads','-v7.3');
% end
end