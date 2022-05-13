# -*- coding: utf-8 -*-
"""
Created on Thu Apr 15 16:04:11 2021

@author: Atesh
"""

# -*- coding: utf-8 -*-
"""
Spyder Editor

conda env: pose_detection
"""
# environment: pose_detection
import cv2
#import pandas as pd
import copy
from skimage.draw import polygon
import os
import matplotlib.pyplot as plt
import pdb
import numpy as np

import sys
import glob

sys.path.insert(0,"Y:\\Inter-brain synchrony\\Libraries")
from pupil_lab_gaze_analyzer.utils.read_gaze_data import gaze_data_loader
#from image_segmentation import image_segmentation

#from pytorch_openpose.poses.pose_label import pose_label


if __name__ == '__main__':
    # critical to keep this loading inside the main function otherwise it loads multiple processes
#    import modin.pandas as pd
    import pandas as pd

    root_dir = 'D:\\iannettilab_dropbox\\Dropbox\\Koul_Atesh\\IBS\\'
    Dyads = range(1,24)

    Subs = [0,1]

    conditions = ['FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3']

    for Dyd_no in Dyads:
        
        for Sub_no in Subs:
            for condition in conditions:

                                
                data_dir = root_dir + 'Dyd_%.3d' % Dyd_no + '\\Eye_tracker\\pupil_' + str(Sub_no) + '\\' + condition + '\\' + 'Sub_' + str(Sub_no) + '\\000\\exports\\000'

                print('Dyd_no '+ str(Dyd_no) + ' Sub_no ' + str(Sub_no)+ ' condition ' + condition)
                

                eye_data_loader = gaze_data_loader(data_dir)    
                eye_data_loader.get_clean_gaze_data()
                eye_data = eye_data_loader.eye_data
                first_timestamp = eye_data_loader.first_gaze_timestamp
                
                
                
                face_data = pd.read_csv(data_dir+ '\\results_ellipse_pose_est_face_api_full.csv')
                
                
                landmark_type = 'face'
                landmark_points = 70 # for body: 26; for face : 70
                
                pose_landmarks = ["RFace_0","RFace_1","RFace_2","RFace_3","RFace_4","RFace_5",
                          "RFace_6","RFace_7","MFace_8","LFace_9","LFace_10","LFace_11","LFace_12",
                          "LFace_13","LFace_14","LFace_15","LFace_16","RFace_17","RFace_18",
                          "RFace_19","RFace_20","RFace_21","LFace_22","LFace_23","LFace_24", 
                          "LFace_25","LFace_26","Nose_27","Nose_28","Nose_29","Nose_30",
                          "Nose_bot_31","Nose_bot_32","Nose_bot_33","Nose_bot_34", "Nose_bot_35",
                          "REye_36","REye_37","REye_38","REye_39","REye_40","REye_41","LEye_42",
                          "LEye_43","LEye_44","LEye_45","LEye_46","LEye_47","RMouth_out_48",
                          "RMouth_49","RMouth_50","MMouth_51","LMouth_52","LMouth_53","LMouth_54", 
                          "LMouth_55","LMouth_56","MMouth_57","RMouth_58","RMouth_59","RMouth_in_60",
                          "RMouth_in_61","MMouth_in_62","LMouth_in_63","LMouth_in_64","LMouth_in_65",
                          "MMouth_in_66","RMouth_in_67","REye_68","LEye_69"]
                
                Avg_Nose_x = np.mean(face_data[["Nose_27_x","Nose_28_x","Nose_29_x","Nose_30_x"]],1)
                Avg_Nose_y = np.mean(face_data[["Nose_27_y","Nose_28_y","Nose_29_y","Nose_30_y"]],1)

                pose_est_col_list = [landmark + '_x' for landmark in pose_landmarks] + [landmark + '_y' for landmark in pose_landmarks]
                

                
                videofilename = os.path.join(data_dir,'..\\..\\world.mp4')
                video = cv2.VideoCapture(videofilename)
                
                nFrames = video.get(cv2.CAP_PROP_FRAME_COUNT)
                frame_width = video.get(3)
                frame_height = video.get(4)
                
                confidence_thresh = 0.6
                selected_alpha = 0.5
                
                # important to have total_frames as int otherwise error as
                # can't make float no. of elements in np.empty
                total_frames = np.int(nFrames)
                frames_to_skip = 0 

                eye_gaze_distance = np.empty(total_frames-frames_to_skip)
                eye_gaze_distance_x  = np.empty(total_frames-frames_to_skip)
                eye_gaze_distance_y = np.empty(total_frames-frames_to_skip)
                
            
                valid_trials = np.empty(total_frames-frames_to_skip)
                
                
                
                analyzed_frame_no = np.empty(total_frames-frames_to_skip)
                time_stamps = np.empty(total_frames-frames_to_skip)
                data_ts_rel = np.empty(total_frames-frames_to_skip)
                
                frames_analysed = 0

                export = pd.read_csv(data_dir + '\\export_info.csv')
                export_start = float(export.value[6].split('-')[0])
                
                ts_file = os.path.join(data_dir,'..\\..\\world_timestamps.npy')
                data_ts = np.load(ts_file)
                data_ts_first = export_start #data_ts[0]
                
                
                for frame_no in range(0,total_frames-1):

                    x_pos_frame_conf_samples = eye_data.loc[eye_data['world_index']==frame_no,'norm_pos_x']
                    y_pos_frame_conf_samples = eye_data.loc[eye_data['world_index']==frame_no,'norm_pos_y']     
                    
                    
                    valid_trial =  (x_pos_frame_conf_samples.size >0) & (y_pos_frame_conf_samples.size >0)
                    (cur_eye_gaze_distance,cur_eye_gaze_distance_x,cur_eye_gaze_distance_y) = (np.nan,np.nan,np.nan)
                    if (valid_trial):
                        try:
                    
                            cur_eye_pos_x = np.mean(x_pos_frame_conf_samples*frame_width)

                            cur_eye_pos_y = frame_height-(np.mean(y_pos_frame_conf_samples)*frame_height)
                                                          
                            cur_eye_gaze_distance_x = np.abs(Avg_Nose_x[frame_no]-cur_eye_pos_x)
                            cur_eye_gaze_distance_y = np.abs(Avg_Nose_y[frame_no]-cur_eye_pos_y)

                            # eucledian distance for size same as taking norm
                            cur_eye_gaze_distance = np.sqrt(cur_eye_gaze_distance_x ** 2 +cur_eye_gaze_distance_y ** 2)
                

        
                        except:
                            print('issue in getting overlap for '+'Dyd_no '+ str(Dyd_no) + ' Sub_no ' + str(Sub_no)+ ' condition ' + condition)

                    time_stamps[frame_no] = np.mean(eye_data.loc[eye_data['world_index']==frame_no,'gaze_timestamp'])
        
                    eye_gaze_distance[frame_no] = cur_eye_gaze_distance
                    eye_gaze_distance_x[frame_no]  = cur_eye_gaze_distance_x
                    eye_gaze_distance_y[frame_no]  = cur_eye_gaze_distance_y

                    valid_trials[frame_no] = valid_trial
                    
                    data_ts_rel[frame_no] = data_ts[frame_no]-data_ts_first
                    
                    
                    analyzed_frame_no[frame_no] = frame_no
                    frames_analysed+= 1
                
                
                results_eye_gaze = pd.DataFrame({'analyzed_frame_no':analyzed_frame_no,
                                                 'time_stamps':time_stamps,
                                                 'valid_trials':valid_trials,
                                                 'eye_gaze_distance':eye_gaze_distance,
                                                 'eye_gaze_distance_x':eye_gaze_distance_x,
                                                 'eye_gaze_distance_y':eye_gaze_distance_y,
                                                 'data_ts':data_ts,
                                                 'data_ts_rel':data_ts_rel})
                results_eye_gaze.to_csv(data_dir + '\\'+'results_ellipse_eye_gaze_api_full_gaze_nose_distance.csv')
    
    