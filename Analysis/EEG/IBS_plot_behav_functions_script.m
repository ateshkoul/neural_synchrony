for row = 1:size(X,2)
    
    
   Z(row,:) = IBS_compute_vector_angle(X(row,:)',Y(:,row)); 
end


arrayfun(@(x,y) IBS_compute_vector_angle(x,y),X,Y)


V1 = [-1 0 1 1 1 0 -1 -1 -1];
V2 = [-1 -1 -1 0 1 1 1 0 -1];

angle = IBS_compute_2d_angle(V1,V2)
angle = IBS_compute_2d_angle(V2,V1)

figure;polarplot(deg2rad(angle),IBS_compute_vector_angle(V1,V2))
figure;polarplot(deg2rad(angle),IBS_compute_behav_vector_angle(V1,V2))

figure;polarplot(deg2rad(angle),IBS_compute_behav_vector_angle_neg(V1,V2))
figure;polarplot(deg2rad(angle),IBS_compute_vector_angle_anti(V1,V2))
figure;polarplot(deg2rad(angle),IBS_compute_vector_angle_ind(V1,V2))
figure;polarplot(deg2rad(angle),IBS_compute_vector_angle_xor(V1,V2))



