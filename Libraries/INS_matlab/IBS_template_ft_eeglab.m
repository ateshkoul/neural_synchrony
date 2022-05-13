function [eeglab_data_struct] = IBS_template_ft_eeglab(data_trial)
eeglab_template = load('template_ft_eeglab.mat','template_ft_eeglab');
eeglab_template.template_ft_eeglab.data = data_trial;
eeglab_data_struct = eeglab_template.template_ft_eeglab;

end