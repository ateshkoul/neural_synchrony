function result = IBS_joint_and_fun(data_1,data_2)
%% Atesh Koul
% 03-03-2021
C = times(data_1,data_2);

% if sum(C)>= 0
%     result = 1;
%     
% else
%     if sum(C)<0
%         result = 0;
%     end
% end

if sum(C)>= (length(C)/2)
    result = 1;
    
else
    if sum(C)<(length(C)/2)
        result = 0;
    end
end


% if nansum(C)>= length(~isnan(C))
%     result = 1;
%     
% else
%     if nansum(C)<length(~isnan(C))
%         result = 0;
%     end
% end


end