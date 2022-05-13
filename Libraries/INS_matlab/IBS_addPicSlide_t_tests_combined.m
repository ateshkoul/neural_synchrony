function ppt = IBS_addPicSlide_t_tests_combined(ppt,fnames,root_dir,analysis_type,analysis)
plots = cell(1,length(fnames));
conds = IBS_get_cond_from_fnames(fnames);

pictureSlide1 = add(ppt,'Title and Content');
% replace(pictureSlide1,'Title',strrep(fname,'_',' '));
replace(pictureSlide1,'Title',strrep(analysis_type,'_',' '));
replace(pictureSlide1,'Content','');


for cond_no = 1:length(conds)
    cur_cond = conds{cond_no};
    fname = fnames{cond_no};
    plots{cond_no} = IBS_add_pic_slide_fig([root_dir fname],cur_cond,'t_test');
    add(pictureSlide1,plots{cond_no});
end


end