function IBS_powerpoint_plots_moving_window(ppt,root_dir,data_type,analysis_type,anova_conditions,file_precursur)


if nargin<4
    file_types = '_CAR_multiplot';
    
end

if nargin <7
    file_precursur = '';
end
% analysis_type = '_CAR_baseline_normchange_0_120s';
import mlreportgen.ppt.*
% open(ppt);


%% create a title slide
titleSlide = add(ppt,'Title Slide');
replace(titleSlide,'Title',[strrep(analysis_type,'_',' ')]);

% cluster_plot_IBS_save_dyad_tf_moving_corr_5_window_1_95_main_effects_Occ_no_aggressive_trialwise_CAR__F_value_images_all_dyads
%%
% fnames = cellfun(@(x) IBS_select_files(root_dir,[file_precursur x '_' analysis_type '_' data_type '_' file_types]),anova_conditions,'UniformOutput',false);

fnames = IBS_select_files(root_dir,data_type);

n_cols = ceil(numel(fnames)/12);
if n_cols >1
    
    start_element = 1;
    for col = 1:(n_cols-1)
        batch = fnames(start_element:(start_element+11));
        % function that says where each condition goes in the powerpoint
        % cond_names = IBS_get_cond_from_fnames(fnames,file_delimiter);
        
        slide_cols = repmat([1 2 3 4],3,1);
        slide_cols = num2cell(slide_cols(:));
        
        plots = cellfun(@(x,y) IBS_add_moving_window_pic_slide(fullfile(root_dir,x),y),batch,slide_cols');
        
        
        eval(['pictureSlide_' num2str(col)  ' = add(ppt,''Title and Content'')']);
        
        for plot_no = 1:numel(plots)
            eval(['add( pictureSlide_' num2str(col) ',plots(plot_no))'])
            %         add(pictureSlide1,plots(plot_no));
            
        end
        start_element = start_element+12;
    end
    
    last_batch = fnames((n_cols-1)*12+1:end);
    
    
    slide_cols = repmat([1:(numel(last_batch)/3)],3,1);
    slide_cols = num2cell(slide_cols(:));
    
    plots_last = cellfun(@(x,y) IBS_add_moving_window_pic_slide(fullfile(root_dir,x),y),last_batch,slide_cols');
    pictureSlide_last= add(ppt,'Title and Content');
    
    for plot_no = 1:numel(plots_last)
        add(pictureSlide_last,plots_last(plot_no));
        
    end
    
    %     first_batch = fnames(1:4*3);
    %     % function that says where each condition goes in the powerpoint
    %     % cond_names = IBS_get_cond_from_fnames(fnames,file_delimiter);
    %
    %     slide_cols = repmat([1 2 3 4],3,1);
    %     slide_cols = num2cell(slide_cols(:));
    %
    %     plots = cellfun(@(x,y) IBS_add_moving_window_pic_slide(fullfile(root_dir,x),y),first_batch,slide_cols');
    %
    %
    %     pictureSlide1 = add(ppt,'Title and Content');
    %
    %     for plot_no = 1:numel(plots)
    %         add(pictureSlide1,plots(plot_no));
    %
    %     end
    %
    %     next_batch = fnames(4*3+1:end);
    %
    %
    %     slide_cols = repmat([1:(numel(next_batch)/3)],3,1);
    %     slide_cols = num2cell(slide_cols(:));
    %
    %     plots2 = cellfun(@(x,y) IBS_add_moving_window_pic_slide(fullfile(root_dir,x),y),next_batch,slide_cols');
    %
    %
    %     pictureSlide2 = add(ppt,'Title and Content');
    %
    %     for plot_no = 1:numel(plots2)
    %         add(pictureSlide2,plots2(plot_no));
    %
    %     end
    
    
    
end

end
