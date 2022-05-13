function vec_angle = IBS_compute_2d_angle(V1,V2)


% V1 = V1 - nanmean(V1);
% V2 = V2 - nanmean(V2);
% 
% 
% V1 = normalize(V1,'norm');
% V2 = normalize(V2,'norm');

% V1 = normalize(V1,'range');
% V2 = normalize(V2,'range');

% vec_angle = acosd(dot(V1,V2)/(norm(V1)*norm(V2)));

% vec_angle = atand((V2-1:length(V2))./ (V1 - 1:length(V1)));
% -45 is the angle from the unity line so +45 helps to get the angle from
% the line 90 degrees more

% adding a constant doesn't really change a lot as i normalize the values
% later on - so only the shape is conserved
% a in atand is for the inverse of tangent- this gives the degree angle
vec_angle = atan2d(V2,V1);
vec_angle(vec_angle<0) = vec_angle(vec_angle<0) + 360;
end