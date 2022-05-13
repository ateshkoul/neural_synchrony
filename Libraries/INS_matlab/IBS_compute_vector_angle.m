function vec_angle = IBS_compute_vector_angle(V1,V2)

%%
% 
% Overall i think the current implementation is ok. this is because it represents 
% how far the data is from anticorrelation 
% as a magnitude of the angle. the lower values represent close to anticorrelation and 
% higher values represent good correlation. 
%  
%  the choice of 180-angle if angle is >90 is also ok both for the positive and negative values. 
% as more you deviate from 90 degree angle (after adding 45 degrees) the lesser the correlation is
% and goes towards anticorrelation. 
%  
%  if either of the two subjects has a negative value (meaning going below the average values), 
% this would be reflected in negative values for the correlation. however, if both of them have negative values, 
% this would result in a positive value.
%  
%  
%  The only thing I might change here would be the smoothing that averages the instantaneous nature of the data. 

% based on the bats paper - normalize to unit length
V1 = V1 - nanmean(V1);
V2 = V2 - nanmean(V2);


V1 = normalize(V1,'norm');
V2 = normalize(V2,'norm');

% V1 = normalize(V1,'range');
% V2 = normalize(V2,'range');

% vec_angle = acosd(dot(V1,V2)/(norm(V1)*norm(V2)));

% vec_angle = atand((V2-1:length(V2))./ (V1 - 1:length(V1)));
% -45 is the angle from the unity line so +45 helps to get the angle from
% the line 90 degrees more

% adding a constant doesn't really change a lot as i normalize the values
% later on - so only the shape is conserved
% a in atand is for the inverse of tangent- this gives the degree angle
vec_angle = atand(V2./V1) +45;
% vec_angle = atand(V2./V1);

% I don't like this because we are going against the negative values of the
% normalization as if it didn't mean anything 
% vec_angle = atand(abs(V2./V1))+45;% abs restrains the angle between 0-90 where 0 is close to anticorrelation and 90 is correlation

% it is important to have this transform because the more the angle
% deviates from 90, the less the values are correlated. If this the
% transform isn't done, it would suggest higher values for uncorrelated
% data
vec_angle(vec_angle>90) = 180-vec_angle(vec_angle>90);



% already normalize it here: the range is [0 90] degrees
% vec_angle = vec_angle./90;

% 31-08-2021
% After a huge amount of verifying, I came to the conclusion that it
% probably makes sense to take the absolute here. This is because it
% simplifies a lot of things. Earlier, the correlations went from -0.5 (no
% correlation) to 0 (anti-correlation) to 0.5 (again no correlation) to 1
% (perfect correlation) to 0.5 (no correlation). this is also due to atand
% that goes in the range -90 to 90. 
% The other way would be to say that when the angle is negative, and more
% than -45, subtract 45 from it and make it positive?

% making the values absolute also resolves the issue of interchangebility
% which is not the case if u don't take abs.
% the absolute makes sense because you are looking at the smaller of the
% angle from the -45 degree line. it doesn't matter if it is more to the
% left (-90) or not. this manipulation changes the range of the output
% values as 0 (anti-correlation) to 0.5 (no correlation) to 1 (perfect
% correlation). 
% vec_angle = abs(vec_angle./90);
% -0.5 so that we change to -0.5 (anti-correlation) to 0 (no correlation) 
% to 0.5 (perfect correlation). 

% vec_angle =  vec_angle./90;
vec_angle = abs(vec_angle./90);

% figure;
% plot(V1);hold on;plot(V2);plot(vec_angle1)
% plot(vec_angle2)

% anything that is less than 0.5 is negative correlation - participants
% doing opposite things
end




