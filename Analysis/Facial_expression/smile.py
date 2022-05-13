# -*- coding: utf-8 -*-
"""
Created on Wed Mar 17 16:42:22 2021

# -*- coding: utf-8 -*-
@author: Atesh
env: pose_tag
"""
#from pupil_apriltags import Detector
import cv2
#import pandas as pd
import copy
#from skimage.draw import polygon
import os
import matplotlib.pyplot as plt
import pdb
import numpy as np
import time
import sys
from numpy.linalg import norm

sys.path.insert(0,"Y:\\Inter-brain synchrony\\Libraries")

from pytorch_openpose.poses.pose_label import pose_label

from pupil_lab_gaze_analyzer.utils.read_gaze_data import gaze_data_loader


if __name__ == '__main__':

    import pandas as pd

    root_dir = 'D:\\iannettilab_dropbox\\Dropbox\\Koul_Atesh\\IBS\\'

    Sess_no = 1

    Dyads = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23]

    Subs = [0,1]

    conditions = ['FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3']

    
    sub_cond_index = [str(Dyd_no) + '_' + str(sub_no) + '_' + cond for cond in conditions for sub_no in Subs for Dyd_no in Dyads]
    pose_est = pose_label('face','Y:\\Inter-brain synchrony\\Libraries\\pytorch_openpose\\model\\')
    detect_smile = smile_detect_pca('Y:\\Inter-brain synchrony\\Libraries\\pytorch_openpose\\smile_detection\\')
    plt.ion()
    smile_est_col_list = ['time_stamps_raw','time_stamps_rel','frame_no','smile', 'smile_pca','mouth_size','mouth_size_inner','mouth_size_x','mouth_size_y','mouth_size_inner_x','mouth_size_inner_y']
    for Dyd_no in Dyads:

        for Sub_no in Subs:

            start_time = time.time()
            
            for condition in conditions:
                print('Dyd_no '+ str(Dyd_no) + ' Sub_no ' + str(Sub_no)+ ' condition ' + condition)
                data_dir = root_dir + 'Dyd_%.3d' % Dyd_no + '\\Eye_tracker\\pupil_' + str(Sub_no) + '\\' + condition + '\\' + 'Sub_' + str(Sub_no) + '\\000\\exports\\000'

                
                videofilename = os.path.join(data_dir,'..\\..\\world.mp4')

                video = cv2.VideoCapture(videofilename)
                nFrames = video.get(cv2.CAP_PROP_FRAME_COUNT)
                frame_width = video.get(3)
                frame_height = video.get(4)
                
                total_frames = np.int(nFrames)
                frames_to_skip = 0            
                export = pd.read_csv(data_dir + '\\export_info.csv')
                export_start = float(export.value[6].split('-')[0])
                
                ts_file = os.path.join(data_dir,'..\\..\\world_timestamps.npy')
                data_ts = np.load(ts_file)
                data_ts_first = export_start #data_ts[0]
                
                auto_smile_analysis_cond = pd.DataFrame(columns=smile_est_col_list)
                for frame_no in range(0,total_frames):

                    cur_index = str(Dyd_no)+ '_' + str(Sub_no) + '_' + condition + '_' +str(frame_no)
                    auto_smile_analysis_cond.loc[cur_index,'smile'] = np.nan
                    auto_smile_analysis_cond.loc[cur_index,'smile_pca'] = np.nan
                    auto_smile_analysis_cond.loc[cur_index,'frame_no'] = frame_no+1 # +1 to match matlab
                    auto_smile_analysis_cond.loc[cur_index,['mouth_size','mouth_size_inner']] = np.nan,np.nan
                    auto_smile_analysis_cond.loc[cur_index,['mouth_size_x','mouth_size_y','mouth_size_inner_x','mouth_size_inner_y']] = np.nan,np.nan,np.nan,np.nan
                    auto_smile_analysis_cond.loc[cur_index,'Dyd_no'] = Dyd_no
                    auto_smile_analysis_cond.loc[cur_index,'Sub_no'] = Sub_no
                    auto_smile_analysis_cond.loc[cur_index,'Condition'] = condition.split('_')[0]
                    auto_smile_analysis_cond.loc[cur_index,'block_Condition'] = condition
                    
                    auto_smile_analysis_cond.loc[cur_index,'time_stamps_raw'] = data_ts[frame_no]
                    auto_smile_analysis_cond.loc[cur_index,'time_stamps_rel'] = data_ts[frame_no]-data_ts_first
                    ret,frame = video.read()
                    if ret:
                        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

                        
                        pred= pose_est.return_predictions(frame)
                        markers = np.transpose(pred.reshape(2,70))

                        if((markers !=0).all() and not(np.isnan(markers).all())): #if((markers[48:60] !=0).all()):

                            frame_face_ellipse = np.zeros(gray.shape) 
                            face_x_mean = np.mean(markers[markers[:,0] !=0,0])
                            face_y_mean = np.mean(markers[markers[:,1] !=0,1])
                            center = (np.int(face_x_mean),np.int(face_y_mean))
                            
                            face_x_min = np.min(markers[markers[:,0] !=0,0])
                            face_y_min = np.min(markers[markers[:,1] !=0,1])
                            
                            face_x_max = np.max(markers[markers[:,0] !=0,0])
                            face_y_max = np.max(markers[markers[:,1] !=0,1])
                            
                            axes = (np.int(np.abs(face_x_min-face_x_mean))*2,np.int(np.abs(face_y_min-face_y_mean))*2)
                            face_size_x = np.int(np.abs(face_x_min-face_x_mean))*2
                            angle = 0;arcStart = 0; arcEnd = 360;
                            delta = 1 # Angle between the subsequent polyline vertices. It defines the approximation accuracy.
                            
                            face_ellipse_pts	=	cv2.ellipse2Poly(center,axes,angle,arcStart,arcEnd,delta)
                            cv2.fillConvexPoly(frame_face_ellipse,face_ellipse_pts,1)                    
                            height = int(face_y_max - face_y_min)#*2
                            width = int(face_x_max-face_x_min)#*2
                            face_image_x = int(face_x_min)
                            face_image_y = int(face_y_min)
                            roi_face = gray[face_image_y:face_image_y+height, face_image_x:face_image_x+width]
                            
                            frame_mouth_ellipse = np.zeros(gray.shape) 
                            markers_mouth = markers[48:60,:] 
                            mouth_x_mean = np.mean(markers_mouth[markers_mouth[:,0] !=0,0])
                            mouth_y_mean = np.mean(markers_mouth[markers_mouth[:,1] !=0,1])
                            center_mouth = (np.int(mouth_x_mean),np.int(mouth_y_mean))
                            
                            mouth_x_min = np.min(markers_mouth[markers_mouth[:,0] !=0,0])
                            mouth_y_min = np.min(markers_mouth[markers_mouth[:,1] !=0,1])
                            
                            axes_mouth = (np.int(np.abs(mouth_x_min-mouth_x_mean))*2,np.int(np.abs(mouth_y_min-mouth_y_mean))*2)
                            angle = 0;arcStart = 0; arcEnd = 360;
                            delta = 1 # Angle between the subsequent polyline vertices. It defines the approximation accuracy.
                            
                            mouth_ellipse_pts	=	cv2.ellipse2Poly(center_mouth,axes_mouth,angle,arcStart,arcEnd,delta)
                            cv2.fillConvexPoly(frame_mouth_ellipse,mouth_ellipse_pts,1)                    
                            roi_mouth = gray*(frame_mouth_ellipse==1)
                            

                            mouth_size_x = np.abs(pred[48]-pred[54])
                            mouth_size_y = np.abs(pred[118]-pred[124])
                            mouth_size_inner_x = np.abs(pred[60]-pred[64])
                            mouth_size_inner_y = np.abs(pred[130]-pred[134])
                            # eucledian distance for size same as taking norm
                            mouth_size = np.sqrt(mouth_size_x ** 2 +mouth_size_y ** 2)
                            mouth_size_inner = np.sqrt(mouth_size_inner_x ** 2 + mouth_size_inner_y ** 2)
                            

                            smile = smile_cascade.detectMultiScale(roi_face,scaleFactor=1.5,minNeighbors=20)


                            try:
                                smile_pca = detect_smile.predict_image(roi_face)
                                if smile_pca != 0:
                                    auto_smile_analysis_cond.loc[cur_index,'smile_pca'] = 1
                                else :
                                    auto_smile_analysis_cond.loc[cur_index,'smile_pca'] = 0
                            except:
                                auto_smile_analysis_cond.loc[cur_index,'smile_pca'] = np.nan
                            


                            auto_smile_analysis_cond.loc[cur_index,['mouth_size','mouth_size_inner']] = mouth_size,mouth_size_inner
                            auto_smile_analysis_cond.loc[cur_index,['mouth_size_x','mouth_size_y','mouth_size_inner_x','mouth_size_inner_y']] = mouth_size_x,mouth_size_y,mouth_size_inner_x,mouth_size_inner_y
                    

                print("time spent is " + str(time.time()-start_time))    
                auto_smile_analysis_cond.to_csv(data_dir + '\\results_smile_detection_from_eye_tracker.csv')
