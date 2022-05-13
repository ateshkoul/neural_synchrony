function [measure_field] = IBS_get_field_conn_measure(measure)
%% Atesh
% 18-12-2020
% function to transform conn measure to the actual field in fieldtrip

switch(measure)
    
    case 'plv'
        measure_field = 'plvspctrm';
    case 'coh'
        measure_field = 'cohspctrm';

end

end
