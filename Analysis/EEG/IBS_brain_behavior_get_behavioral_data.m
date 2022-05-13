function [behavior_data] = IBS_brain_behavior_get_behavioral_data(data_analysis_type,analysis,behaviors,Dyads,condition,behav_analysis,analysis_sub_type)
%% Atesh Koul
% 16-03-2021

behavior_data = cellfun(@(x) IBS_load_behavior_data(x,data_analysis_type,Dyads,condition,behav_analysis,analysis_sub_type),...
    behaviors,'UniformOutput',false);


%%
% % remove dyads 7 and 13 that have lesser behav data. 
% Dyads_full = setdiff(Dyads,[7,13]);
% 
% 
% behavior_data = cellfun(@(x) IBS_load_behavior_data(x,data_analysis_type,Dyads_full,condition,behav_analysis),...
%     behaviors,'UniformOutput',false);
% 
% condition_7 = setdiff(condition,'FaNoOcc_3');
% Dyad_7 = 7;
% behavior_data_7 = cellfun(@(x) IBS_load_behavior_data(x,data_analysis_type,Dyad_7,condition_7,behav_analysis),...
%     behaviors,'UniformOutput',false);
% 
% condition_13 = setdiff(condition,'FaNoOcc_2');
% Dyad_13 = 13;
% behavior_data_13 = cellfun(@(x) IBS_load_behavior_data(x,data_analysis_type,Dyad_13,condition_13,behav_analysis),...
%     behaviors,'UniformOutput',false);
% 
% 
% behavior_data{1,1}{1,1}{1,Dyad_7} = behavior_data_7{1,1}{1,1}{1,Dyad_7};
% behavior_data{1,1}{1,1}{1,Dyad_13} = behavior_data_13{1,1}{1,1}{1,Dyad_13};
% 
% behavior_data{1,2}{1,1}{1,Dyad_7} = behavior_data_7{1,2}{1,1}{1,Dyad_7};
% behavior_data{1,2}{1,1}{1,Dyad_13} = behavior_data_13{1,2}{1,1}{1,Dyad_13};

%%
if contains(analysis,'freqwise')
    behavior_data = IBS_remove_empty_dyads(behavior_data);
end


behavior_data = cat(2,behavior_data{:});
end