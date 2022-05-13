function IBS_powerpoint_plots_tf_correlations(ppt,root_dir,data_type,file_types,analysis_type,conditions,file_precursur,analysis)


if nargin<4
    file_types = '_CAR_multiplot';
    
end

if nargin <7
    file_precursur = '';
end



analysis_params = IBS_get_params_analysis_type(analysis_type,analysis);

add_pic_slide_fun_conds = analysis_params.add_pic_slide_fun_conds{1,1};

plot_loc = analysis_params.plot_loc{1,1};

cur_conditions = ismember(conditions,analysis_params.fig_conds);
conditions = conditions(cur_conditions);
% analysis_type = '_CAR_baseline_normchange_0_120s';
import mlreportgen.ppt.*
% open(ppt);


%% create a title slide
titleSlide = add(ppt,'Title Slide');
replace(titleSlide,'Title',[strrep(analysis_type,'_',' ')]);


%%
fnames = cellfun(@(x) IBS_select_files(root_dir,[file_precursur x '_' analysis_type '_' data_type '_' file_types]),conditions,'UniformOutput',false);
% fnames = IBS_select_files(root_dir,[analysis_type '_' data_type '_' file_types]);
% fnames = IBS_select_files(root_dir,[analysis_type data_type '_' file_types]);
fnames = cat(1,fnames{:})';
% cond_names = IBS_get_cond_from_fnames(fnames,file_delimiter);
cond_names = IBS_get_cond_from_fnames(fnames);

% function that says where each condition goes in the powerpoint
plots = cellfun(@(x,y) add_pic_slide_fun_conds(fullfile(root_dir,x),y),fnames,cond_names);





switch(plot_loc)
    case 'multi_7'
        mapObj = containers.Map({'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'},...
            {1,2,3,4,5,6,7});
        
        %% baseline
        pictureSlide1 = add(ppt,'Title and Content');
        %         replace(pictureSlide1,'Title',['Baseline ' data_type ' ' file_types]);
        replace(pictureSlide1,'Title',strrep(analysis_type,'_',' '));
        
        add(pictureSlide1,plots(1,mapObj('Baseline start')));
        add(pictureSlide1,plots(1,mapObj('Baseline end')));
        %% conds
        pictureSlide2 = add(ppt,'Title and Content');
        %         replace(pictureSlide2,'Title',['Cond ' data_type ' ' file_types]);
        replace(pictureSlide2,'Title',strrep(analysis_type,'_',' '));
        
        add(pictureSlide2,plots(1,mapObj('FaOcc')));
        add(pictureSlide2,plots(1,mapObj('FaNoOcc')));
        add(pictureSlide2,plots(1,mapObj('NeOcc')));
        add(pictureSlide2,plots(1,mapObj('NeNoOcc')));
        %%
        pictureSlide3 = add(ppt,'Title and Content');
        %         replace(pictureSlide3,'Title',['Task ' data_type ' ' file_types]);
        replace(pictureSlide3,'Title',strrep(analysis_type,'_',' '));
        add(pictureSlide3,plots(1,mapObj('Task')));
        
        %%
    case 'multi_5'
        %% baseline
        mapObj = containers.Map({'FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task'},...
            {1,2,3,4,5});
        
        %% conds
        pictureSlide2 = add(ppt,'Title and Content');
        %         replace(pictureSlide2,'Title',['Cond ' data_type ' ' file_types]);
        replace(pictureSlide2,'Title',strrep(analysis_type,'_',' '));
        add(pictureSlide2,plots(1,mapObj('FaOcc')));
        add(pictureSlide2,plots(1,mapObj('FaNoOcc')));
        add(pictureSlide2,plots(1,mapObj('NeOcc')));
        add(pictureSlide2,plots(1,mapObj('NeNoOcc')));
        
        %
        %         add(pictureSlide2,plots(1,1));
        %         add(pictureSlide2,plots(1,2));
        %         add(pictureSlide2,plots(1,3));
        %         add(pictureSlide2,plots(1,4));
        
        %%
        pictureSlide3 = add(ppt,'Title and Content');
        %         replace(pictureSlide3,'Title',['Task ' data_type ' ' file_types]);
        replace(pictureSlide3,'Title',strrep(analysis_type,'_',' '));
        add(pictureSlide3,plots(1,mapObj('Task')));
    case 'same_7'
        mapObj = containers.Map({'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Baseline end'},...
            {1,2,3,4,5,6});
        
        %% baseline
        pictureSlide1 = add(ppt,'Title and Content');
        %         replace(pictureSlide1,'Title',['Baseline ' data_type ' ' file_types]);
        replace(pictureSlide1,'Title',strrep(analysis_type,'_',' '));
        
        add(pictureSlide1,plots(1,mapObj('Baseline start')));
        add(pictureSlide1,plots(1,mapObj('Baseline end')));
        %% conds

        add(pictureSlide1,plots(1,mapObj('FaOcc')));
        add(pictureSlide1,plots(1,mapObj('FaNoOcc')));
        add(pictureSlide1,plots(1,mapObj('NeOcc')));
        add(pictureSlide1,plots(1,mapObj('NeNoOcc')));
        
    case 'same_5'
        %% baseline
        mapObj = containers.Map({'FaOcc','FaNoOcc','NeOcc','NeNoOcc'},...
            {1,2,3,4});
        
        %% conds
        pictureSlide2 = add(ppt,'Title and Content');
        %         replace(pictureSlide2,'Title',['Cond ' data_type ' ' file_types]);
        replace(pictureSlide2,'Title',strrep(analysis_type,'_',' '));
        add(pictureSlide2,plots(1,mapObj('FaOcc')));
        add(pictureSlide2,plots(1,mapObj('FaNoOcc')));
        add(pictureSlide2,plots(1,mapObj('NeOcc')));
        add(pictureSlide2,plots(1,mapObj('NeNoOcc')));
        
end


end
