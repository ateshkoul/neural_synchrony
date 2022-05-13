

% doesn't make sense to have task as we are not showing anything with task.
% might give a wrong impression
% conditions = {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3','Task_1','Task_2','Task_3'};
conditions = {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'};

label_types = {'all'};

labelling = {'Laugh','Talk','Mov_head','Mov_trunk','Mov_arms','Mov_legs', ...
        'Eye_close','Com','Smile','Yawning','Eyebrows',   ...
        'Hands_Feet','NRelaxed','All_mov'};
    
sel_cols = [1 2 7:11 13 14];
for Dyad_no = 1:23
    for condition_no = 1:length(conditions)
cur_condition = conditions{condition_no};
behav_data_S1 = IBS_load_video_manual_labelled(Dyad_no,1,cur_condition,label_types);
behav_data_S2 = IBS_load_video_manual_labelled(Dyad_no,2,cur_condition,label_types);

% behav_frac_1 = nansum(table2array(behav_data_S1(:,2:end)))./nansum(nansum(table2array(behav_data_S1(:,2:end))));
% behav_frac_2 = nansum(table2array(behav_data_S2(:,2:end)))./nansum(nansum(table2array(behav_data_S2(:,2:end))));

behav_frac_1 = nansum(table2array(behav_data_S1(:,sel_cols+1)))./nansum(nansum(table2array(behav_data_S1(:,sel_cols+1))));
behav_frac_2 = nansum(table2array(behav_data_S2(:,sel_cols+1)))./nansum(nansum(table2array(behav_data_S2(:,sel_cols+1))));



% cur_behav_data(:,condition_no,Dyad_no) = mean([mean(table2array(behav_data_S1(:,2:end)));mean(table2array(behav_data_S1(:,2:end)))]);
cur_behav_data(:,condition_no,Dyad_no) = nanmean([behav_frac_1;behav_frac_2]);

    end
end

avg_labelled_behav = squeeze(mean(cur_behav_data,[2 3],'omitnan'));
avg_labelled_behav_sel_behav = avg_labelled_behav;
k = array2table(avg_labelled_behav_sel_behav','VariableNames',labelling(sel_cols))
avg_labelled_behav_sel_behav = avg_labelled_behav_sel_behav([1:4 6:9 5],1);
sel_labels = labelling(sel_cols);
sel_labels = sel_labels([1:4 6:9 5]);
explode = [0 0 0 0 0 0 0 1 1];


figure('units','normalized','outerposition',[0 0 1 1])
% p = pie(avg_labelled_behav_sel_behav)
pie(avg_labelled_behav_sel_behav,explode,sel_labels)

figure_save_dir = 'Y:\\Inter-brain synchrony\\Results\\Eye_tracking\\';
exportgraphics(gcf,[figure_save_dir '\\manual_behavior.eps'],'BackgroundColor','none','ContentType','vector')

%%

pie(avg_labelled_behav_sel_behav,labelling(sel_cols))

%% old



avg_labelled_behav = squeeze(mean(cur_behav_data,[2 3],'omitnan'));
sel_cols = [1 2 7:11 13 14];
avg_labelled_behav_sel_behav = avg_labelled_behav(sel_cols,:);
avg_labelled_behav_sel_behav = normalize(avg_labelled_behav_sel_behav,'range');

pie(avg_labelled_behav_sel_behav,labelling(sel_cols))


k = array2table(avg_labelled_behav_sel_behav','VariableNames',labelling(sel_cols))
avg_labelled_behav_sel_behav = avg_labelled_behav_sel_behav([1:4 6:9 5],1);
sel_labels = labelling(sel_cols);
sel_labels = sel_labels([1:4 6:9 5]);
explode = [0 0 0 0 0 0 0 1 1];
pie(avg_labelled_behav_sel_behav,explode,sel_labels)


figure('units','normalized','outerposition',[0 0 1 1])
p = pie(avg_labelled_behav_sel_behav)

figure_save_dir = 'Y:\\Inter-brain synchrony\\Results\\Eye_tracking\\';
exportgraphics(gcf,[figure_save_dir '\\manual_behavior.eps'],'BackgroundColor','none','ContentType','vector')
%%

new_labelling = {'Laugh','Talk', ...
        'Eye_close','Com','Yawning','Eyebrows',   ...
        'NRelaxed','All_mov','Smile'};
explode = [1 1 1 1 1 1 1 0 0];
avg_labelled_behav_sel_behav = [avg_labelled_behav_sel_behav(1:4,1);avg_labelled_behav_sel_behav(6:end,1);avg_labelled_behav_sel_behav(5,1)];

pie(avg_labelled_behav_sel_behav,explode,new_labelling)

