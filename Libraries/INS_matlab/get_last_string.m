
function [last_value] = get_last_string(string_var,search_string)
if nargin<2
    search_string = '_';
    
end
h = strfind(string_var,search_string);

last_value = h(end);
end