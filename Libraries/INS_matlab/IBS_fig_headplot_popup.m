 function IBS_fig_headplot_popup(data,selCol,selChans,plot_title,limits,view_angles,fig_temp)
 %% Atesh
 % inputs:
 % data - input data matrix nchan x freq (or time)
 % selCol    - selected column from the data matrix
 % selChans  - selected channels to plot on the image
 % plot_title - plot_title
 % limits     - plot limits
 % view_angles - 2 values for the viewing angle (e.g. [0 12])
 
 %%
 
 
% needs letswave in the path
%  startup_IBS('add')
data = permute(data,[3 1 4 5 6 2]);
S=load('init_parameter.mat'); % in default letswave

userdata=S.userdata;

% [datasets.header,datasets.data]=CLW_load(data);

% template_header = load('tempalte_LW_header');
template_header = load('tempalte_LW_header_default');
datasets.header = template_header.header;
datasets.header.name = plot_title;
datasets.header.datasize = size(data);
% datasets.header.chanlocs.topo_enabled = 1;
datasets.data = double(data);


if nargin <7
fig_temp=figure;
end
[xq,yq] = meshgrid(linspace(-0.5,0.5,267),linspace(-0.5,0.5,267));
delta = (xq(2)-xq(1))/2;
ax_num=1;%length(datasets)*length(userdata.selected_epochs);
row_num=1;%length(datasets);
col_num=1;%length(userdata.selected_epochs);

            if(col_num>7)
                col_num=7;
                row_num=ceil(ax_num/7);
            end
            for ax_idx=1:ax_num
                axes_headplot(ax_idx)=subplot(row_num,col_num,ax_idx);
%                 caxis(axes_headplot(ax_idx),userdata.last_axis(3:4));
                axis(axes_headplot(ax_idx),'image');
                title_headplot(ax_idx)=title(axes_headplot(ax_idx),plot_title,...
                    'Interpreter','none');
                light('Position',[-125  125  80],'Style','infinite')
                light('Position',[125  125  80],'Style','infinite')
                light('Position',[125 -125 80],'Style','infinite')
                light('Position',[-125 -125 80],'Style','infinite')
                lighting phong;
%                 P=linspace(0,1,length(userdata.POS))';
                P=linspace(1,userdata.headplot_colornum,length(userdata.POS))';
                surface_headplot(ax_idx) = ...
                    patch('Vertices',userdata.POS,'Faces',userdata.TRI,...
                    'FaceVertexCdata',P,'FaceColor','interp', ...
                    'EdgeColor','none');
                set(surface_headplot(ax_idx),'DiffuseStrength',.6,...
                    'SpecularStrength',0,'AmbientStrength',.3,...
                    'SpecularExponent',5,'vertexnormals', userdata.NORM);
                axis(axes_headplot(ax_idx),[-125 125 -125 125 -125 125]);
%                 view([0 90]);
                view(view_angles)
                dot_headplot(ax_idx)=line(1,1,1,'Color',[0,0,0],...
                    'Linestyle','none','Marker','.','Markersize',ceil(10/sqrt(ax_num)),...
                    'parent',axes_headplot(ax_idx));
            end
            colormap(jet(userdata.headplot_colornum));
%             colormap(flipud(brewermap(64,'RdBu')));
            colorbar_headplot=colorbar;
            p=get(fig_temp,'position');
            set(colorbar_headplot,'units','pixels');
            set(colorbar_headplot,'position',[p(3)-40,10,10,p(4)-20]);
            set(colorbar_headplot,'units','normalized');
            set(axes_headplot,'Visible','off');
            
            ax_idx=0;
            for dataset_index=1:length(datasets)
                header=datasets(dataset_index).header;
%                 t=(0:header.datasize(6)-1)*header.xstep+header.xstart;
                header=CLW_make_spl(header);
                if isempty(header.spl.indices)
                    P=zeros(length(userdata.POS),1);
                    selected_epochs = 1;
                    for epoch_index=1:length(selected_epochs)
                        ax_idx=ax_idx+1;
                        if(ax_idx>ax_num)
                            break;
                        end
                        set( surface_headplot(ax_idx),'FaceVertexCdata',P);
                    end
                else
%                     [index_pos,y_pos,z_pos]=get_iyz_pos(header);
                    index_pos = 1;y_pos = 1;z_pos = 1;
%                     [~,b]=min(abs(t-userdata.cursor_point));
                    
                            data=squeeze(datasets(dataset_index).data...
            (:,header.spl.indices,index_pos,y_pos,z_pos,selCol));
                    selected_epochs = 1;
                    for epoch_index=1:length(selected_epochs)
                        ax_idx=ax_idx+1;
%                         set( dot_headplot(ax_idx),'XData',header.spl.newElect(:,1));
%                         set( dot_headplot(ax_idx),'YData',header.spl.newElect(:,2));
%                         set( dot_headplot(ax_idx),'ZData',header.spl.newElect(:,3));
                        
                        
                        
                       set( dot_headplot(ax_idx),'XData',header.spl.newElect(selChans,1));
                        set( dot_headplot(ax_idx),'YData',header.spl.newElect(selChans,2));
                        set( dot_headplot(ax_idx),'ZData',header.spl.newElect(selChans,3));
                                                
                        
%                         str=[char(userdata.str_dataset(datasets(dataset_index))),' [',num2str(epoch_index),']'];
%                         title_headplot(ax_idx)=title(axes_headplot(ax_idx),str,'Interpreter','none');
                        values=data(selected_epochs(epoch_index),:);
                                               
                        meanval = mean(values); values = values - meanval;
                        P=header.spl.GG * [values(:);0]+meanval;
%                         P=header.spl.GG * [values(:);0];

                        set( surface_headplot(ax_idx),'FaceVertexCdata',P);
                        caxis(limits)
                    end
                    
                end
            end
            set(title_headplot,'Visible','on');
%             startup_IBS('remove')
    end
