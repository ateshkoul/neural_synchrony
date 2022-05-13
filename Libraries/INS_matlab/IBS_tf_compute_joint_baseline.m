function [data_tf_bc] = IBS_tf_compute_joint_baseline(data_tf)
%IBS_TF_COMPUTE_JOINT_BASELINE function to compute baseline on all the trials together
%
% SYNOPSIS: IBS_tf_compute_joint_baseline
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
% DATE: 12-Apr-2021
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


tf_powspectrum = cellfun(@(x) cat(1,x.powspctrm),...
            data_tf,'UniformOutput', false);
tf_powspectrum_all_conds = cat(1,tf_powspectrum{:});      
mean_tf_powspectrum = mean(mean(tf_powspectrum_all_conds,4,'omitnan'),'omitnan'); 

% compute norm-change
normalized_powspectrum = cellfun(@(x) (x.powspctrm-mean_tf_powspectrum)./(x.powspctrm+mean_tf_powspectrum),...
            data_tf,'UniformOutput', false);
% checked using subtraction of mean and the average over chan-freq comes to
% be 0 (or very close)
%  normalized_powspectrum = cellfun(@(x) (x.powspctrm-mean_tf_powspectrum),...
%             data_tf,'UniformOutput', false);       
             
data_tf_bc = cellfun(@(x,y) IBS_subs_data(x,y),...
            data_tf,normalized_powspectrum,'UniformOutput', false);
end
% % initialize output structure
% freqOut = keepfields(freqs, {'label' 'freq' 'dimord' 'time'});
% freqOut = copyfields(freqs, freqOut,...
%   {'grad', 'elec', 'trialinfo', 'topo', 'topolabel', 'unmixing'});
% cfg.parameter    =  ft_getopt(cfg, 'parameter', 'powspctrm');
% 
% par = cfg.parameter;
% dim = 4;
% 
% % first avg across time and then average across the conditions
% % checked that even if the dimensions are not the same, the mean_mat is
% % computed from all the conditions. 
% mean_mat = repmat(mean(mean(freqs.(par),dim,'omitnan'),1,'omitnan'),[1 1 1 size(freqs.(par),dim)]);
% switch(cfg.baselinetype)
%     case 'normchange'
%         freqOut.(par) = (freqs.(par) - mean_mat)./(freqs.(par) + mean_mat);
% end

