
figure_save_dir = 'Y:\\Inter-brain synchrony\\Paper\\Figures\\Resources\\';


%%

x = -150:3:150;


pd = makedist('Normal','mu',0,'sigma',30);
y1 = pdf(pd,x);
% y1 = sin(2*pi*x/100);
%     y = y/6;
    plot(x,y1,'b')
    hold on
 pd = makedist('Normal','mu',30,'sigma',35);
y2 = pdf(pd,x);   
% y2 = cos(2*pi*x/100 + 0.5);

     y2 = y2/1.0001;
plot(x,y2,'r')
ax = gca;
% set(ax,'Visible','off')
% axes('Position',get(ax,'Position'),...
%  'XAxisLocation','bottom',...
%  'YAxisLocation','left',...
%  'Color','none')
% set(ax, 'XTickLabel', {-150:50:150})

exportgraphics(ax,[figure_save_dir '\\cross_corr_example_signal.eps'],'BackgroundColor','none','ContentType','vector')


%%
figure
% crosscorr(y2,y1,'numlags',50)
s = xcov(y1,y2,50,'coeff');
plot(-50:50,s)
yline(0)
% set(gca,'Visible','off')
% axes('Position',get(gca,'Position'),...
%  'XAxisLocation','bottom',...
%  'YAxisLocation','left',...
%  'Color','none')
% set(gca, 'XTickLabel', {-50:10:50})
ax = gca;
exportgraphics(ax,[figure_save_dir '\\cross_corr_example_cross_corr.eps'],'BackgroundColor','none','ContentType','vector')


%%
lag_amounts = [-50:10:50];
figure('units','normalized','outerposition',[0 0 1 0.3])

for lag_no = 1:11
        subplot(1,11,lag_no)
    
        
        
        
% y2 = cos(2*pi*x/100 + 0.5);

% plot(x,circshift(y2,lag_amounts(lag_no)),'r')
if lag_amounts(lag_no)<0
        plot(x,y1,'b')
hold on
plot(x,[y2(-lag_amounts(lag_no)+1:end) zeros(1,-lag_amounts(lag_no))],'r')
end

if lag_amounts(lag_no)==0
        

plot(x,y1,'b')
hold on
plot(x,y2,'r')
end


% if lag_amounts(lag_no)>0
%         
% 
% plot(x,[y1(lag_amounts(lag_no)+1:end) zeros(1,lag_amounts(lag_no))],'b')
% hold on
% plot(x,y2,'r')
% end

if lag_amounts(lag_no)>0
        plot(x,y1,'b')
hold on
plot(x,[zeros(1,lag_amounts(lag_no)) y2(1:end-lag_amounts(lag_no))],'r')
end
set(gca,'Visible','off')
axes('Position',get(gca,'Position'),...
 'XAxisLocation','bottom',...
 'YAxisLocation','left',...
 'Color','none')

%     ax = gca;
set(gca,'XTick',[])
% 
set(gca,'YTick',[])
% cor(lag_no) = corr(y1',circshift(y2,lag_amounts(lag_no))');
end

exportgraphics(gcf,[figure_save_dir '\\cross_corr_example_plots.eps'],'BackgroundColor','none','ContentType','vector')


close all

%% not a very appropriate way to do this:
plot_a_values = [-5 -4 -3 -2 -1 0 0 0 0 0 0];
plot_b_values = [0 0 0 0 0 0 1 2 3 4 5];

% plot_a_values = [-3 -2 -1 0 0 0 0 ];
% plot_b_values = [ 0 0 0 0 1 2 3 ];

figure('units','normalized','outerposition',[0 0 1 0.3])
for plot_no = 1:11
    subplot(1,11,plot_no)

pd = makedist('Normal','mu',plot_a_values(plot_no),'sigma',8);
y1 = pdf(pd,x);
%     y = y/6;
    plot(x,y1,'b')
    hold on
 pd = makedist('Normal','mu',plot_b_values(plot_no),'sigma',7);
y2 = pdf(pd,x);   
     y2 = y2/1.0001;
    plot(x,y2,'k:')


set(gca,'Visible','off')
axes('Position',get(gca,'Position'),...
 'XAxisLocation','bottom',...
 'YAxisLocation','left',...
 'Color','none')

    ax = gca;
set(gca,'XTick',[])

set(gca,'YTick',[])

end




figure_save_dir = 'Y:\\Inter-brain synchrony\\Paper\\Figures\\Resources\\';


exportgraphics(gcf,[figure_save_dir '\\cross_corr_example.eps'],'BackgroundColor','none','ContentType','vector')
lags = 30;
s = xcov(y1,y2,lags,'coeff');

close all