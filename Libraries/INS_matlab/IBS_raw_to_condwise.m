function [data_condwise_S1,data_condwise_S2] = IBS_raw_to_condwise(data_ica_clean_S1,data_ica_clean_S2,conditions,fun,mapObj)
%IBS_RAW_TO_CONDWISE function to convert raw data to condwise
%
% SYNOPSIS: IBS_raw_to_condwise
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
% DATE: 03-Jun-2021
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin <5
%     mapObj = containers.Map({'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'},...
%         {'11  12  13','21  22  23','31  32  33','41  42  43',...
%         '51  52  53','61  62  63','71  72  73' });
    
    mapObj = containers.Map({'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'},...
        {'31','32','33','51','52', '53'});
    
end
if nargin <4
    
    fun = @IBS_select_trials;
end


data_condwise_S1 = cell(1,length(conditions));
data_condwise_S2 = cell(1,length(conditions));


for condition = 1:length(conditions)
    cur_cond = conditions{condition};
    switch(cur_cond)
        case 'Baseline start'
            data_struct_S1  = data_ica_clean_S1{1,1};
            data_struct_S2  = data_ica_clean_S2{1,1};
            
        case {'FaOcc','FaNoOcc', 'NeOcc', 'NeNoOcc', 'Task','FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'}
            data_struct_S1 = data_ica_clean_S1{1,2};
            data_struct_S2  = data_ica_clean_S2{1,2};
            
        case 'Baseline end'
            data_struct_S1  = data_ica_clean_S1{1,3};
            data_struct_S2  = data_ica_clean_S2{1,3};
            
            
    end
    
    
    data_condwise_S1{condition}   = fun(data_struct_S1,str2num(mapObj(cur_cond)));
    data_condwise_S2{condition}   = fun(data_struct_S2,str2num(mapObj(cur_cond)));
    
end
end


function data_out = IBS_select_trials(dataset,trial_nos)
cfg = [];
cfg.trials              = ismember(dataset.trialinfo,trial_nos);
cfg.latency            = [0 120];
data_out = ft_selectdata(cfg,dataset);


end


