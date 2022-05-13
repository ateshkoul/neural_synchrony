
function ppt = IBS_addPicSlide_combined(ppt,fnames,root_dir,analysis_type,analysis)
plots = cell(1,length(fnames));
pictureSlide1 = add(ppt,'Title and Content');
% replace(pictureSlide1,'Title',strrep(fname,'_',' '));
replace(pictureSlide1,'Title',strrep(analysis_type,'_',' '));
replace(pictureSlide1,'Content','');
for fname_no = 1:length(fnames)
    
    plots{fname_no} = addPicSlide_combined(fnames{fname_no},root_dir);
    add(pictureSlide1,plots{fname_no});
end







% add(pictureSlide1,plots{1,2});

end


function plot = addPicSlide_combined(fname,root_dir)
import mlreportgen.ppt.*

cur_anova_cond = find(cell2mat(cellfun(@(x) contains(fname,x),{'Dist','Occ','interaction'},'UniformOutput',false)));

plot = Picture(fullfile(root_dir,fname));
switch(cur_anova_cond)
    case 1
        plot.X = [num2str(0) 'in'];
        plot.Y = [num2str(2.5) 'in'];
    case 2
        plot.X = [num2str(3.32) 'in'];
        plot.Y = [num2str(2.5) 'in'];
    case 3
        plot.X = [num2str(6.62) 'in'];
        plot.Y = [num2str(2.5) 'in'];
        
end


plot.Width = '3.35in';
plot.Height = '2.54in';
end