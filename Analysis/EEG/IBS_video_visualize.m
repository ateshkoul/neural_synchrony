function IBS_video_visualize(data_table)

%% function that visualizes movement landmarks from video
% data_table - (table)preprocessed movement landmark data
% index - (double)frame no to visualize

%% Atesh
% 21-01-2021
x_indicies = contains(data_table.Properties.VariableNames,'_x');
y_indicies = contains(data_table.Properties.VariableNames,'_y');
figure('units','normalized','outerposition',[0.5 0 0.25 1])


index = 1;
data_table = table2array(data_table);
h = scatter(data_table(index,x_indicies),-data_table(index,y_indicies));
    axis([0 720 -1250 0])
    ax = gca;
    ax.XAxisLocation = 'top';
for index = 2:size(data_table,1)
    set(h,'XData',data_table(index,x_indicies),'YData',-data_table(index,y_indicies));
    drawnow
%     pause(1/5)

end


end

