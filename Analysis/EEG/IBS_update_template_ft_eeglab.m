function eeglab_template = IBS_update_template_ft_eeglab(eeglab_template)
%% Atesh Koul

try
    template_table.chanlocs = load('IBS_monkey_eeglab_chanlocs.mat');
eeglab_template.template_ft_eeglab.chanlocs = template_table.chanlocs.monkey_eeglab_chanlocs;
catch
end
end