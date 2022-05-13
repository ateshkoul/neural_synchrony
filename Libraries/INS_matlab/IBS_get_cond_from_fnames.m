function split_fnames = IBS_get_cond_from_fnames(fnames)
% if nargin<2
%     delimiter = '_';
% end
split_fnames = cellfun(@(x) IBS_get_cond_from_fname(x),fnames,'UniformOutput',false);

end


function split_fname = IBS_get_cond_from_fname(fname)


% if nargin<2
%     delimiter = '_';
% end

% split_ = strsplit(fname,delimiter);
% split_fname = split_(1,1);
conditions = {'Baseline start','FaOcc','FaNoOcc','NeOcc','NeNoOcc','Task','Baseline end'};

split_fname = conditions{cell2mat(cellfun(@(x) contains(fname,x),conditions,'UniformOutput',false))};




end