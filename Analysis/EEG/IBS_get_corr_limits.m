function [mean_limits,t_value_limits,varargout_table] = IBS_get_corr_limits(cor_fun,limit_args)
% if nargin >1
%     measure = varargin{1,1};
%     if ~contains(measure,{'plv','coh'})
%         
%         error('wrong measure used');
%     end
% end



if ~isempty(limit_args)
    measure = limit_args{1,1};
    if ~contains(measure,{'plv','coh'})
        
        error('wrong measure used');
    end
end

switch(func2str(cor_fun))
    case 'IBS_process_tf_connectivity'
        switch(measure)
            case 'coh'
                mean_limits = [0 0.1];
                t_value_limits = [-18 18];
                cmap = colormap();
                cmap = cmap(128:end,:,:);
                varargout_table = table(cmap);
            case 'plv'
                mean_limits = [0 0.7];
                t_value_limits = [-18 18];
                cmap = colormap();
                cmap = cmap(128:end,:,:);
                varargout_table = table(cmap);
        end
        
        
    case 'IBS_tf_coherence_correlations_manual'
        switch(measure)
            case 'coh'
                mean_limits = [0 0.02];
                t_value_limits = [-18 18];
                cmap = colormap();
                cmap = cmap(128:end,:,:);
                varargout_table = table(cmap);
            case 'plv'
                mean_limits = [0.3 0.7];
                t_value_limits = [-18 18];
                cmap = colormap();
                cmap = cmap(128:end,:,:);
                varargout_table = table(cmap);
        end
    case 'IBS_tf_correlations'
%         mean_limits = [-0.15 0.15];
        mean_limits = [-0.05 0.05];
        t_value_limits = [-10 10];
        varargout_table = table();
        
       case 'IBS_tf_correlations_avg_window'
        mean_limits = [-0.15 0.15];
        t_value_limits = [-10 10];
        varargout_table = table();
        
        case 'IBS_monkey_tf_correlations'
        mean_limits = [-0.15 0.15];
        t_value_limits = [-10 10];
        varargout_table = table();
        
    case 'IBS_test_correlation_dyad_specific'
        mean_limits = [-0.05 0.05];
        t_value_limits = [-10 10];
        varargout_table = table();
        
        
end


end