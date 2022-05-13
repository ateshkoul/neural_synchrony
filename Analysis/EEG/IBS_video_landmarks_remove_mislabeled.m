function cur_data_numeric = IBS_video_landmarks_remove_mislabeled(cur_data_numeric)
%% Atesh
% 21-01-2021


%% remove values that are wrongly placed in the image:
% if head markers are below or feet are above
% this is valid for all subject types: head are above and feet below

x_indicies = contains(cur_data_numeric.Properties.VariableNames,'_x');
y_indicies = contains(cur_data_numeric.Properties.VariableNames,'_y');

%    cur_data_numeric.Properties.VariableNames(y_indicies)

landmarks_up_below = [1,1,1,0,0,1,0,0,0,0,0,2,0,0,2,1,1,1,1,2,2,2,2,2,2]; % 0= middle, 1 = up; 2 = down
% for the landmarks restrict the variability that they can have
allowed_variability_mid_px = 50;
allowed_variability_up_px = 100;
allowed_variability_down_px = 250;


y_landmarks = cur_data_numeric(:,y_indicies);

for y_landmark_no = 1:sum(y_indicies)
    
    cur_y_landmark = y_landmarks(:,y_landmark_no);
    
    if landmarks_up_below(y_landmark_no) ==1
        if range(table2array(cur_y_landmark)) > allowed_variability_up_px
            cur_y_landmark = array2table(NaN([size(cur_y_landmark,1) 1]));
        end
        cur_y_landmark(table2array(cur_y_landmark)>(1250/2),:) = array2table(NaN([sum(table2array(cur_y_landmark)>(1250/2)) 1]));
        
    end
    
    if landmarks_up_below(y_landmark_no) ==2
        if range(table2array(cur_y_landmark)) > allowed_variability_down_px
            cur_y_landmark = array2table(NaN([size(cur_y_landmark,1) 1]));
        end
        cur_y_landmark(table2array(cur_y_landmark)<(1250/2),:) = array2table(NaN([sum(table2array(cur_y_landmark)<(1250/2)) 1]));
    end
    
    if landmarks_up_below(y_landmark_no) ==0
        if range(table2array(cur_y_landmark)) > allowed_variability_mid_px
            cur_y_landmark = array2table(NaN([size(cur_y_landmark,1) 1]));
        end
    end
    
    y_landmarks(:,y_landmark_no) = cur_y_landmark;
end

cur_data_numeric(:,y_indicies) = y_landmarks;




x_landmarks = cur_data_numeric(:,x_indicies);

for x_landmark_no = 1:sum(x_indicies)
    
    cur_x_landmark = x_landmarks(:,x_landmark_no);
    
    if landmarks_up_below(x_landmark_no) ==1
        if range(table2array(cur_x_landmark)) > allowed_variability_up_px
            cur_x_landmark = array2table(NaN([size(cur_x_landmark,1) 1]));
        end
%         cur_x_landmark(table2array(cur_x_landmark)>(1250/2),:) = array2table(NaN([sum(table2array(cur_x_landmark)>(1250/2)) 1]));
        
    end
    
    if landmarks_up_below(x_landmark_no) ==2
        if range(table2array(cur_x_landmark)) > allowed_variability_down_px
            cur_x_landmark = array2table(NaN([size(cur_x_landmark,1) 1]));
        end
%         cur_x_landmark(table2array(cur_x_landmark)<(1250/2),:) = array2table(NaN([sum(table2array(cur_x_landmark)<(1250/2)) 1]));
    end
    
    if landmarks_up_below(x_landmark_no) ==0
        if range(table2array(cur_x_landmark)) > allowed_variability_mid_px
            cur_x_landmark = array2table(NaN([size(cur_x_landmark,1) 1]));
        end
    end
    
    x_landmarks(:,x_landmark_no) = cur_x_landmark;
end

cur_data_numeric(:,x_indicies) = x_landmarks;

% % % for plotting
% landmarks_up_below(landmarks_up_below==0) = 5;
%
% scatter(table2array(cur_data_numeric(1,x_indicies)),...
%     -table2array(cur_data_numeric(1,y_indicies)),landmarks_up_below.*10)
% axis([0 720 -1250 0])
% ax = gca;
% ax.XAxisLocation = 'top';


end