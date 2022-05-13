function IBS_Granger_causality_dim(cluster_no)
%IBS_GRANGER_CAUSALITY compute conditional granger subjectwise
%
% SYNOPSIS: IBS_Granger_causality
%
% INPUT
%
% OUTPUT
%
% REMARKS
%
% created with MATLAB ver.: 9.8.0.1359463 (R2020a) Update 1 on Microsoft Windows 10 Pro Version 10.0 (Build 19042)
%
% created by: Atesh
% DATE: 09-Jun-2021
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




Dyads = 1:23;
analysis = 'Brain_behavior_glm_power_freqwise';
analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
conditions = {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'};
% analysis_sub_type = '_insta_corr_avg_freqwise';
analysis_sub_type = '_insta_abs_detrend';
% analysis_sub_type = '_insta_abs_no_detrend';

% cluster_no = 2;
glm_result = IBS_brain_behavior_glm(analysis_type,analysis,conditions,analysis_sub_type,'no_plots');
glm_data = glm_result.stats_cell{cluster_no}.Variables;




mapObj = containers.Map({'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned'},...
    {'eye_gaze_distance_joint','mouth_size_joint','ALL_joint'});


analysis_type_params = IBS_get_params_analysis_type(analysis_type,analysis);
analysis_save_dir_figures = analysis_type_params.analysis_save_dir_figures{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
analysis_save_dir = analysis_type_params.analysis_save_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';


save_fname = [analysis_save_dir '\\G_causality_dim_pad_try' analysis_sub_type '_cluster_' num2str(cluster_no)' '.mat'];
if exist(save_fname,'file')
    
    load(save_fname,'granger_Brain2Behav','granger_Behav2Brain','behaviors')
else
    behaviors = {'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned'};
    
    
    granger_Behav2Brain = nan(length(behaviors),length(Dyads));
    granger_Brain2Behav = nan(length(behaviors),length(Dyads));
    % behavior = 'Smile_auto';
    % behavior = 'Gaze_nose_dist';
    % behavior = 'video_openpose_landmarks_manual_cleaned';
    for behav = 1:length(behaviors)
        cur_behav = behaviors{behav};
        for dyd_no = 1:length(Dyads)
            dyad_str = sprintf('Dyad_%0.2d',Dyads(dyd_no));
            sub_data = glm_data(strcmpi(cellstr(glm_data.Dyad_no_Gaze_nose_dist), dyad_str),:);
            for cond = 1:length(conditions)
                
                
                cur_cond = sub_data(strcmpi(cellstr(sub_data.condition_Gaze_nose_dist), conditions{cond}),:);
                x1 = cur_cond.(mapObj(cur_behav))';
                x2 = cur_cond.chan_freq_data';
%                 x1 = normalize(x1,'zscore');
%                 x2 = normalize(x2,'zscore');
                cur_x = [x1;x2];
                cur_x  = padarray(cur_x',1201-size(cur_x,2),0,'post')';
                X(:,:,cond) = cur_x;
            end
            
            
            if ~isempty(X)
                [GC_A2B,GC_B2A] = IBS_compute_granger_causality_data(X);
                
                granger_Behav2Brain(behav,dyd_no) = GC_A2B;
                granger_Brain2Behav(behav,dyd_no) = GC_B2A;
            end
            % this doesn't work
            %        X(1,1:length(cur_cond.(mapObj(behavior))),cond) = cur_cond.(mapObj(behavior))';
            %        X(2,1:length(cur_cond.chan_freq_data'),cond) = cur_cond.chan_freq_data';
            
            
            
            % this doesn't work
            %         if ~isempty(X)
            %         [GC_A2B,GC_B2A] = IBS_Granger_causality(X);
            %
            %         granger_A2B(dyd_no) = GC_A2B;
            %         granger_B2A(dyd_no) = GC_B2A;
            %         end
            %
        end
        
    end
    
    %%
%     save(save_fname,'granger_Brain2Behav','granger_Behav2Brain','behaviors')
    %         save([analysis_save_dir '\\G_causality_cluster_detrended_' num2str(cluster_no)' '.mat'],'granger_Brain2Behav','granger_Behav2Brain','behaviors')
end

sem = @(x,dim) nanstd( x,0,dim ) / sqrt( size( x,dim ));
figure('units','normalized','outerposition',[0 0 1 1])
for behav = 1:length(behaviors)
    cur_granger_Behav2Brain = squeeze(granger_Behav2Brain(behav,:));
    cur_granger_Brain2Behav = squeeze(granger_Brain2Behav(behav,:));
    p = ranksum(cur_granger_Behav2Brain,cur_granger_Brain2Behav)
    if p<0.05
        text(1.5,mean(nanmean(cur_granger_Behav2Brain,2))+2.5*std(mean(nanmean(cur_granger_Behav2Brain,2))),'*','FontSize',20);
    end
    p = signrank(cur_granger_Behav2Brain,cur_granger_Brain2Behav)
    if p<0.05
        text(1.5,mean(nanmean(cur_granger_Behav2Brain,2))+2.5*std(mean(nanmean(cur_granger_Behav2Brain,2))),'*','FontSize',20);
    end
    [h,p] = ttest(cur_granger_Behav2Brain,cur_granger_Brain2Behav)
    if p<0.05
        text(1.5,mean(nanmean(cur_granger_Behav2Brain,2))+2.5*std(mean(nanmean(cur_granger_Behav2Brain,2))),'*','FontSize',20);
    end
    p = signtest(cur_granger_Behav2Brain,cur_granger_Brain2Behav)
    if p<0.05
        text(1.5,mean(nanmean(cur_granger_Behav2Brain,2))+2.5*std(mean(nanmean(cur_granger_Behav2Brain,2))),'*','FontSize',20);
    end
    
    %     p = ranksum(nanmean(cur_granger_Behav2Brain,2),nanmean(cur_granger_Brain2Behav,2));
    subplot(1,length(behaviors),behav)
    bar([mean(nanmean(cur_granger_Behav2Brain,2)),mean(nanmean(cur_granger_Brain2Behav,2))])
    hold on
    errorbar([mean(nanmean(cur_granger_Behav2Brain,2)),mean(nanmean(cur_granger_Brain2Behav,2))],...
        [sem(nanmean(cur_granger_Behav2Brain,2),1),sem(nanmean(cur_granger_Brain2Behav,2),1)],'.')
    
    if p<0.05
        text(1.5,mean(nanmean(cur_granger_Behav2Brain,2))+2.5*std(mean(nanmean(cur_granger_Behav2Brain,2))),'*','FontSize',20);
    end
    ax = gca;
    title(behaviors{behav},'Interpreter','none')
    ylabel('G-causality')
    xtl_behav_brain = '\begin{tabular}{c} From behav  \\ to brain \end{tabular}';
    xtl_brain_behav = '\begin{tabular}{c} From brain \\ to behav \end{tabular}';
    
    set(gca, 'XTickLabel', {xtl_behav_brain xtl_brain_behav}, 'TickLabelInterpreter', 'latex');
    yaxis([0 0.006])
    %
    %     [h,p] = ttest(nanmean(cur_granger_Behav2Brain,2))
    %     [h,p] = ttest(nanmean(cur_granger_Brain2Behav,2))
end
% saveas(gcf,[analysis_save_dir_figures 'G_causality_dim_pad' analysis_sub_type '_cluster_' num2str(cluster_no) '.tif'])
% exportgraphics(gcf,[analysis_save_dir_figures 'G_causality_cluster_' num2str(cluster_no) '.eps'],'BackgroundColor','none','ContentType','vector')
% close all

% for behav = 1:length(behaviors)
%     cur_granger_Behav2Brain = squeeze(granger_Behav2Brain(behav,:,:));
%     cur_granger_Brain2Behav = squeeze(granger_Brain2Behav(behav,:,:));
%     [h,p] = ttest(nanmean(cur_granger_Behav2Brain,2));
%     p
%     [h,p] = ttest(nanmean(cur_granger_Brain2Behav,2));
%     p
% end
end