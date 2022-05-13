function IBS_brain_physio_plot_stat_brain_behav(brain_stat,behav_data,Dyad_no,cluster_no,plot_title,varargin_table)
%% Atesh Koul
% 16-03-2021
if nargin <5
    plot_title = "";
end
try
    rows = varargin_table.rows;
catch
    rows = 1:1201-41;
end
try
    variable = varargin_table.variable;
catch
    variable = 1;
end
try
    
    smooth = varargin_table.smooth;
catch
    smooth = 1;
end
% figure
plot(brain_stat{1,Dyad_no}{cluster_no}(rows))
hold on
switch(smooth)
    case 0
        plot(table2array(behav_data{1}{1,Dyad_no}(rows,variable)),'r')
        
        plot(table2array(behav_data{2}{1,Dyad_no}(rows,variable)),'g')
    case 1
%         plot(smoothdata(table2array(behav_data{1}{1,Dyad_no}(rows,variable)),'movmean',50)-smoothdata(table2array(behav_data{2}{1,Dyad_no}(rows,variable)),'movmean',50),'r')
        plot(smoothdata(table2array(behav_data{1}{1,Dyad_no}(rows,variable)),'movmean',50),'r')
        
        plot(smoothdata(table2array(behav_data{2}{1,Dyad_no}(rows,variable)),'movmean',50),'g')
end
% k = brain_stat{1,Dyad_no}{cluster_no}(rows);
% s = smoothdata(table2array(behav_data{2}{1,Dyad_no}(rows,variable)),'movmean',50)-smoothdata(table2array(behav_data{1}{1,Dyad_no}(rows,variable)),'movmean',50);
% crosscorr(k,s,'NumLags',60)

title(plot_title,'Interpreter', 'none')
end