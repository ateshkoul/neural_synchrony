function IBS_brain_behavior_crosscorr(analysis_type,behavior,cluster_no,conditions,analysis_sub_type)
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

plot_save = 0;
Dyads = 1:23;
analysis = 'Brain_behavior_glm_power_freqwise';

% lag_no = [];
% conditions = {'NeNoOcc_1' 'NeNoOcc_2' 'NeNoOcc_3'};
% mouth_size = IBS_load_behavior_data(behavior,analysis_type,Dyads,conditions,behav_analysis,output_data);
analysis_type_params = IBS_get_params_analysis_type(analysis_type,analysis);
analysis_save_dir_figures = analysis_type_params.analysis_save_dir_figures{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';
analysis_save_dir = analysis_type_params.analysis_save_dir{1,1};%'D:\\Experiments\\IBS\\Processed\\EEG\\';


glm_result = IBS_brain_behavior_glm(analysis_type,analysis,conditions,analysis_sub_type,'no_plots');

glm_data = glm_result.stats_cell{cluster_no}.Variables;


lags = 100;
xcf_mouth_joint_mat = nan(length(Dyads),2*lags+1);



mapObj = containers.Map({'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned'},...
    {'eye_gaze_distance_joint','mouth_size_joint','ALL_joint'});

result_fname = [analysis_save_dir 'IBS_behav_crosscorr.mat'];

if exist(result_fname,'file')
    load(result_fname)
else  
    
    
    for dyd_no = 1:length(Dyads)
        dyad_str = sprintf('Dyad_%0.2d',Dyads(dyd_no));
        sub_data = glm_data(strcmpi(cellstr(glm_data.Dyad_no_Gaze_nose_dist), dyad_str),:);
        xcf_mouth_joint_mat_cond = nan(2*lags+1,length(conditions));
        %     joint_mouth_size = mouth_size{3}{Dyads(dyd_no)};
        for cond = 1:length(conditions)
            %         S1_value = mouth_size{1}{Dyads(dyd_no)}.mouth_size_0;
            %         S2_value = mouth_size{2}{Dyads(dyd_no)}.mouth_size_1;
            %         S1_value(isnan(S1_value)) = 0;
            %         S2_value(isnan(S2_value)) = 0;
            
            cur_cond = sub_data(strcmpi(cellstr(sub_data.condition_Gaze_nose_dist), conditions{cond}),:);
            %         cur_mouth_size = joint_mouth_size(strcmpi(cellstr(joint_mouth_size.condition_Smile_auto), conditions{cond}),:);
            %         [xcf_mouth_joint,lags,bounds] = crosscorr(cur_cond.mouth_size_joint,cur_cond.chan_freq_data,'Numlags',400);
            
            
            [xcf_mouth_joint] = xcov(cur_cond.(mapObj(behavior)),cur_cond.chan_freq_data,lags,'coeff');
            
            %         lag_no_mouth_joint(Dyads(dyd_no)) = find(xcf_mouth_joint == max(xcf_mouth_joint));
            %         lag_no_mouth_joint(Dyads(dyd_no)) = find(abs(xcf_mouth_joint) == max(abs(xcf_mouth_joint)));
            %         lag_no_mouth_joint_pre(Dyads(dyd_no)) = find(abs(xcf_mouth_joint(1:199)) == max(abs(xcf_mouth_joint(1:199))));
            %         lag_no_mouth_joint_post(Dyads(dyd_no)) = find(abs(xcf_mouth_joint(201:401)) == max(abs(xcf_mouth_joint(201:401))));
            
            xcf_mouth_joint_mat_cond(:,cond) = xcf_mouth_joint;
            
            %         [xcf_mouth_S1,lags,bounds] = crosscorr(S1_value,cur_cond.chan_freq_data,'Numlags',200);
            %         lag_no_mouth_S1(Dyads(dyd_no)) = find(xcf_mouth_S1 == max(xcf_mouth_S1));
            %         xcf_mouth_S1_mat(Dyads(dyd_no),:) = xcf_mouth_S1;
            %
            %         [xcf_mouth_S2,lags,bounds] = crosscorr(S2_value,cur_cond.chan_freq_data,'Numlags',200);
            %         lag_no_mouth_S2(Dyads(dyd_no)) = find(xcf_mouth_S2 == max(xcf_mouth_S2));
            %         xcf_mouth_S2_mat(Dyads(dyd_no),:) = xcf_mouth_S2;
            
        end
        xcf_mouth_joint_mat(Dyads(dyd_no),:) = mean(xcf_mouth_joint_mat_cond,2);
    end
    %% add stats
    [h,p,~,stats] = ttest(xcf_mouth_joint_mat);
    corr_coef_avg = nanmean(xcf_mouth_joint_mat);
    
    sig_loc = mafdr(p,'BHFDR',true)<0.05;
    
    save(result_fname,'xcf_mouth_joint_mat','corr_coef_avg','sig_loc','p',...
        'analysis_type','behavior','cluster_no','conditions','analysis_sub_type')
end

%% plot
%% get cond name
subset = @(x) x{1};

cond_name = cellfun(@(x) subset(strsplit(x,'_')),conditions,'UniformOutput',0);
cond_name = strjoin(unique(cond_name),'_');


%% add plot
sem = @(x,dim) nanstd( x,0,dim ) / sqrt( size( x,dim ));
yu = nanmean(xcf_mouth_joint_mat) + sem(xcf_mouth_joint_mat,1);
yl = nanmean(xcf_mouth_joint_mat) - sem(xcf_mouth_joint_mat,1);
x = 1:length(xcf_mouth_joint_mat);


fill([x  fliplr(x)], [yu fliplr(yl)], [.9 .9 .9], 'linestyle', 'none')

hold all

% plot(x ,corr_coef_avg.*sig_loc,'k','LineWidth',2);
plot(nanmean(xcf_mouth_joint_mat),'r','LineWidth',2)
% plot(x ,corr_coef_avg.*sig_loc,'k','LineWidth',2);
% plot(x(find(sig_loc)) ,corr_coef_avg(find(sig_loc)),'k','LineWidth',2);


xline((length(xcf_mouth_joint_mat)-1)/2)
yline(0)
xticks(0:10:2*lags)
xlim([0 2*lags+1])
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
ax = gca;

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
if(plot_save)
exportgraphics(ax,[analysis_save_dir_figures cond_name analysis_sub_type '_' behavior '_EEG_crosscorr_cluster_' num2str(cluster_no) '_combined_colormap_filled.eps'],'BackgroundColor','none','ContentType','vector')
end
close all
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
