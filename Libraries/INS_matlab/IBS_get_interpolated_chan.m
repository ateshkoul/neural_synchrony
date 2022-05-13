function [interp_ch_S1,interp_ch_S2] = IBS_get_interpolated_chan(data_struct)
% this is the arrangement because of the way analysis is done
try
interp_ch_S1 = data_struct.cfg.previous{1,1}.previous.previous.previous.badchannel;
catch
    interp_ch_S1 = [];
disp('check if interpolation has been done for Sub 1');
end

 try
interp_ch_S2 = data_struct.cfg.previous{1,1}.previous.previous.badchannel;
 catch
    interp_ch_S2 = [];
    disp('check if interpolation has been done for Sub 2');

end


% check what is outputted

if ~isempty(interp_ch_S1) && sum(contains(interp_ch_S1,'1-'))~= numel(interp_ch_S1)
    disp('interpolation for Sub 1 is wrong');


end

% this means either of the two cases:
% 1. there are mixed values in interp_ch_S2 i.e., 1- and 2- electrodes
% 2. there are only 1- electrodes in interp_ch_S2
% if ~isempty(interp_ch_S2) && sum(contains(interp_ch_S2,'2-'))~=numel(interp_ch_S2)
%     disp('interpolation for Sub 2 is wrong');
% end

% this is better- the condition that all the channels in S2 are '1-' is
% rectified below
% this condition tests only mixed condition
if ~isempty(interp_ch_S2) && sum(contains(interp_ch_S2,'2-'))>0 && sum(contains(interp_ch_S2,'1-')) >0
    disp('interpolation for Sub 2 is wrong');
end

% all the presumed S2 are '1-' channels, correct this. 
if ~isempty(interp_ch_S2) && sum(contains(interp_ch_S2,'1-'))==numel(interp_ch_S2)
    disp('no interpolation for Sub 2 - replacing S2 with S1');
    interp_ch_S1 = interp_ch_S2;
    interp_ch_S2 = [];
end


end


