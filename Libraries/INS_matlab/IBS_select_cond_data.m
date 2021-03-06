function [data_cond] = IBS_select_cond_data(data,cond)

% important that the string is exact otherwise the values are not possible
% to obtain
% map_code2Cond = containers.Map({'11  12  13','21  22  23','31  32  33','41  42  43',...
%     '51  52  53','61  62  63','71  72  73' },...
%     {'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'});


map_Cond2code = containers.Map({'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end','Baseline'},...
    {'11  12  13','21  22  23','31  32  33','41  42  43',...
    '51  52  53','61  62  63','71  72  73','11  12  13  71  72  73'});


cond_codes = str2num(map_Cond2code(cond));
cfg_event.trials = ismember(data.trialinfo,cond_codes);
data_cond = ft_redefinetrial(cfg_event,data);
end


function [data_cond_S1,data_cond_S2] = IBS_select_Dyd_cond_data(data_S1,data_S2,cond)

% important that the string is exact otherwise the values are not possible
% to obtain
% map_code2Cond = containers.Map({'11  12  13','21  22  23','31  32  33','41  42  43',...
%     '51  52  53','61  62  63','71  72  73' },...
%     {'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'});


map_Cond2code = containers.Map({'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'},...
    {'11  12  13','21  22  23','31  32  33','41  42  43',...
    '51  52  53','61  62  63','71  72  73' });


cond_codes = str2num(map_Cond2code(cond));
cfg_event.trials = ismember(data_S1.trialinfo,cond_codes);
data_cond_S1 = ft_redefinetrial(cfg_event,data_S1);
data_cond_S2 = ft_redefinetrial(cfg_event,data_S2);
end