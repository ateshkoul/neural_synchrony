% topo_enabled=1;
% for dataset_index=1:length(userdata.selected_datasets)
%     topo_enabled=topo_enabled*sum([datasets_header(userdata.selected_datasets(dataset_index)).header.chanlocs.topo_enabled]);
% end
%
%
% [xq,yq] = meshgrid(linspace(-0.5,0.5,67),linspace(-0.5,0.5,67));
% delta = (xq(2)-xq(1))/2;
% ax_num=min(length(userdata.selected_datasets)*length(userdata.selected_epochs),4);
%
% handles.surface_topo(ax_idx)=surface(xq-delta,yq-delta,zeros(size(xq)),xq,...
%     'EdgeColor','none','FaceColor','flat','parent',handles.axes_topo(ax_idx));
%
%
% headx = 0.5*[sin(linspace(0,2*pi,100)),NaN,sin(-2*pi*10/360),0,sin(2*pi*10/360),NaN,...
%     0.1*cos(2*pi/360*linspace(80,360-80,100))-1,NaN,...
%     -0.1*cos(2*pi/360*linspace(80,360-80,100))+1];
% heady = 0.5*[cos(linspace(0,2*pi,100)),NaN,cos(-2*pi*10/360),1.1,cos(2*pi*10/360),NaN,...
%     0.2*sin(2*pi/360*linspace(80,360-80,100)),NaN,0.2*sin(2*pi/360*linspace(80,360-80,100))];
%
% header=datasets_header(userdata.selected_datasets(dataset_index)).header;
% chan_used=find([header.chanlocs.topo_enabled]==1);
% chanlocs=header.chanlocs(chan_used);
% [y,x]= pol2cart(pi/180.*[chanlocs.theta],[chanlocs.radius]);
%
%
%
%




function IBS_LW_fig_topo_popup(data,b,plot_title,limits,fig_temp)
startup_IBS('add')
data = permute(data,[3 1 4 5 6 2]);
S=load('init_parameter.mat');

% [datasets.header,datasets.data]=CLW_load(data);

template_header = load('tempalte_LW_header');
datasets.header.datasize = size(data);
datasets.header = template_header.header;
datasets.header.name = plot_title;
datasets.data = double(data);

if nargin <5
fig_temp=figure();
end
[xq,yq] = meshgrid(linspace(-0.5,0.5,267),linspace(-0.5,0.5,267));
delta = (xq(2)-xq(1))/2;
ax_num=1;%length(userdata.selected_datasets)*length(userdata.selected_epochs);
row_num=1;%length(userdata.selected_datasets);
col_num=1;%length(userdata.selected_epochs);
%     if(col_num>7)
%         col_num=7;
%         row_num=ceil(ax_num/7);
%     end
for ax_idx=1:ax_num
    axes_topo(ax_idx)=subplot(row_num,col_num,ax_idx);
    set(axes_topo(ax_idx),'Xlim',[-0.55,0.55]);
    set(axes_topo(ax_idx),'Ylim',[-0.5,0.6]);
    caxis(axes_topo(ax_idx),limits);%[0.0229    0.9887]);%userdata.last_axis(3:4));
    hold(axes_topo(ax_idx),'on');
    axis(axes_topo(ax_idx),'square');
    surface_topo(ax_idx)=surface(xq-delta,yq-delta,zeros(size(xq)),xq,...
        'EdgeColor','none','FaceColor','flat','parent',axes_topo(ax_idx));
    
    surface_headplot(ax_idx) = ...
                        patch('Vertices',userdata.POS,'Faces',userdata.TRI,...
                        'FaceVertexCdata',P,'FaceColor','interp', ...
                        'EdgeColor','none');
    
    headx = 0.5*[sin(linspace(0,2*pi,100)),NaN,sin(-2*pi*10/360),0,sin(2*pi*10/360),NaN,...
        0.1*cos(2*pi/360*linspace(80,360-80,100))-1,NaN,...
        -0.1*cos(2*pi/360*linspace(80,360-80,100))+1];
    heady = 0.5*[cos(linspace(0,2*pi,100)),NaN,cos(-2*pi*10/360),1.1,cos(2*pi*10/360),NaN,...
        0.2*sin(2*pi/360*linspace(80,360-80,100)),NaN,0.2*sin(2*pi/360*linspace(80,360-80,100))];
    line_topo(ax_idx)=line(headx,heady,'Color',[0,0,0],'Linewidth',2,'parent',axes_topo(ax_idx));
    dot_topo(ax_idx)=line(headx,heady,'Color',[0,0,0],'Linestyle','none','Marker','.','Markersize',8,'parent',axes_topo(ax_idx));
