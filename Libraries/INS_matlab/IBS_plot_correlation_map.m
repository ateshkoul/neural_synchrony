function IBS_plot_correlation_map(data,plot_title,plot_type,data_type,analysis_type,limits,root_dir,varargin_table)
if nargin<3
    plot_type = 'multiplot';
    
end


if nargin <5
    
    % analysis_type = '_CAR_baseline_rel_0_120s_';
    % analysis_type = '_CAR_baseline_normchange_pre_1_0s_';
    analysis_type = 'CAR_baseline_normchange_0_120s_';
end

if nargin <6 || isempty(limits)
    switch(data_type)
        case 'mean'
            limits = [-0.2 0.2];
            %             limits = [-0.15 0.15];
        case 't_value'
            limits = [-10,10];
        case 'F_value'
            limits = [-6 6];
        case 'p_value'
            
            limits = [0 1];
            
    end
end

if nargin <7 || isempty(root_dir)
    root_dir = 'Y:\\Inter-brain synchrony\\Results\\EEG\\power correlations\\ASR_cleaned\\';
end

try
    varargin_table.save_figure;
catch
    varargin_table.save_figure = true;
end

cfg.layout = 'IBS_layout_64.mat';

load('correlation_template_struct.mat');
template_struct.powspctrm = data;
switch(plot_type)
    case 'images'
        %         figure('units','normalized','outerposition',[0 0 0.75 1]);
        figure('units','normalized','outerposition',[0 0 1 1]);
        
        frontal_first_chan = cat(1,template_struct.label(contains(template_struct.label,'F')),template_struct.label(~contains(template_struct.label,'F')));
        frontal_order = match(template_struct.label,frontal_first_chan);
        
        if strcmp(data_type,'t_value')
            values_to_zero = (data <2 & data > -2);
            data(values_to_zero) = 0;
        end
        %         imagesc(data,limits);colorbar;
        imagesc(data(frontal_order,:),limits);colorbar;
        
        % yticks(1:size(correlation_tval{cond},1))
        
        try
            colormap(varargin_table.cmap);
        catch
            % do nothing
%             if contains(plot_title,'t_effects')
                
