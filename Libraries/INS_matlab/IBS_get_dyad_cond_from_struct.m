function [Dyad, block_no,depth,datafile] = IBS_get_dyad_cond_from_struct(dataset_struct,depth,ICA_cleaned)
if nargin<2
    depth = 2;
    ICA_cleaned = false;
end

if nargin <3
    ICA_cleaned = false;
end
if ICA_cleaned
    field = strjoin(repmat({'previous'},1,depth-2),''',''');
    dataset_pre_ICA = getfield(dataset_struct.cfg,{1},'previous',{1});
    datafile = eval(['getfield(dataset_pre_ICA{1,1},''' field ''',''datafile'')']);
    
else
    field = strjoin(repmat({'previous'},1,depth),''',''');
    datafile = eval(['getfield(dataset_struct.cfg,''' field ''',''datafile'')']);
    
end
[~,datafile_name,~] = fileparts(datafile);
blocks = {'baseline_1','blocks','baseline_2'};
block_no = find(cellfun(@(x) contains(datafile_name,x),blocks)>0);
block_type = blocks(block_no);

rem_block_type = erase(datafile_name,['_' block_type{1,1}]);


Dyad = str2double(erase(rem_block_type,'Dyad_'));

end