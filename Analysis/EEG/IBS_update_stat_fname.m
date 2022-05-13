function [cluster_fname] = IBS_update_stat_fname(cluster_fname,analysis_type,cor_fun,varargin_table)

if nargin >3
    try
        measure = varargin_table.measure;
        if ~contains(measure,{'plv','coh','corr','within'})
            
            error('wrong measure used');
        end
    catch
        error('no measure provided');
    end
end
switch(func2str(cor_fun))
    case {'IBS_process_tf_connectivity','IBS_tf_coherence_correlations_manual'}
        cluster_fname = strrep(cluster_fname,'cluster_plot_correlation_',['cluster_plot_' func2str(cor_fun) '_' measure '_']);
        %         cluster_main_effects_fname = strrep(cluster_fname,'cluster_plot_correlation_main_effects_',['cluster_plot_' func2str(cor_fun) '_' measure '_']);
        %         cluster_interaction_fname = strrep(cluster_fname,'cluster_plot_correlation_interaction_',['cluster_plot_' func2str(cor_fun) '_' measure '_']);
        
    case 'IBS_tf_correlations'
        % basically do nothing
        cluster_fname = strrep(cluster_fname,'cluster_plot_correlation_',...
            ['cluster_plot_' func2str(cor_fun) '_detrend_']);
    case 'IBS_save_dyad_tf_moving_corr'
        %         cluster_fname = strrep(cluster_fname,'cluster_plot_correlation_',...
        %             ['cluster_plot_' func2str(cor_fun) '_' num2str(varargin_table.windowSize) '_window_'...
        %             num2str(varargin_table.freq_bands(1)) '_'...
        %             num2str(varargin_table.freq_bands(end)) '_' ]);
        
        cluster_fname = strrep(cluster_fname,'cluster_plot_correlation_',...
            ['cluster_plot_' func2str(cor_fun) '_' sprintf('%0.2d_window_%0.1d_%0.1d_',varargin_table.windowSize,...
            varargin_table.freq_bands(1),varargin_table.freq_bands(end))]);
        
    case 'IBS_load_within_brain_analysis_data'
        cluster_fname = strrep(cluster_fname,'cluster_plot_correlation_',...
            ['cluster_plot_' func2str(cor_fun) '_']);
    case 'IBS_test_correlation_dyad_specific'
        cluster_fname = strrep(cluster_fname,'cluster_plot_correlation_',...
            ['cluster_plot_' func2str(cor_fun) '_']);
        
    case 'IBS_test_correlation_dyad_specific_difference'
%         cluster_fname = strrep(cluster_fname,'cluster_plot_correlation_',...
%             ['cluster_plot_' func2str(cor_fun) '_']);
        cluster_fname = strrep(cluster_fname,'cluster_plot_correlation_',...
            ['cluster_plot_detrend_' func2str(cor_fun) '_']);        
    case 'IBS_tf_within_pwr_decomp_trialwise'
        cluster_fname = strrep(cluster_fname,'cluster_plot_correlation_',...
            ['cluster_plot_' func2str(cor_fun) '_']);
        
    case 'IBS_tf_mutual_info'
        
        cluster_fname = strrep(cluster_fname,'cluster_plot_correlation_',...
            ['cluster_plot_' func2str(cor_fun) '_detrend_']);
end


end
