
function ppt = IBS_save_powerpoint_corr(analysis_types,ppt,plot_types,analysis,file_precursur)

if nargin <5
    file_precursur = '';
end



for i = 1:numel(plot_types)



for j = 1:numel(analysis_types)
    
  
analysis_params = IBS_get_params_analysis_type(analysis_types{j},analysis);

analysis_folder = analysis_params.analysis_folder{1,1};


root_result_dir = IBS_get_params_analysis_type(analysis_types{j}).root_result_dir{1,1};
result_dir = [root_result_dir analysis_folder '\\' analysis_types{j} '\\' 'figures\\'];


conditions = IBS_get_params_analysis_type(analysis_types{j}).conditions;
IBS_powerpoint_plots_tf_correlations(ppt,result_dir,'mean',plot_types{i},analysis_types{j},conditions,file_precursur,analysis)
IBS_powerpoint_plots_tf_correlations(ppt,result_dir,'t_value',plot_types{i},analysis_types{j},conditions,file_precursur,analysis)

    

end


end