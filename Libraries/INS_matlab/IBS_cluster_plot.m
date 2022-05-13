function IBS_cluster_plot(stat,saveaspng,title,plot_type,analysis)

if nargin <4
    plot_type = 'topoplots';
end
if nargin <2
    saveaspng = 'no';
    title = '';
end
if nargin <3 || isempty(title)
    
    
    
    [~,f_name] = fileparts(saveaspng);
    
    title = f_name;
end


if nargin<5
    analysis = 'Power_correlation_analysis' ;
end

switch(plot_type)
    case 'topoplots'
        % saveaspng = 'no';
        % make a plot
        cfg = [];
        cfg.highlightsymbolseries = ['*','*','.','.','.'];
        
        cfg.highlightseries = {'on', 'on', 'off', 'off', 'off'};
        cfg.layout = 'IBS_layout_64.mat';
        cfg.contournum = 0;
        cfg.markersymbol = '.';
        switch(contains(analysis,'Dyad'))
            
            case 1
                cfg.alpha = 0.05;
                %                  cfg.alpha = 0.1;
                cfg.highlightseries = {'on', 'on','on','on','on'};
            case 0
                cfg.alpha            = 0.025; %https://www.fieldtriptoolbox.org/tutorial/cluster_permutation_timelock/#the-format-of-the-output
                % a p-value less than the critical alpha-level of 0.025. This critical alpha-level corresponds to a false alarm rate of 0.05 in a two-sided test.
%                            cfg.alpha            = 0.05; %https://www.fieldtriptoolbox.org/tutorial/cluster_permutation_timelock/#the-format-of-the-output
% cfg.highlightseries = {'on', 'on','on','on','on'};
        end
        cfg.parameter='stat';
        cfg.zlim = [-6 6];
        cfg.saveaspng = saveaspng;
        
        
        cfg.dataname = title;
        try
            ft_clusterplot(cfg, stat);
        catch
            
            [~,f_name] = fileparts(saveaspng);
            disp(['failed plot ' f_name]);
        end
    case 'images'
        [root_dir,f_name] = fileparts(saveaspng);
        %         data_analysis_type = strrep(f_name,'cluster_plot_correlation_','');
        
        cur_data_analysis_type = IBS_get_data_analysis_type_from_string(f_name);
        varargin_table = table();

            if contains(f_name,'freqwise')
                cluster_freq_table = IBS_get_params_analysis_type(cur_data_analysis_type{1,1}).cluster_freq_table;
%                 xtick_values = cellfun(@(x) x(1),table2array(cluster_freq_table),'UniformOutput',false);
%                 varargin_table = addvars(varargin_table,cat(2,xtick_values{:}),'NewVariableNames',{'xticklabels'});

                xtick_values = cellfun(@(x) [num2str(x(1)) '-' num2str(x(2))],table2array(cluster_freq_table),'UniformOutput',false);
                varargin_table = addvars(varargin_table,xtick_values,'NewVariableNames',{'xticklabels'});

            end

        
        title = strrep(title,'cluster_plot_','cluster_plot_images_');
        varargin_table.mask = {stat.mask};
        IBS_plot_correlation_map(stat.stat,title,'images','F_value','',[],root_dir,varargin_table)
        %         imagesc(stat.stat,F_limits)
  
    case 'no'
        % do nothing
end


end
