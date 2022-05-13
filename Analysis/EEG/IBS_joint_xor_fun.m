function result = IBS_joint_xor_fun(data_1,data_2)
%% Atesh Koul
% 03-03-2021
% C = or(data_1,data_2);

C = xor(data_1,data_2);

result = any(C>0);

end