function IBS_plot_brain_behav_glm_mean_scatter_plot(data_analysis_type,analysis,lme_model,clustername,behav_analysis)

%%



dyad_cols = contains(lme_model.VariableNames,'Dyad_no');

% get the first dyad col name - all the rest should be the same
dyad_col_names = lme_model.VariableNames(dyad_cols);
random_effects_var_name = dyad_col_names{1,1};
% fixed_effects_var_names = lme_model.Variables(~ismember(lme_model.Variables,random_effects_var_name));

condition_cols = contains(lme_model.VariableNames,'condition');
condition_col_names = lme_model.VariableNames(condition_cols);




fixed_effects_var_names = lme_model.VariableNames(~ismember(lme_model.VariableNames,[dyad_col_names{:} condition_col_names{:} {lme_model.ResponseName}]));


% save_dir = 'E:\\Projects\\IBS\\Results\\EEG\\Power_correlation_analysis\\no_aggressive_trialwise_CAR\\figures\\';
% data_analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
% analysis = 'Brain_behavior_glm_power_freqwise';
save_dir = IBS_get_params_analysis_type(data_analysis_type,analysis).analysis_save_dir_figures{1,1};

condition = lme_model.Variables.condition_Gaze_nose_dist(1,:);
for fixed_effect_no = 1:length(fixed_effects_var_names)
    
    variableName =lme_model.Variables(:,fixed_effects_var_names).Properties.VariableNames{fixed_effect_no};
    s = rowfun(@mean,lme_model.Variables,'GroupingVariables',{'Dyad_no_Gaze_nose_dist',variableName},'InputVariables',{'chan_freq_data'});
%     s = lme_model.Variable;

    if(contains(variableName,{'Fun'}))    
    
    switch(behav_analysis)
        case 'joint_OR'
    test_val_0 = categorical(logical(0));
    test_val_1 = categorical(logical(1));
        case 'joint_AND'
    test_val_0 = categorical(0);
    test_val_1 = categorical(1);
    
    
    end
    else
      test_val_0 = 0;
    test_val_1 = 1;  
    end
    result_var = 'Var4';
%     result_var = 'chan_freq_data';
    figure;
    dot_size = 80;
    
    
  
    scatter_x_no = repmat(1,1,sum(s.(variableName)==test_val_0))+rand(1,sum(s.(variableName)==test_val_0))/8;
    scatter_x_yes = repmat(1.5,1,sum(s.(variableName)==test_val_1))+rand(1,sum(s.(variableName)==test_val_1))/8;
    scatter(scatter_x_no,s.(result_var)(s.(variableName)==test_val_0)',dot_size,'filled')
    hold on
    scatter(scatter_x_yes,s.(result_var)(s.(variableName)==test_val_1)',dot_size,'filled')
    
    p1 = bar(mean(scatter_x_no),mean(s.(result_var)(s.(variableName)==test_val_0)'),0.2,'b');
    hold on
    p2 = bar(mean(scatter_x_yes),mean(s.(result_var)(s.(variableName)==test_val_1)'),0.2,'FaceColor',[0.8500, 0.3250, 0.0980]);
    
    alpha(p1,0.6)
    alpha(p2,0.6)
%     axis([ 0.8 1.8 -0.2 0.2])
    axis([ 0.8 1.8 -1 1])
    xticks([1 1.5])
    xticklabels({'no','yes'})
%     title([behav_analysis ' ' variableName  ],'Interpreter', 'none');
    title([clustername ' ' variableName  ],'Interpreter', 'none');

    ylabel({'normalized power correlation'})
    
%     saveas(gcf,[root_dir 'test_' condition '_' variableName '_yes_no_across_dyads' '.tiff'])
    saveas(gcf,[save_dir 'test_' condition '_' variableName '_' clustername '_yes_no_normalized' '.tiff'])
% pause(0.5)
    close all
end

