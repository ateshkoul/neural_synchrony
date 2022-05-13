function [connectivity_mat] = IBS_tf_manual_coherence(data_struct_S1,data_struct_S2,trial_nos,coh_fun,varargin)

if nargin<4
   coh_fun = @mscohere; 
end


cfg_select.trials          = ismember(data_struct_S1.trialinfo,trial_nos);
data_struct_S1 = ft_selectdata(cfg_select,data_struct_S1);


% this is equivalent trial nos because they are a dyad
cfg_select.trials          = ismember(data_struct_S2.trialinfo,trial_nos);
data_struct_S2 = ft_selectdata(cfg_select,data_struct_S2);


connectivity_mat = cellfun(@(x,y) coh_fun(x',y',varargin{:}),data_struct_S1.trial,data_struct_S2.trial,...
    'UniformOutput',false); 

connectivity_mat = cat(3,connectivity_mat{:});

connectivity_mat = mean(connectivity_mat,3);
connectivity_mat = connectivity_mat';
end