% V1 = [linspace(-1,1,100) linspace(1,-1,100)];
% V2 = [linspace(-1,1,25) linspace(1,-1,25) linspace(-1,1,25) linspace(1,-1,25) ...
%     linspace(-1,1,25) linspace(1,-1,25) linspace(-1,1,25) linspace(1,-1,25)];


V1 = [linspace(-1,0,25) linspace(0,1,25) linspace(0,1,25) linspace(0,-1,25)];

V2 = [linspace(-1,0,25) linspace(0,-1,25) linspace(0,1,25) linspace(1,0,25)];
figure
vec_angle = [];
angle = [];
for i = 1:100
    
    angle(i,:) = IBS_compute_2d_angle(V1,V2);
% vec_angle(i,:) = IBS_compute_behav_vector_angle(V1,V2);
vec_angle(i,:) = IBS_compute_vector_angle(V1,V2);
% vec_angle(i,:) = IBS_compute_behav_vector_angle_neg(V1,V2);
% vec_angle(i,:) = IBS_compute_vector_angle_anti(V1,V2);
% vec_angle(i,:) = IBS_compute_vector_angle_ind(V1,V2);

V2 = circshift(V2,1);
% polarplot(deg2rad(vec_angle(i,:).*180),repmat(1,1,100))
% polarplot(deg2rad(vec_angle(i,:)),repmat(1,1,100))
polarplot(deg2rad(angle(i,:)),vec_angle(i,:))
% plot(V2)
hold on
end
% polarhistogram(deg2rad(vec_angle(:).*45))