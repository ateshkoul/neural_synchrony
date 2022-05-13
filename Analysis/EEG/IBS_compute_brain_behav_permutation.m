function [p_values] = IBS_compute_brain_behav_permutation(all_data,all_fixed_var_names,random_effects_var_name,nPerm)
%% Atesh Koul
% 29-01-2021

actual_lme = fitlme(all_data,['chan_freq_data~' all_fixed_var_names '(1|' random_effects_var_name ')'],'DummyVarCoding','effects');
actual_coeff = double(actual_lme.Coefficients(:,2));
rng(10)
for perm_no = 1:nPerm
    all_data.chan_freq_data = all_data.chan_freq_data(randperm(length(all_data.chan_freq_data)));
    lme = fitlme(all_data,['chan_freq_data~' all_fixed_var_names '(1|' random_effects_var_name ')'],'DummyVarCoding','effects');
    cur_lme_coeff(:,perm_no) = double(lme.Coefficients(:,2));
    
    
end
p_values = sum(abs(repmat(actual_coeff,1,nPerm))<abs(cur_lme_coeff),2)/(nPerm+1);
end