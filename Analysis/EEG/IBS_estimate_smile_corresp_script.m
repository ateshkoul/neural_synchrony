

analysis_type_params = IBS_get_params_analysis_type('no_aggressive_CAR_ASR_10_ICA_appended_trials','Brain_behavior_glm_power_freqwise');
analysis_save_dir = analysis_type_params.analysis_save_dir{1,1};
%%
result = [];


Dyads= [1:23];
output = 'all_acc';
for dyad_no = 1:length(Dyads)
result(dyad_no,1) = IBS_estimate_corresp_auto_smile_manual_label(Dyads(dyad_no),0,'FaNoOcc_1',output);
result(dyad_no,2) = IBS_estimate_corresp_auto_smile_manual_label(Dyads(dyad_no),0,'FaNoOcc_2',output);
result(dyad_no,3) = IBS_estimate_corresp_auto_smile_manual_label(Dyads(dyad_no),0,'FaNoOcc_3',output);
result(dyad_no,4) = IBS_estimate_corresp_auto_smile_manual_label(dyad_no,0,'NeNoOcc_1',output);
result(dyad_no,5) = IBS_estimate_corresp_auto_smile_manual_label(dyad_no,0,'NeNoOcc_2',output);
result(dyad_no,6) = IBS_estimate_corresp_auto_smile_manual_label(dyad_no,0,'NeNoOcc_3',output);



result(dyad_no,7) = IBS_estimate_corresp_auto_smile_manual_label(Dyads(dyad_no),1,'FaNoOcc_1',output);
result(dyad_no,8) = IBS_estimate_corresp_auto_smile_manual_label(Dyads(dyad_no),1,'FaNoOcc_2',output);
result(dyad_no,9) = IBS_estimate_corresp_auto_smile_manual_label(Dyads(dyad_no),1,'FaNoOcc_3',output);

result(dyad_no,10) = IBS_estimate_corresp_auto_smile_manual_label(dyad_no,1,'NeNoOcc_1',output);
result(dyad_no,11) = IBS_estimate_corresp_auto_smile_manual_label(dyad_no,1,'NeNoOcc_2',output);
result(dyad_no,12) = IBS_estimate_corresp_auto_smile_manual_label(dyad_no,1,'NeNoOcc_3',output);

% result(dyad_no,13) = IBS_estimate_corresp_auto_smile_manual_label(dyad_no,0,'Task_1');
% result(dyad_no,14) = IBS_estimate_corresp_auto_smile_manual_label(dyad_no,0,'Task_2');
% result(dyad_no,15) = IBS_estimate_corresp_auto_smile_manual_label(dyad_no,0,'Task_3');
% 
% result(dyad_no,16) = IBS_estimate_corresp_auto_smile_manual_label(dyad_no,1,'Task_1');
% result(dyad_no,17) = IBS_estimate_corresp_auto_smile_manual_label(dyad_no,1,'Task_2');
% result(dyad_no,18) = IBS_estimate_corresp_auto_smile_manual_label(dyad_no,1,'Task_3');
end
hist(result(:))
[h,p]= ttest(nanmean(result,2),0.5,'alpha',0.05,'tail','right')
[h,ksp_all_acc] = kstest(nanmean(result,2)) % p = 4.1288e-13

[sign_rank_all_acc_p,h] = signrank(nanmean(result,2),0.5,'tail','right') % p = 1.4444e-05
% 0.8626 p = 0

mean(nanmean(result_all_acc(:,2)))


%%
% accuracy
% [h,p]= ttest(mean(result(:,1:6),2),0.5,'alpha',0.05,'tail','right')
% [h,p]= ttest(mean(result(:,7:12),2),0.5,'alpha',0.05,'tail','right')