end
colormap 'jet';
colorbar_topo=colorbar;
p=get(fig_temp,'position');
set(colorbar_topo,'units','pixels');
set(colorbar_topo,'position',[p(3)-40,10,10,p(4)-20]);
set(colorbar_topo,'units','normalized');
set(axes_topo,'Visible','off');
ax_idx=0;
for dataset_index=1:length(datasets)
    header=datasets(dataset_index).header;
    chan_used=find([header.chanlocs.topo_enabled]==1);
    if isempty(chan_used)
        header=RLW_edit_electrodes(header,S.userdata.chanlocs);
    end
    header=CLW_make_spl(header);
    chan_used=find([header.chanlocs.topo_enabled]==1);
    
    if isempty(chan_used)
        vq=nan(267,267);
        for epoch_index=1:length(selected_epochs)
            ax_idx=ax_idx+1;
            set( surface_topo(ax_idx),'CData',vq);
            str=[char(userdata.str_dataset(userdata.selected_datasets(dataset_index))),' [',num2str(epoch_index),']'];
            title_topo(ax_idx)=title(axes_topo(ax_idx),str,'Interpreter','none');
        end
    else
%         t=(0:header.datasize(6)-1)*header.xstep+header.xstart;
        chanlocs=header.chanlocs(chan_used);
        [y,x]= pol2cart(pi/180.*[chanlocs.theta],[chanlocs.radius]);
%         [index_pos,y_pos,z_pos]=get_iyz_pos(header);
        index_pos = 1;y_pos = 1;z_pos = 1;

%         [~,b]=min(abs(t-userdata.cursor_point));
        data=squeeze(datasets(dataset_index).data...
            (:,chan_used,index_pos,y_pos,z_pos,b));
        selected_epochs = 1;
        for epoch_index=1:length(selected_epochs)
            ax_idx=ax_idx+1;
            vq = griddata(x,y,data(selected_epochs(epoch_index),:),xq,yq,'cubic');
            set( surface_topo(ax_idx),'CData',vq);
            set( dot_topo(ax_idx),'XData',x);
            set( dot_topo(ax_idx),'YData',y);
            str=[char(header.name),' [',num2str(epoch_index),']'];
            title_topo(ax_idx)=title(axes_topo(ax_idx),str,'Interpreter','none');
        end
    end
end
set(title_topo,'Visible','on');
% pause(0.01)
startup_IBS('remove')
end


function [index_pos,y_pos,z_pos]=get_iyz_pos(header)
        if strcmp(get(handles.index_popup,'Visible'),'off')
            index_pos=1;
        else
            index_pos=get(handles.index_popup,'Value');
        end
        if strcmp(get(handles.y_edit,'Visible'),'off')
            y_pos=1;
        else
            y=str2double(get(handles.y_edit,'String'));
            y_pos=round(((y-header.ystart)/header.ystep)+1);
            if y_pos<1
                y_pos=1;
            end
            if y_pos>header.datasize(5)
                y_pos=header.datasize(5);
            end
            set(handles.y_edit,'String',num2str((y_pos-1)*header.ystep+header.ystart));
        end
        if strcmp(get(handles.z_edit,'Visible'),'off')
            z_pos=1;
        else
            z=str2num(get(handles.z_edit,'String'));
            z_pos=round((z-header.zstart)/header.zstep)+1;
            if z_pos<1
                z_pos=1;
            end;
            if z_pos>header.datasize(4)
                z_pos=header.datasize(4);
            end
            set(handles.z_edit,'String',num2str((z_pos-1)*header.zstep+header.zstart));
        end
    
end