function IBS_behav_behav_cov
%IBS_BEHAV_BEHAV_COV
%
% SYNOPSIS: IBS_behav_behav_cov
%
% INPUT Function to check covariation between different behaviors
%
% OUTPUT
%
% REMARKS
%
% created with MATLAB ver.: 9.8.0.1359463 (R2020a) Update 1 on Microsoft Windows 10 Pro Version 10.0 (Build 19042)
%
% created by: Atesh
% DATE: 12-Aug-2021
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin<1
    matplot = 0;
end
behaviors = {'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned'};

behav_analysis = 'joint';
output_data = 'no_joint';

Dyads = 1:23;
% lag_no = [];
analysis = 'Brain_behavior_glm_power_freqwise';
data_analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';

save_dir_figures = IBS_get_params_analysis_type(data_analysis_type,analysis).analysis_save_dir_figures{1,1};
save_dir = IBS_get_params_analysis_type(data_analysis_type,analysis).analysis_save_dir{1,1};

analysis_sub_type = '_insta_corr_avg_freqwise';
% behavior_data = cellfun(@(x) IBS_load_behavior_data(x,data_analysis_type,Dyads,conditions,behav_analysis,analysis_sub_type),...
%     behaviors,'UniformOutput',false);
conditions = {{'NeNoOcc_1'}, {'NeNoOcc_2'}, {'NeNoOcc_3'} ,{'FaNoOcc_1'},{'FaNoOcc_2'},{'FaNoOcc_3'}};

% result_fname = [save_dir 'behav_behav_cov_subwise.csv'];
result_fname = [save_dir 'behav_behav_cov_subwise.mat'];

if exist(result_fname,'file')
    avg_over_conditions = load(result_fname);

    avg_over_conditions = table2array(readtable(result_fname));
    cov_comb = combnk(1:length(behaviors),2);
    subset = @(x) x{1};
    short_labels = cellfun(@(x) subset(strsplit(x,'_')),behaviors(cov_comb),'UniformOutput',0);
    
else
    
    
    behavior_data = cellfun(@(x) cellfun(@(y) IBS_load_behavior_data(x,data_analysis_type,...
        Dyads,y,behav_analysis,analysis_sub_type,output_data),conditions,'UniformOutput',false),...
        behaviors,'UniformOutput',false);
    
    % mapObj = containers.Map({'Gaze_nose_dist','Smile_auto','video_openpose_landmarks_manual_cleaned'},...
    %     {'eye_gaze_distance','mouth_size','ALL'});
    
    
    cov_comb = combnk(1:length(behaviors),2);
    cov_matrix = nan(numel(conditions),2*length(Dyads),length(cov_comb));
    for comb= 1:length(cov_comb)
        cur_comb = cov_comb(comb,:);
        
        cur_behavior_data = behavior_data(cur_comb);
        
        cur_cov = cellfun(@(x,y) cellfun(@(s,t) cellfun(@(m,n) ...
            cellfun(@(p,q) nancorr(table2array(p(:,1)),table2array(q(:,1))),m,n,'UniformOutput',false),...
            s,t,'UniformOutput',false),x,y,'UniformOutput',false),...
            cur_behavior_data(1),cur_behavior_data(2),'UniformOutput',false);
        
        cur_cov = cat(1,cur_cov{:});
        cur_cov = cat(1,cur_cov{:});
        cur_cov = cat(1,cur_cov{:});
        
        % it makes sense to reshape the data because the two subjects are taken
        % individually rather than together. this increases the effective no of
        % subjects are 46. The reshaping puts S1 and S2 close to each other -
        % checked this.
        cov_matrix(:,:,comb) = reshape(cell2mat(cur_cov),[numel(conditions) 2*length(Dyads)]);
        % cov_matrix(:,:,comb) =cell2mat(cur_cov);
        
    end
    
    % 12-08-2021
    % this is ok to do because u want to average across the conditions
    avg_over_conditions = squeeze(nanmean(cov_matrix));
    subset = @(x) x{1};
    short_labels = cellfun(@(x) subset(strsplit(x,'_')),behaviors(cov_comb),'UniformOutput',0);
    
    avg_over_conditions_table = array2table(avg_over_conditions,'VariableNames',arrayfun(@(x) strjoin(short_labels(x,:),'-'),1:size(short_labels,1),'UniformOutput',0));
    % csvwrite([save_dir 'behav_behav_cov_subwise.csv'],avg_over_conditions)
    writetable(avg_over_conditions_table,[save_dir 'behav_behav_cov_subwise.csv'])
    save(result_fname,'avg_over_conditions','cur_cov','behaviors','output_data',...
        'behav_analysis','short_labels','avg_over_conditions_table','conditions','cov_comb')
end

if(matplot)
    sem = @(x,dim) nanstd( x,0,dim ) / sqrt( size( x,dim ));
    figure
    bar(mean(avg_over_conditions))
    
    hold on
    errorbar(mean(avg_over_conditions),sem(avg_over_conditions,1),'k','linestyle','none')
    
    xticklabels(arrayfun(@(x) strjoin(short_labels(x,:),'-'),1:size(short_labels,1),'UniformOutput',0)')
    
    [h,p] = ttest(avg_over_conditions);
    asterik_loc = 0.15;
    asterik = {'*'};
    for comb = 1:length(cov_comb)
        text(comb,asterik_loc,asterik(logical(h(comb))),'FontSize',20)
    end
    ylim([-0.02 0.17])
    title('behav behav cov subwise')
    
    
    exportgraphics(gcf,[save_dir_figures 'behav_behav_cov_subwise.eps'],'BackgroundColor','none','ContentType','vector')
end
end

% {behav}{cond}{Subject}{Dyad}

% behav 1; cond = 1; subject 1;dyad 1 = (1,1);
% behav 1; cond = 1; subject 1;dyad 2 = (1,2);
% behav 1; cond = 1; subject 2;dyad 1 = (7,1);
% behav 1; cond = 1; subject 2;dyad 1 = (7,2);
% behav 1; cond = 2; subject 1;dyad 1 = (8,1);
% behav 1; cond = 2; subject 1;dyad 1 = (2,1);

% nancorr(behavior_data{1, 1}{1, 2}{1, 2}{1, 2}.eye_gaze_distance_1,behavior_data{1, 2}{1, 2}{1, 2}{1, 2}.mouth_size_1)