%%
result_kappa = [];
Dyads= [1:23];
output = 'kappa';
for dyad_no = 1:length(Dyads)
result_kappa(dyad_no,1) = IBS_estimate_corresp_auto_smile_manual_label(Dyads(dyad_no),0,'FaNoOcc_1',output);
result_kappa(dyad_no,2) = IBS_estimate_corresp_auto_smile_manual_label(Dyads(dyad_no),0,'FaNoOcc_2',output);
result_kappa(dyad_no,3) = IBS_estimate_corresp_auto_smile_manual_label(Dyads(dyad_no),0,'FaNoOcc_3',output);
result_kappa(dyad_no,4) = IBS_estimate_corresp_auto_smile_manual_label(dyad_no,0,'NeNoOcc_1',output);
result_kappa(dyad_no,5) = IBS_estimate_corresp_auto_smile_manual_label(dyad_no,0,'NeNoOcc_2',output);
result_kappa(dyad_no,6) = IBS_estimate_corresp_auto_smile_manual_label(dyad_no,0,'NeNoOcc_3',output);



result_kappa(dyad_no,7) = IBS_estimate_corresp_auto_smile_manual_label(Dyads(dyad_no),1,'FaNoOcc_1',output);
result_kappa(dyad_no,8) = IBS_estimate_corresp_auto_smile_manual_label(Dyads(dyad_no),1,'FaNoOcc_2',output);
result_kappa(dyad_no,9) = IBS_estimate_corresp_auto_smile_manual_label(Dyads(dyad_no),1,'FaNoOcc_3',output);

result_kappa(dyad_no,10) = IBS_estimate_corresp_auto_smile_manual_label(dyad_no,1,'NeNoOcc_1',output);
result_kappa(dyad_no,11) = IBS_estimate_corresp_auto_smile_manual_label(dyad_no,1,'NeNoOcc_2',output);
result_kappa(dyad_no,12) = IBS_estimate_corresp_auto_smile_manual_label(dyad_no,1,'NeNoOcc_3',output);

% result(dyad_no,13) = IBS_estimate_corresp_auto_smile_manual_label(dyad_no,0,'Task_1');
% result(dyad_no,14) = IBS_estimate_corresp_auto_smile_manual_label(dyad_no,0,'Task_2');
% result(dyad_no,15) = IBS_estimate_corresp_auto_smile_manual_label(dyad_no,0,'Task_3');
% 
% result(dyad_no,16) = IBS_estimate_corresp_auto_smile_manual_label(dyad_no,1,'Task_1');
% result(dyad_no,17) = IBS_estimate_corresp_auto_smile_manual_label(dyad_no,1,'Task_2');
% result(dyad_no,18) = IBS_estimate_corresp_auto_smile_manual_label(dyad_no,1,'Task_3');
end
hist(result_kappa(:))

% k
% [h,p]= ttest(nanmean(result(:,1:6),2),0,'alpha',0.05,'tail','right')
% [h,p]= ttest(nanmean(result(:,7:12),2),0,'alpha',0.05,'tail','right')

% [h,p]= ttest(nanmean(result,2),0.5,'alpha',0.05,'tail','right')
[h,ksp_kappa] = kstest(nanmean(result_kappa,2)) % p = 8.0736e-06

[sign_rank_kappa_p,h] = signrank(nanmean(result_kappa,2),0,'tail','right') % p = 1.6505e-05
% [h,p]= ttest([nanmean(result(:,1:6),2);nanmean(result(:,7:12),2)],0.5,'alpha',0.05,'tail','right')

mean(nanmean(result_kappa(:,2)))
%%
save([analysis_save_dir 'smile_manual_corresp.mat'],'result_all_acc','result_kappa',...
    'sign_rank_all_acc_p','ksp_all_acc','ksp_kappa','sign_rank_kappa_p')
%% for all mov
% this is something that ideally should be done but the point here is that
% the data has already been cleaned based on visual inspection - so it
% might not be necessary? the reason this is difficult to compare is
% because the video frames from eye tracker and video camera are not
% aligned
result_balanced_acc = [];
result_k = [];
Dyads= [1:23];
for dyad_no = 1:length(Dyads)
result_S1_FaNoOcc_1 = IBS_estimate_corresp_auto_mov_manual_label(Dyads(dyad_no),0,'FaNoOcc_1');
result_S1_FaNoOcc_2 = IBS_estimate_corresp_auto_mov_manual_label(Dyads(dyad_no),0,'FaNoOcc_2');
result_S1_FaNoOcc_3 = IBS_estimate_corresp_auto_mov_manual_label(Dyads(dyad_no),0,'FaNoOcc_3');
result_S1_NeNoOcc_1 = IBS_estimate_corresp_auto_mov_manual_label(dyad_no,0,'NeNoOcc_1');
result_S1_NeNoOcc_2 = IBS_estimate_corresp_auto_mov_manual_label(dyad_no,0,'NeNoOcc_2');
result_S1_NeNoOcc_3 = IBS_estimate_corresp_auto_mov_manual_label(dyad_no,0,'NeNoOcc_3');