%             else
                if contains(plot_title,'anova1_bla')
                    
                    % only for anova F images black-blue-green-red-yellow map
                    T = [0,   0,   0
                        93,109,230 % blue
                        92,205,230 % light blue
                        142,230,71 % dark green
                        135,230,156 % light green
                        214,107,77 % red
                        230,204,10]./255;
                    
                    x = [0
                        80
                        120
                        150
                        165
                        200
                        255];
                    map = interp1(x/255,T,linspace(0,1,255));
                    
                    colormap(map)
                else 
                    colormap(flipud(brewermap(64,'RdBu')));
                end
             
                
            end
            
  
        
        
        try
            xticks(1:size(varargin_table.xticklabels,2))
            xticklabels(varargin_table.xticklabels);
        catch
        end
        
        yticks(1:size(data,1))
        %         yticklabels(template_struct.label)
        yticklabels(frontal_first_chan)
        %         title(plot_title,'Interpreter', 'none');
        %         pause(0.5)
        
        if contains(plot_title,'freqwise')
            band_loc = [3 6 9 12];
            band_names = {'\theta','\alpha','\beta','\gamma'};
            bandname_loc = [4 7 10 13];
            text(1,67.5,'------------')
            text(1.5,69,'\delta','FontSize',24)
            
            for band_no = 1:4
                text(band_loc(band_no),67.5,'-------------------------')
                text(bandname_loc(band_no),69,band_names{band_no},'FontSize',24)
            end
        end
        
        try
            [y,x] = find(varargin_table.mask{1}(frontal_order,:));
            hold on;scatter(x,y,'*','k')
            
        catch
        end
        ax = gca;
        ax.XAxis.FontSize = 18;
        %         ax.FontSize = 18;
        plot_title = strrep(plot_title,'cluster_plot_images_','');
        %         saveas(gcf,[root_dir plot_title '_' data_type '_' plot_type '.tif'])
        
        
        %         saveas(gcf,[root_dir plot_title '_' data_type '_' plot_type '.tif'],'eps')
        %         exportgraphics(ax,[root_dir plot_title '_' data_type '_' plot_type '.pdf'],'BackgroundColor','none','ContentType','vector')
        
        
                exportgraphics(ax,[root_dir plot_title '_' data_type '_' plot_type '_stat_int_rev.eps'],'BackgroundColor','none','ContentType','vector')
        %          saveas(gcf,[root_dir 'no_detrend_' plot_title '_' data_type '_' plot_type '.tif'])
        %         saveas(gcf,[root_dir plot_title '_' analysis_type '_' data_type '_' plot_type '_all_dyads.tif'])
        
    case 'multiplot'
        figure('units','normalized','outerposition',[0 0 0.75 1]);
        
        cfg.ylim = limits;
        %         cfg.ylim = [-5 10];
        % figure;ft_multiplotTFR(cfg,template_struct)
        % figure;
        template_struct.freq = 1:size(data,2);
        ft_multiplotER(cfg,template_struct)
        title(plot_title,'Interpreter', 'none');
        colormap(flipud(brewermap(64,'RdBu')))
        %         pause(0.5)
        % colorbar;
        saveas(gcf,[root_dir plot_title '_' analysis_type '_' data_type '_' plot_type '_all_dyads.tif'])
        
    case 'topoplot'
        %         figure('units','normalized','outerposition',[0 0 0.75 1]);
        cfg = [];
        cfg.zlim = limits;
        %         cfg.zlim = [-5 10];
        %         cfg.interplimits = 'electrodes';
        temp_lay_cfg = [];
        temp_lay_cfg.layout = 'IBS_layout_64.mat';
        %         temp_lay_cfg.center = 'yes';
        %         temp_lay_cfg.outline = 'circle';
        %         temp_lay_cfg.projection = 'orthographic';
        %         temp_lay_cfg.viewpoint = 'superior';
        layout = ft_prepare_layout(temp_lay_cfg);
        %         ft_plot_layout(layout)
        
        %         cfg.layout = 'IBS_layout_64.mat';
        cfg.layout = layout;
        %         cfg.highlight = 'labels';
        template_struct.freq = 1;
        ft_topoplotER(cfg,template_struct)
        title(plot_title,'Interpreter', 'none');
        colormap(flipud(brewermap(64,'RdBu')))
        colorbar;
        
    case 'movie_topoplot'
        
        %         figure('units','normalized','outerposition',[0 0 0.75 1]);
        
        if varargin_table.save_figure
            %         vidObj = VideoWriter([root_dir plot_title '_' analysis_type '_' data_type '_' plot_type '_all_dyads']);%,'Uncompressed AVI');
            
            vidObj = VideoWriter([root_dir plot_title '_' analysis_type '_' data_type '_' plot_type '_all_dyads'],'MPEG-4');%,'Uncompressed AVI');
            
            vidObj.FrameRate = 0.5;
        end
        try
            frequencies = varargin_table.freq{1,1};
            vidObj.FrameRate = varargin_table.vidFrameRate;
        catch
            frequencies = 1:95;
        end
        if varargin_table.save_figure
            open(vidObj);
        end
        % for LW
        %         fig_temp = figure;
        for freq = 1:length(frequencies)
            %         IBS_plot_correlation_map(avg_corr{1,cond}(:,freq),[conditions{cond} ' ' num2str(freq) ' Hz'],'topoplot')
            %     pause(0.01)
            IBS_plot_correlation_map(data(:,frequencies(freq)),[plot_title ' ' num2str(frequencies(freq)) ' Hz'],'topoplot',data_type,analysis_type,limits)
            % for LW
            %             IBS_LW_fig_topo_popup(data,frequencies(freq),[plot_title ' ' num2str(frequencies(freq)) ' Hz'],limits,fig_temp)
            currFrame =getframe(gcf);
            if varargin_table.save_figure
                % Write the current frame
                writeVideo(vidObj,currFrame);
            end
            hold on
        end
        if varargin_table.save_figure
            % Close (and save) the video object
            close(vidObj);
        end
        
        
    case 'topoplot_3d'
        
        try
            view_angle = varargin_table.view_angle;
        catch
            view_angle = [62 15];
            
        end
        try
            data_col = varargin_table.data_col;
        catch
            data_col = 1;
        end
        
        try
            selChans = varargin_table.selChans{1};
        catch
            selChans = 1;
        end
        IBS_fig_headplot_popup(data,data_col,selChans,plot_title,limits,view_angle)
        colormap(flipud(brewermap(64,'RdBu')));
        saveas(gcf,[root_dir plot_title '_' analysis_type '_' data_type '_' plot_type '_all_dyads.tif'])
        
        
end

end