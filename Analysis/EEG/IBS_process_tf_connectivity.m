function [correlations,conditions,coherence_fname] = IBS_process_tf_connectivity(analysis_type,measure,con_fun)
if nargin <2
    
   measure = 'coh';
end


if nargin <3
   con_fun = @IBS_tf_coherence_correlations;
end
[correlations,conditions,coherence_fname] = con_fun(analysis_type,measure);

measure_field = IBS_get_field_conn_measure(measure);
correlations = cellfun(@(x) cellfun(@(y) getfield(y,measure_field), x,'UniformOutput',false),correlations,'UniformOutput',false);


end