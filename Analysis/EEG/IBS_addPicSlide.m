function ppt = IBS_addPicSlide(ppt,fnames,root_dir,analysis_type,analysis)
import mlreportgen.ppt.*


for fname_no = 1:length(fnames)
plot = Picture(fullfile(root_dir,fnames{fname_no}));
plot.X = [num2str(0) 'in'];
plot.Y = [num2str(2.5) 'in'];

plot.Width = '9.95in';
plot.Height = '5in';

pictureSlide1 = add(ppt,'Title and Content');
% replace(pictureSlide1,'Title',strrep(fname,'_',' '));
replace(pictureSlide1,'Title',strrep(analysis_type,'_',' '));

replace(pictureSlide1,'Content','');
add(pictureSlide1,plot);
end

end