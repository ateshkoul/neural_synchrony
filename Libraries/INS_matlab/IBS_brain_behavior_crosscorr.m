function IBS_brain_behavior_crosscorr(analysis_type,behavior,cluster_no,conditions,analysis_sub_type,glm_type)
%IBS_BRAIN_BEHAVIOR_CROSSCORR perform cross correlations between IBS and behavior
%
% SYNOPSIS: IBS_brain_behavior_crosscorr
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
% DATE: 13-May-2021
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot_save = 1;
Dyads = 1:23;
analysis = 'Brain_behavior_glm_power_freqwise';
% conditions = {'NeNoOcc_1' 'NeNoOcc_2' 'NeNoOcc_3'};

analysis_type_params = IBS_get_params_analysis_type(analysis_type,analysis);
analysis_save_dir_figures = analysis_type_params.analysis_save_dir_figures{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
analysis_save_dir = analysis_type_params.analysis_save_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';



%% get cond name
subset = @(x) x{1};

cond_name = cellfun(@(x) subset(strsplit(x,'_')),conditions,'UniformOutput',0);
cond_name = strjoin(unique(cond_name),'_');
%%
switch(glm_type)
    case 'glm'
        glm_result = IBS_brain_behavior_glm(analysis_type,analysis,conditions,analysis_sub_type,'no_plots');
        
        glm_data = glm_result.stats_cell{cluster_no}.Variables;
        %
        mapObj = containers.Map({'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned'},...
            {'eye_gaze_distance_joint','mouth_size_joint','ALL_joint'});
        
        
%         mapObj = containers.Map({'Eye_tracker_pupil','Smile_auto','video_openpose_landmarks_manual_cleaned'},...
%             {'diameter_joint','mouth_size_joint','ALL_joint'});
%         
        
        result_fname = [analysis_save_dir 'IBS_brain_behav_crosscorr\\' 'IBS_behav_crosscorr_smile_cor7' analysis_sub_type '_' cond_name '_' behavior '_' num2str(cluster_no) '.mat' ];
        result_fig_name = [analysis_save_dir_figures '\\Crosscorr\\smile_cor7' cond_name analysis_sub_type '_' behavior '_clust' num2str(cluster_no) '.eps'];
        result_fig_name = [analysis_save_dir_figures '\\Crosscorr\\' cond_name analysis_sub_type '_' behavior '_clust' num2str(cluster_no) '.eps'];
       
    case 'glm_mod'
        glm_result = IBS_brain_behavior_glm_modulation(analysis_type,analysis,conditions,analysis_sub_type,'no_plots');
        glm_data = glm_result.stats_cell{cluster_no}.Variables;
        
        mapObj = containers.Map({'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned', ...
            'Gaze_nose_dist-Smile_auto','Gaze_nose_dist-video_openpose_landmarks_manual_cleaned'},...
            {'eye_gaze_distance_joint','mouth_size_joint','ALL_joint',...
            'eye_0mouth_size_1mouth_size_0eye_1','eye_0ALL_1ALL_0eye_1'});
        result_fname = [analysis_save_dir 'IBS_brain_behav_crosscorr\\' 'IBS_behav_crosscorr_Mod' analysis_sub_type '_' cond_name '_' behavior '_' num2str(cluster_no) '.mat' ];
        result_fig_name = [analysis_save_dir_figures '\\Crosscorr\\Mod_' cond_name analysis_sub_type '_' behavior '_clust' num2str(cluster_no) '.eps'];
        
%         result_fname = [analysis_save_dir 'IBS_brain_behav_crosscorr\\' 'IBS_behav_crosscorr_Mod_50' analysis_sub_type '_' cond_name '_' behavior '_' num2str(cluster_no) '.mat' ];
%         result_fig_name = [analysis_save_dir_figures '\\Crosscorr\\Mod_50_' cond_name analysis_sub_type '_' behavior '_clust' num2str(cluster_no) '.tif'];
%         
    case 'physio'
        glm_result = IBS_brain_behavior_glm_physiology(analysis_type,analysis,conditions,analysis_sub_type,'no_plots');
        
        glm_data = glm_result.stats_cell{cluster_no}.Variables;
        %
        mapObj = containers.Map({'Eye_tracker_pupil','ECG','EDA'},...
            {'diameter_joint','ECG_Rate_joint','EDA_Phasic_joint'});
        
        
%         mapObj = containers.Map({'Eye_tracker_pupil','Smile_auto','video_openpose_landmarks_manual_cleaned'},...
%             {'diameter_joint','mouth_size_joint','ALL_joint'});
%         
        
        result_fname = [analysis_save_dir 'IBS_brain_behav_crosscorr\\' 'IBS_physio_crosscorr' analysis_sub_type '_' cond_name '_' behavior '_' num2str(cluster_no) '.mat' ];
        result_fig_name = [analysis_save_dir_figures '\\Crosscorr\\IBS_physio_crosscorr' cond_name analysis_sub_type '_' behavior '_clust' num2str(cluster_no) '.eps'];
        
end


%%
% result_fname = [analysis_save_dir 'IBS_behav_crosscorr_' cond_name '_' behavior '_' num2str(cluster_no) '.mat' ];

if exist(result_fname,'file')
    load(result_fname,'xcf_mouth_joint_mat','corr_coef_avg','sig_loc','p',...
        'analysis_type','behavior','cluster_no','conditions','analysis_sub_type','stats','lags')
else
    
    lags = 100;
    xcf_mouth_joint_mat = nan(length(Dyads),2*lags+1);
    
    
    cond_cols = find(contains(glm_data.Properties.VariableNames,'condition'));
    cond_col_name = glm_data.Properties.VariableNames{cond_cols(1)};
    
    dyad_cols = find(contains(glm_data.Properties.VariableNames,'Dyad'));
    dyad_col_name = glm_data.Properties.VariableNames{dyad_cols(1)};   
    for dyd_no = 1:length(Dyads)
        dyad_str = sprintf('Dyad_%0.2d',Dyads(dyd_no));
        % behavior
%         sub_data = glm_data(strcmpi(cellstr(glm_data.Dyad_no_Gaze_nose_dist), dyad_str),:);
        % physiology
%         sub_data = glm_data(strcmpi(cellstr(glm_data.Dyad_no_Eye_tracker_pupil), dyad_str),:);
        sub_data = glm_data(strcmpi(cellstr(glm_data.(dyad_col_name)), dyad_str),:);
        xcf_mouth_joint_mat_cond = nan(2*lags+1,length(conditions));
        for cond = 1:length(conditions)
            
            % for behaviors
%             cur_cond = sub_data(strcmpi(cellstr(sub_data.condition_Gaze_nose_dist), conditions{cond}),:);
            % for physiology
%             cur_cond = sub_data(strcmpi(cellstr(sub_data.condition_Eye_tracker_pupil), conditions{cond}),:);
            cur_cond = sub_data(strcmpi(cellstr(sub_data.(cond_col_name)), conditions{cond}),:);
            
            [xcf_mouth_joint] = xcov(cur_cond.(mapObj(behavior)),cur_cond.chan_freq_data,lags,'coeff');
%             [xcf_mouth_joint] = xcov(smoothdata(cur_cond.(mapObj(behavior)),'movmean',20),cur_cond.chan_freq_data,lags,'coeff');
           
            xcf_mouth_joint_mat_cond(:,cond) = xcf_mouth_joint;
            
            
        end
        xcf_mouth_joint_mat(Dyads(dyd_no),:) = mean(xcf_mouth_joint_mat_cond,2);
    end
    %% add stats
    [h,p,~,stats] = ttest(xcf_mouth_joint_mat);
    
    % physio 
%     p = arrayfun(@(x) signrank(xcf_mouth_joint_mat(:,x)),1:101);
    corr_coef_avg = nanmean(xcf_mouth_joint_mat);
    
    sig_loc = mafdr(p,'BHFDR',true)<0.05;
    
%     save(result_fname,'xcf_mouth_joint_mat','corr_coef_avg','sig_loc','p',...
%         'analysis_type','behavior','cluster_no','conditions','analysis_sub_type','stats','lags')
end

%% plot


%% add plot
figure;
sem = @(x,dim) nanstd( x,0,dim ) / sqrt( size( x,dim ));
yu = nanmean(xcf_mouth_joint_mat) + sem(xcf_mouth_joint_mat,1);
yl = nanmean(xcf_mouth_joint_mat) - sem(xcf_mouth_joint_mat,1);
x = 1:size(xcf_mouth_joint_mat,2);


fill([x  fliplr(x)], [yu fliplr(yl)], [.9 .9 .9], 'linestyle', 'none')

hold all

% plot(x ,corr_coef_avg.*sig_loc,'k','LineWidth',2);
plot(nanmean(xcf_mouth_joint_mat),'r','LineWidth',2)
% plot(x ,corr_coef_avg.*sig_loc,'k','LineWidth',2);
% plot(x(find(sig_loc)) ,corr_coef_avg(find(sig_loc)),'k','LineWidth',2);

% important to have +1
xline(((length(xcf_mouth_joint_mat)-1)/2)+1)
yline(0)
% xticks(0:10:2*lags)
xticks(1:10:(2*lags+1))
xlim([1 2*lags+1])
% ylim(mapObj_ylims(behavior))
xticklabels(((0:10:2*lags) - lags)/10)

xlabel('lags (in sec)')
ylabel('corr coeff')
% ylim([-0.1 0.1])
ylim([-0.08 0.08])

% scatter(find(sig_loc),corr_coef_avg(find(sig_loc)),'k')
scatter(find(sig_loc),corr_coef_avg(find(sig_loc)),20,'k','filled')
% scatter(find(sig_loc),corr_coef_avg(find(sig_loc)),'k','filled')

imagesc(1:201,[-0.035 -0.045],stats.tstat,[-6 6])
title([cond_name analysis_sub_type '_' behavior '_crosscorr_clust_' num2str(cluster_no)],'Interpreter','none')

T = [0,   0,   0
    93,109,230 % blue
    92,205,230 % light blue
    %                 142,230,71 % dark green
    %                 135,230,156 % light green
    214,107,77 % red
    230,204,10
    229,245,2]./255;

x = [0
    80
    120
    140
    %                 165
    210
    255];
map = interp1(x/255,T,linspace(0,1,255));

colormap(map)

% [a,b] = max(nanmean(xcf_mouth_joint_mat))
% s = -100:100
% s(b)/10

% 87-110 for body
% 71-138
if(plot_save)
    %     saveas(gcf,[analysis_save_dir_figures cond_name analysis_sub_type '_' behavior '_EEG_crosscorr_cluster_' num2str(cluster_no) '.tif'])
    %     saveas(gcf,[analysis_save_dir_figures 'no_detrend_' cond_name analysis_sub_type '_' behavior '_clust' num2str(cluster_no) '.tif'])
    %     saveas(gcf,[analysis_save_dir_figures '\\Crosscorr\\' cond_name analysis_sub_type '_' behavior '_clust' num2str(cluster_no) '.tif'])
%     saveas(gcf,result_fig_name)
    exportgraphics(gcf,result_fig_name,'BackgroundColor','none','ContentType','vector')
end
% close all
end
%% old tries
%
%
%
%
%
% % cond_name = [cond_name '_all_norm'];
% %%
%
%
%
% % figure('units','normalized','outerposition',[0 0 0.5 0.8])
% % shows the lags between the smile of the two individuals
% sem = @(x,dim) nanstd( x,0,dim ) / sqrt( size( x,dim ));
% yu = nanmean(xcf_mouth_joint_mat) + sem(xcf_mouth_joint_mat,1);
% yl = nanmean(xcf_mouth_joint_mat) - sem(xcf_mouth_joint_mat,1);
% x = 1:length(xcf_mouth_joint_mat);
%
% %%
% % fill([x fliplr(x)], [yu fliplr(yl)], [.9 .9 .9], 'linestyle', 'none')
% % hold all
% % % plot(nanmean(xcf_mouth_joint_mat),'--rs','LineWidth',2)
% % plot(nanmean(xcf_mouth_joint_mat),'r','LineWidth',2)
% % xline((length(xcf_mouth_joint_mat)-1)/2)
% % yline(0)
% % xticks(0:10:2*lags)
% % xlim([0 2*lags+1])
% % % ylim(mapObj_ylims(behavior))
% % xticklabels(((0:10:2*lags) - lags)/10)
% % xlabel('lags (in sec)')
% % ylabel('corr coeff')
% % % ylim([-0.1 0.1])
% % ylim([-0.08 0.08])
% %% add stats
% % [h,p,~,stats] = ttest(xcf_mouth_joint_mat);
% % corr_coef_avg = nanmean(xcf_mouth_joint_mat);
% %
% % sig_loc = mafdr(p,'BHFDR',true)<0.05;
%
% fill([x  fliplr(x)], [yu fliplr(yl)], [.9 .9 .9], 'linestyle', 'none')
%
% hold all
%
% % plot(x ,corr_coef_avg.*sig_loc,'k','LineWidth',2);
% plot(nanmean(xcf_mouth_joint_mat),'r','LineWidth',2)
% % plot(x ,corr_coef_avg.*sig_loc,'k','LineWidth',2);
% % plot(x(find(sig_loc)) ,corr_coef_avg(find(sig_loc)),'k','LineWidth',2);
%
%
% xline((length(xcf_mouth_joint_mat)-1)/2)
% yline(0)
% xticks(0:10:2*lags)
% xlim([0 2*lags+1])
% % ylim(mapObj_ylims(behavior))
% xticklabels(((0:10:2*lags) - lags)/10)
% xlabel('lags (in sec)')
% ylabel('corr coeff')
% % ylim([-0.1 0.1])
% ylim([-0.08 0.08])
%
% % scatter(find(sig_loc),corr_coef_avg(find(sig_loc)),'k')
% scatter(find(sig_loc),corr_coef_avg(find(sig_loc)),20,'k','filled')
% % scatter(find(sig_loc),corr_coef_avg(find(sig_loc)),'k','filled')
%
% imagesc(1:201,[-0.035 -0.045],stats.tstat,[-6 6])
%
%
%
% %% save
%
% % figure('units','normalized','outerposition',[0 0 0.3 0.8])
% % plot(xcf_mouth_joint_mat')
% %
% % hold on
% % plot(mean(xcf_mouth_joint_mat),'--rs','LineWidth',2)
% % xline((length(xcf_mouth_joint_mat)-1)/2)
% % ylim([-0.3 0.3])
% % xticks(0:50:2*lags)
% % xlim([0 2*lags+1])
% % xticklabels((0:50:2*lags) - lags)
% % xlabel('lags')
% % ylabel('corr coeff')
% title([cond_name analysis_sub_type '_' behavior '_crosscorr_clust_' num2str(cluster_no)],'Interpreter','none')
% ax = gca;
%
%
%
% T = [0,   0,   0
%     93,109,230 % blue
%     92,205,230 % light blue
%     %                 142,230,71 % dark green
%     %                 135,230,156 % light green
%     214,107,77 % red
%     230,204,10
%     229,245,2]./255;
%
% x = [0
%     80
%     120
%     140
%     %                 165
%     210
%     255];
% map = interp1(x/255,T,linspace(0,1,255));
%
% colormap(map)
%
%
% exportgraphics(ax,[analysis_save_dir_figures cond_name analysis_sub_type '_' behavior '_EEG_crosscorr_cluster_' num2str(cluster_no) '_combined_colormap_filled.eps'],'BackgroundColor','none','ContentType','vector')
%
%
%
%
%
% % % saveas(gcf,[analysis_save_dir_figures cond_name analysis_sub_type '_' behavior '_EEG_crosscorr_cluster_' num2str(cluster_no) '_.tif'])
% % % saveas(gcf,[analysis_save_dir_figures cond_name analysis_sub_type '_' behavior '_EEG_crosscorr_cluster_' num2str(cluster_no) '_lim_2.tif'])
%
% %% t-stat
% % figure('units','normalized','outerposition',[0 0 0.5 0.8])
% % [h,p,~,stats] = ttest(xcf_mouth_joint_mat);
% % % plot(stats.tstat,'--rs','LineWidth',2)
% % % plot(stats.tstat,'--bs','LineWidth',2)
% % % hold on
% % plot(stats.tstat.*(mafdr(p)<0.05),'--rs','LineWidth',2)
% %
% %
% % xline((length(xcf_mouth_joint_mat)-1)/2)
% % yline(0)
% % xticks(0:50:2*lags)
% % xlim([0 2*lags+1])
% % % ylim(mapObj_ylims(behavior))
% % xticklabels((0:50:2*lags) - lags)
% % xlabel('lags')
% % ylabel('t-stat')
% % % ylim([-0.1 0.1])
% % ylim([-10 10])
% % title([cond_name analysis_sub_type '_' behavior '_crosscorr_clust_' num2str(cluster_no)],'Interpreter','none')
% %
% % % [h,p] = ttest(lag_no_mouth_joint_pre*0.1,lag_no_mouth_joint_post*0.1)
% % saveas(gcf,[analysis_save_dir_figures 'new_t_stat_sig_' cond_name analysis_sub_type '_' behavior '_EEG_crosscorr_cluster_' num2str(cluster_no) '_lim_2.tif'])
% %
% % % saveas(gcf,[analysis_save_dir_figures 't_stat_sig_100_lags_' cond_name analysis_sub_type '_' behavior '_EEG_crosscorr_cluster_' num2str(cluster_no) '_lim_2.tif'])
% %
% %
% %
%
%
