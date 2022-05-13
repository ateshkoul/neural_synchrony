function IBS_test_moving_correlation

x = 1:100;

S1 = repmat(sin(x),[10 10]);

S2 = repmat([cos(x) cos(x+190)],[10 5])
% S2 = repmat([cos(x)],[10 10]);

S1 = permute(S1,[3 1 2]);
S2 = permute(S2,[3 1 2]);
moving_correlation = IBS_moving_correlation(S1,S2,1:10,100);
plot(1:1000,squeeze(moving_correlation(1,:,1)))
% the initial bumps are because of the padding at the begining and end

a = [nan(10,10);1:10];
b = [nan(10,10);1:10];

nancorrmat(a,b)

% doesn't work here:
a = [nan(10,10) transpose(1:10)];
b = [nan(10,10) transpose(1:10)];
nancorrmat(a,b)


end