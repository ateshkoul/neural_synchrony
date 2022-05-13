function ppt = IBS_powerpoint_plots(ppt,root_dir,select_string,analysis_type,analysis,file_delimiter)


% if nargin<4
%     file_types = '_CAR_multiplot';
%
% end

if nargin <8
    file_delimiter = '_';
end
%     analysis = 'Power_correlation_analysis';

analysis_params = IBS_get_params_analysis_type(analysis_type,analysis);

% plot_loc = analysis_params.plot_loc{1,1};

% analysis_type = '_CAR_baseline_normchange_0_120s';
import mlreportgen.ppt.*
% open(ppt);


%% create a title slide
titleSlide = add(ppt,'Title Slide');
replace(titleSlide,'Title',[strrep(analysis_type,'_',' ')]);


%%
fnames = IBS_select_files(root_dir,select_string);
% fnames = IBS_select_files(root_dir,[analysis_type '_' data_type '_' file_types]);
% fnames = IBS_select_files(root_dir,[analysis_type data_type '_' file_types]);
% cond_names = IBS_get_cond_from_fnames(fnames,file_delimiter);


switch(contains(select_string,'t_effects'))
    case 0
        add_pic_slide_fun_anova = analysis_params.add_pic_slide_fun_anova{1,1};%@IBS_addPicSlide
        % function that says where each condition goes in the powerpoint
        % plots = cellfun(@(x) Picture(fullfile(root_dir,x)),fnames);
        
        % cellfun(@(x) add_pic_slide_fun_anova(ppt,x,root_dir,analysis_type),fnames);
        add_pic_slide_fun_anova(ppt,fnames,root_dir,analysis_type);
    case 1
        add_pic_slide_fun_conds = @IBS_addPicSlide_t_tests_combined;%@IBS_addPicSlide
        % function that says where each condition goes in the powerpoint
        add_pic_slide_fun_conds(ppt,fnames,root_dir,analysis_type,analysis);
        
        
        
end


end