result_S2_FaNoOcc_1 = IBS_estimate_corresp_auto_mov_manual_label(Dyads(dyad_no),1,'FaNoOcc_1');
result_S2_FaNoOcc_2 = IBS_estimate_corresp_auto_mov_manual_label(Dyads(dyad_no),1,'FaNoOcc_2');
result_S2_FaNoOcc_3 = IBS_estimate_corresp_auto_mov_manual_label(Dyads(dyad_no),1,'FaNoOcc_3');
result_S2_NeNoOcc_1 = IBS_estimate_corresp_auto_mov_manual_label(dyad_no,1,'NeNoOcc_1');
result_S2_NeNoOcc_2 = IBS_estimate_corresp_auto_mov_manual_label(dyad_no,1,'NeNoOcc_2');
result_S2_NeNoOcc_3 = IBS_estimate_corresp_auto_mov_manual_label(dyad_no,1,'NeNoOcc_3');
%%
result_balanced_acc(dyad_no,1) = result_S1_FaNoOcc_1.balanced_accuracy;
result_balanced_acc(dyad_no,2) = result_S1_FaNoOcc_2.balanced_accuracy;
result_balanced_acc(dyad_no,3) = result_S1_FaNoOcc_3.balanced_accuracy;
result_balanced_acc(dyad_no,4) = result_S1_NeNoOcc_1.balanced_accuracy;
result_balanced_acc(dyad_no,5) = result_S1_NeNoOcc_2.balanced_accuracy;
result_balanced_acc(dyad_no,6) = result_S1_NeNoOcc_3.balanced_accuracy;

result_balanced_acc(dyad_no,7) = result_S2_FaNoOcc_1.balanced_accuracy;
result_balanced_acc(dyad_no,8) = result_S2_FaNoOcc_2.balanced_accuracy;
result_balanced_acc(dyad_no,9) = result_S2_FaNoOcc_3.balanced_accuracy;


result_balanced_acc(dyad_no,10) = result_S2_NeNoOcc_1.balanced_accuracy;
result_balanced_acc(dyad_no,11) = result_S2_NeNoOcc_2.balanced_accuracy;
result_balanced_acc(dyad_no,12) = result_S2_NeNoOcc_3.balanced_accuracy;

%%
result_k(dyad_no,1) = result_S1_FaNoOcc_1.k;
result_k(dyad_no,2) = result_S1_FaNoOcc_2.k;
result_k(dyad_no,3) = result_S1_FaNoOcc_3.k;
result_k(dyad_no,4) = result_S1_NeNoOcc_1.k;
result_k(dyad_no,5) = result_S1_NeNoOcc_2.k;
result_k(dyad_no,6) = result_S1_NeNoOcc_3.k;

result_k(dyad_no,7) = result_S2_FaNoOcc_1.k;
result_k(dyad_no,8) = result_S2_FaNoOcc_2.k;
result_k(dyad_no,9) = result_S2_FaNoOcc_3.k;


result_k(dyad_no,10) = result_S2_NeNoOcc_1.k;
result_k(dyad_no,11) = result_S2_NeNoOcc_2.k;
result_k(dyad_no,12) = result_S2_NeNoOcc_3.k;

end
hist(result(:))



%%
% accuracy
[h,p]= ttest(mean(result_balanced_acc(:,1:6),2),0.5,'alpha',0.05,'tail','right')
[h,p]= ttest(mean(result_balanced_acc(:,7:12),2),0.5,'alpha',0.05,'tail','right')


% k
[h,p]= ttest(nanmean(result_k(:,1:6),2),0,'alpha',0.05,'tail','right')
[h,p]= ttest(nanmean(result_k(:,7:12),2),0,'alpha',0.05,'tail','right')



