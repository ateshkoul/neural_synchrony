# -*- coding: utf-8 -*-
"""
Created on Fri Aug 14 12:44:12 2020

@author: Atesh
env: pose_detection
"""

import cv2
#import pandas as pd
import copy
from skimage.draw import polygon
import os
import matplotlib.pyplot as plt
import pdb
import numpy as np
import time
import sys

sys.path.insert(0,"Y:\\Inter-brain synchrony\\Libraries")

from pytorch_openpose.poses.pose_label import pose_label


if __name__ == '__main__':
    # critical to keep this loading inside the main function otherwise it loads multiple processes
#    import modin.pandas as pd
    import pandas as pd

    root_dir = 'D:\\iannettilab_dropbox\\Dropbox\\Koul_Atesh\\IBS\\'

    Sess_no = 1


    Dyads = [1,2,3,4,5,6,7,8,9,10,11,13,14,15,16,17,18,20,21,22,23]


    Subs = [0,1]
    


    conditions = ['FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3']

    landmark_types = ['body']

    
    pose_landmark_list = [["Nose","Neck","RShoulder","RElbow","RWrist","LShoulder","LElbow",
                          "LWrist","MidHip","RHip","RKnee","RAnkle","LHip","LKnee","LAnkle",
                          "REye","LEye","REar","LEar","LBigToe","LSmallToe","LHeel","RBigToe",
                          "RSmallToe", "RHeel","Background"]]
    

    
    sub_cond_index = [str(Dyd_no) + '_' + str(sub_no) + '_' + cond for cond in conditions for sub_no in Subs for Dyd_no in Dyads]
    
    
    for landmark_no,landmark_type in enumerate(landmark_types):
        
        pose_landmarks = pose_landmark_list[landmark_no]
        landmark_points = len(pose_landmarks) 

        
        pose_est_col_list = [landmark + '_x' for landmark in pose_landmarks] + [landmark + '_y' for landmark in pose_landmarks]

        pose_est = pose_label(landmark_type,'Y:\\Inter-brain synchrony\\Libraries\\pytorch_openpose\\model\\')



        for Dyd_no in Dyads:
            Sub_dir = os.path.join(root_dir + 'Dyd_%.3d' % Dyd_no , 'Video\\Ses_%.3d' % Sess_no)
            for Sub_no in Subs:
                auto_video_analysis = pd.DataFrame(columns=pose_est_col_list)

                start_time = time.time()
                for condition in conditions:
                    print('Dyd_no '+ str(Dyd_no) + ' Sub_no ' + str(Sub_no)+ ' condition ' + condition)
                    videofilename =  os.path.join(Sub_dir, 'Video_' +str(Sub_no)+ '_' + condition + '.avi')
                    video = cv2.VideoCapture(videofilename)
                    nFrames = video.get(cv2.CAP_PROP_FRAME_COUNT)
                    frame_width = video.get(3)
                    frame_height = video.get(4)
                    
                    total_frames = np.int(nFrames)
                    frames_to_skip = 0

                    for frame_no in range(0,total_frames):

                
                        ret,frame = video.read()
                        
                        if ret:

                            if ((Dyd_no < 12) & (Sub_no == 1)):
                                frame = cv2.rotate(frame, cv2.ROTATE_90_COUNTERCLOCKWISE)
                            elif ((Dyd_no < 12) & (Sub_no == 0)):
                                frame = cv2.rotate(frame, cv2.ROTATE_90_CLOCKWISE)   
                            elif ((Dyd_no >= 12) & (Sub_no == 1)):
                                frame = cv2.rotate(frame, cv2.ROTATE_90_CLOCKWISE)
                            elif ((Dyd_no >= 12) & (Sub_no == 0)):
                                frame = cv2.rotate(frame, cv2.ROTATE_90_COUNTERCLOCKWISE)
                                                           

                            cur_index = str(Dyd_no)+ '_' + str(Sub_no) + '_' + condition + '_' +str(frame_no)
                            pred = pose_est.return_predictions(frame)

                            auto_video_analysis.loc[cur_index,pose_est_col_list[0:len(pred)]] = pred
                            
                            auto_video_analysis.loc[cur_index,'Dyd_no'] = Dyd_no
                            auto_video_analysis.loc[cur_index,'Sub_no'] = Sub_no
                            auto_video_analysis.loc[cur_index,'Condition'] = condition.split('_')[0]
                            auto_video_analysis.loc[cur_index,'Condition_block'] = condition

                print("time spent is " + str(time.time()-start_time))    
                auto_video_analysis.to_csv(Sub_dir + '\\results_' 'video_' +str(Sub_no)+ '_pose_'+landmark_type+ '.csv')