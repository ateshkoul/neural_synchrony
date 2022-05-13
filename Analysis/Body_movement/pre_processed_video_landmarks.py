# -*- coding: utf-8 -*-
"""
Created on Tue Dec 15 16:02:01 2020

@author: Atesh
"""

if __name__ == '__main__':

    import pandas as pd
    import os
    import pdb
    root_dir = 'D:\\iannettilab_dropbox\\Dropbox\\Koul_Atesh\\IBS\\'


    Sess_no = 1
    Dyads = [1]

    Dyads = range(1,24)
    Subs = [0,1]
    landmark = 'body'
    
    
    pose_landmarks = ["Nose","Neck","RShoulder","RElbow","RWrist","LShoulder","LElbow",
                          "LWrist","MidHip","RHip","RKnee","RAnkle","LHip","LKnee","LAnkle",
                          "REye","LEye","REar","LEar","LBigToe","LSmallToe","LHeel","RBigToe",
                          "RSmallToe", "RHeel"]
    

    pose_est_col_list = [landmark + '_x' for landmark in pose_landmarks] + [landmark + '_y' for landmark in pose_landmarks]
    # for body
    pose_est_col_list = pose_est_col_list + ['']+ ['']
    for Dyd_no in Dyads:
        print('Dyd_no '+ str(Dyd_no))
        Sub_dir = os.path.join(root_dir + 'Dyd_%.3d' % Dyd_no , 'Video\\Ses_%.3d' % Sess_no)
        data_landmarks_0 = pd.read_csv(Sub_dir + '\\results_' 'video_' +str(0)+ '_pose_'+landmark+ '.csv')
        data_landmarks_1 = pd.read_csv(Sub_dir + '\\results_' 'video_' +str(1)+ '_pose_'+landmark+ '.csv')

        data_landmarks_0.columns.values[1:89] = pose_est_col_list
        data_landmarks_1.columns.values[1:89] = pose_est_col_list
        
        data_landmarks_0 = data_landmarks_0.drop(data_landmarks_0.iloc[:, 85::89], axis = 1)
        data_landmarks_1 = data_landmarks_1.drop(data_landmarks_1.iloc[:, 85::89], axis = 1)

        data_landmarks_0.to_csv(Sub_dir + '\\results_' 'video_' +str(0)+ '_pose_'+landmark+ '_processed.csv')
        data_landmarks_1.to_csv(Sub_dir + '\\results_' 'video_' +str(1)+ '_pose_'+landmark+ '_processed.csv')
        
        
        
        
        
        
        
        
        
        