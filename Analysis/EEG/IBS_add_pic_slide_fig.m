
function plot1 = IBS_add_pic_slide_fig(filename,condition,type)


if nargin <3
    
    type = 'corr';
end
import mlreportgen.ppt.*
% insert picture slides
% pictureSlide = add(ppt,'Title and Picture');
% pictureSlide = add(ppt,'Blank');
% plot1 = Picture(which(filename));
plot1 = Picture(filename);
switch(type)
    case 'corr'
load('powerpoint_fig_loc_all_figures');
    case 't_test'
load('t_test_cond_loc.mat','t_test_cond_loc')
cond_loc = t_test_cond_loc;
end
switch(condition)
    case 'Baseline start'
        plot1.X = [num2str(cond_loc(1,1)) 'in'];
        plot1.Y = [num2str(cond_loc(1,2)) 'in'];
    case 'Baseline end'
        plot1.X = [num2str(cond_loc(6,1)) 'in'];
        plot1.Y = [num2str(cond_loc(6,2)) 'in'];
    case 'FaOcc'
        plot1.X = [num2str(cond_loc(2,1)) 'in'];
        plot1.Y = [num2str(cond_loc(2,2)) 'in'];
        
    case 'FaNoOcc'
        plot1.X = [num2str(cond_loc(3,1)) 'in'];
        plot1.Y = [num2str(cond_loc(3,2)) 'in'];
        
    case 'NeOcc'
        plot1.X = [num2str(cond_loc(4,1)) 'in'];
        plot1.Y = [num2str(cond_loc(4,2)) 'in'];
        
    case 'NeNoOcc'
        plot1.X = [num2str(cond_loc(5,1)) 'in'];
        plot1.Y = [num2str(cond_loc(5,2)) 'in'];
        
end



plot1.Height = [num2str(cond_loc(1,3)) 'in'];
plot1.Width = [num2str(cond_loc(1,4)) 'in'];

end