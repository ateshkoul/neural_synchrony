function [depth_field_value] = IBS_get_rep_struct_field_from_depth(struct_var,rep_fieldname,depth,req_field)
% rep_fieldname: repeated field
% req_fieldname : required fieldname
field = strjoin(repmat({rep_fieldname},1,depth),''',''');

depth_field_value = eval(['getfield(struct_var,''' field ''',''' req_field ''')']);


end