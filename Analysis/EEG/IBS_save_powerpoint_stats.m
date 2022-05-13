
function ppt = IBS_save_powerpoint_stats(analysis_types,ppt,select_string,analysis)

% analysis = 'Connectivity_analysis';
for i = 1:numel(select_string)
    
    select_string_main = [select_string{i} '_main_effects_'];
    select_string_interaction = [select_string{i} '_interaction_'];
    
    for j = 1:numel(analysis_types)
        
        
        analysis_params = IBS_get_params_analysis_type(analysis_types{j},analysis);
        
        analysis_folder = analysis_params.analysis_folder{1,1};
        
        
        root_result_dir = IBS_get_params_analysis_type(analysis_types{j}).root_result_dir{1,1};
        save_dir = [root_result_dir analysis_folder '\\' analysis_types{j} '\\' 'figures\\'];
        
        % save_dir = IBS_get_params_analysis_type(analysis_types{j},analysis).analysis_save_dir_figures{1,1};
        
        switch(contains(analysis,'fig'))
            case 1
                select_string_fig = select_string{i};
                IBS_powerpoint_plots(ppt,save_dir,select_string_fig,analysis_types{j},analysis);
                
            case 0
                IBS_powerpoint_plots(ppt,save_dir,select_string_main,analysis_types{j},analysis);
                
                
                IBS_powerpoint_plots(ppt,save_dir,select_string_interaction,analysis_types{j},analysis);
                
        end
    end
    
    
end