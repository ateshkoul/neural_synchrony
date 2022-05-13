function [data_coherence] =  IBS_tf_coherence_condwise(data_ica_clean_S1,data_ica_clean_S2,condition,coherence_fun,varargin)
%% Atesh
% wrapper function for IBS_tf_coherence

if nargin<4
    coherence_fun = @IBS_tf_coherence; 
    
end
% important that the string is exact otherwise the values are not possible
% to obtain
mapObj = containers.Map({'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'},...
{'11  12  13','21  22  23','31  32  33','41  42  43',...
    '51  52  53','61  62  63','71  72  73' });



switch(condition)
    case 'Baseline start'
        data_struct_S1  = data_ica_clean_S1{1,1};
        data_struct_S2  = data_ica_clean_S2{1,1};

    case {'FaOcc','FaNoOcc', 'NeOcc', 'NeNoOcc', 'Task'}
        data_struct_S1 = data_ica_clean_S1{1,2};
        data_struct_S2  = data_ica_clean_S2{1,2};

    case 'Baseline end'
        data_struct_S1  = data_ica_clean_S1{1,3};
        data_struct_S2  = data_ica_clean_S2{1,3};

        
end



data_coherence   = coherence_fun(data_struct_S1,data_struct_S2,str2num(mapObj(condition)),varargin{:});



end