function vec_angle = IBS_compute_behav_vector_angle(V1,V2)

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




vec_angle = atan2d(V2,V1) ;
% convert from [-180 180] to [0 360] range
vec_angle(vec_angle<0) = vec_angle(vec_angle<0) + 360;

vec_angle = vec_angle+135;
vec_angle(vec_angle>=360) = vec_angle(vec_angle>=360)-360;

vec_angle(vec_angle>180) = 360-vec_angle(vec_angle>180);
vec_angle = vec_angle./180;



end


% vec_angle = acosd(dot(V1,V2)/(norm(V1)*norm(V2)));

% vec_angle = atand((V2-1:length(V2))./ (V1 - 1:length(V1)));
% -45 is the angle from the unity line so +45 helps to get the angle from
% the line 90 degrees more

% adding a constant doesn't really change a lot as i normalize the values
% later on - so only the shape is conserved
% a in atand is for the inverse of tangent- this gives the degree angle

