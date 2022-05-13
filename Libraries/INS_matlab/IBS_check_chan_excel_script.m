function value = IBS_check_chan_excel_script(excel,script)

excel = strtrim(excel);
if iscell(script) && numel(excel)>0
    
    present = cellfun(@(x) contains(excel,x),script);
    value = sum(present)==numel(script) && numel(excel) == numel(strjoin(script,',')) ;
else
    value = NaN;
end

end