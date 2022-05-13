function plot1 = IBS_add_moving_window_pic_slide(filename,slide_col)

import mlreportgen.ppt.*
% insert picture slides
% pictureSlide = add(ppt,'Title and Picture');
% pictureSlide = add(ppt,'Blank');
% plot1 = Picture(which(filename));
plot1 = Picture(filename);

load('powerpoint_map_loc_moving_window_F_value_matrix')

slide_col_start = [1 4 7 10];

anova_conditions = {'main_effects_Occ','main_effects_Dist','interaction'};

cur_anova_cond = anova_conditions{cell2mat(cellfun(@(x) contains(filename,x),anova_conditions,'UniformOutput',false))};



switch(cur_anova_cond)
    case 'main_effects_Occ'
        plot1.X = [num2str(map_loc(slide_col_start(slide_col),1)) 'in'];
        plot1.Y = [num2str(map_loc(slide_col_start(slide_col),2)) 'in'];
    case 'main_effects_Dist'
        plot1.X = [num2str(map_loc(slide_col_start(slide_col)+1,1)) 'in'];
        plot1.Y = [num2str(map_loc(slide_col_start(slide_col)+1,2)) 'in'];
    case 'interaction'
        plot1.X = [num2str(map_loc(slide_col_start(slide_col)+2,1)) 'in'];
        plot1.Y = [num2str(map_loc(slide_col_start(slide_col)+2,2)) 'in'];
        
end



plot1.Height = [num2str(map_loc(1,3)) 'in'];
plot1.Width = [num2str(map_loc(1,4)) 'in'];

end
% 
% map_loc = [];
% map_loc(1:12,3) = 1.76;
% map_loc(1:12,4) = 2.62;
% map_loc(1:3,1) = 0.12;
% map_loc(4:6,1) = 2.5;
% 
% map_loc(7:9,1) = 4.88;
% map_loc(10:12,1) = 7.26;
% map_loc([1 4 7 10],2) = 2.15;
% map_loc([1 4 7 10]+1,2) = 3.95;
% map_loc([1 4 7 10]+2,2)=5.75;
% save('powerpoint_map_loc_moving_window_F_value_matrix','map_loc')