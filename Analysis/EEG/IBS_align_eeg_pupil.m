

raw_data_dir = 'D:\\iannettilab_dropbox\\Dropbox\\Koul_Atesh\\IBS\\';
raw_save_folder = 'E:\\Davide_shared\\IBS\\';
Dyads =1 ;
Subs = [0 1];
% condition = 'NeNoOcc_1';

conditions = {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'};



mapObj = containers.Map(conditions,...
    {'31',  '32',  '33','51',  '52',  '53'});
delays_S1 = nan(1,length(Dyads));
delays_S2 = nan(1,length(Dyads));


for Dyad_no = 1:length(Dyads)
    load([sprintf('E:\\Projects\\IBS\\Data\\Processed\\aggressive_trialwise_CAR\\Aggressive_ICA\\Dyd_%0.2d',Dyads(Dyad_no)) '_ICA_blocks_only_neck_artefact_clean_bp_03_95_120s.mat']);
    comp_S1 = data_ica_clean_S1{1, 1}.comp;
    comp_S2 = data_ica_clean_S2{1, 1}.comp;
    [ ~, ~ ] = Giac_EEGplotNanTrials( comp_S1, {'all'}, [], 'IBS_S1_layout_64',  'NoReject' );
        uiwait(msgbox('Press OK when you decided that some (new) components have to be removed ...', 'Rejection?'));

    Cmp_eye_blink_S1       = listdlg('PromptString','Choose bad components:','SelectionMode','multiple','ListString',comp_S1.label);
    close all
    [ ~, ~ ] = Giac_EEGplotNanTrials( comp_S2 , {'all'}, [], 'IBS_S2_layout_64',  'NoReject' );
        uiwait(msgbox('Press OK when you decided that some (new) components have to be removed ...', 'Rejection?'));

    Cmp_eye_blink_S2       = listdlg('PromptString','Choose bad components:','SelectionMode','multiple','ListString',comp_S2.label);
    
    close all
    
    
    cfg_select.latency = [0 120];comp_S1 = ft_selectdata(cfg_select,comp_S1);
    cfg_select.latency = [0 120];comp_S2 = ft_selectdata(cfg_select,comp_S2);
    
    %     comp_S1 = IBS_resampledata(comp_S1,10);
    %     comp_S1 = IBS_resampledata(comp_S1,10);
    for condition_no = 1:numel(conditions)
        outlier_value= 2.5;
        end_loop = 1;
        while end_loop
        
        blinks_S1 = IBS_get_sub_behavior_data('Eye_tracker_blink',Dyads(Dyad_no),0,conditions{condition_no},raw_data_dir);
        
        blinks_S2 = IBS_get_sub_behavior_data('Eye_tracker_blink',Dyads(Dyad_no),1,conditions{condition_no},raw_data_dir);
        
        
        %% select blinks
        
%         [s,durs_S1] = hist(blinks_S1.duration);
%         [s,durs_S2] = hist(blinks_S2.duration);
%         
%         blinks_S1 = blinks_S1(blinks_S1.duration<durs_S1(3),:);
%         blinks_S2 = blinks_S2(blinks_S2.duration<durs_S2(3),:);
%         
%         
        % blinks.start_timestamp = round(blinks.start_timestamp - 31737.715057,2);
        % 122 is because in case there are more timestamps
        all_timepoints = round([0:0.01:122],2);
        s_start_S1 = sum(all_timepoints == blinks_S1.start_timestamp);
        
        % blinks.end_timestamp = round(blinks.end_timestamp - 31737.715057,2);
        all_timepoints = round([0:0.01:122],2);
        s_end_S1 = sum(all_timepoints == blinks_S1.end_timestamp);        

        %% S2
        % blinks.start_timestamp = round(blinks.start_timestamp - 31737.715057,2);
        all_timepoints = round([0:0.01:122],2);
        s_start_S2 = sum(all_timepoints == blinks_S2.start_timestamp);
        
        % blinks.end_timestamp = round(blinks.end_timestamp - 31737.715057,2);
        all_timepoints = round([0:0.01:122],2);
        s_end_S2 = sum(all_timepoints == blinks_S2.end_timestamp);    
       
        %% EEG
        trial_no = find(ismember(comp_S1.trialinfo,str2num(mapObj(conditions{condition_no}))));
        trial_no = find(ismember(comp_S2.trialinfo,str2num(mapObj(conditions{condition_no}))));
        
        blink_data_S1_ori = comp_S1.trial{1,trial_no}( Cmp_eye_blink_S1,:);
        blink_data_S2_ori = comp_S2.trial{1,trial_no}( Cmp_eye_blink_S2,:);
        
        %         [blink_data_S1] =  ft_preproc_bandpassfilter(blink_data_S1,comp_S1.fsample,[2],4);
        %         [blink_data_S2] =  ft_preproc_bandpassfilter(blink_data_S2,comp_S1.fsample,[ 1 5],2);
        
        %%
        blink_data_S1 = blink_data_S1_ori;
        blink_data_S2 = blink_data_S2_ori;       
       
       
        outlier_S1 = mean(blink_data_S1)+outlier_value*std(blink_data_S1);
        outlier_S2 = mean(blink_data_S2)+outlier_value*std(blink_data_S2);       


        
        blink_data_S1(abs(blink_data_S1)<outlier_S1) = 0;
        blink_data_S2(abs(blink_data_S2)<outlier_S2) = 0;
        
                blink_data_S1(abs(blink_data_S1)>outlier_S1) = 1;

%         figure
%         plot(comp_S1.time{1,1}(2:end),blink_data_S1_diff*500)
% 
% %         plot(comp_S1.time{1,1}(2:end),blink_data_S1(2:end)*500)
%         hold on
%         plot(comp_S1.time{1,1}(2:end),-blink_data_S1_ori(2:end))
%         
% %         blink_data_S1 = normalize(blink_data_S1_ori,'zscore');
% %         blink_data_S2 = normalize(blink_data_S2_ori,'zscore');
% %         
% %         blink_data_S1(abs(blink_data_S1)<1) = 0;
% %         blink_data_S2(abs(blink_data_S2)<3) = 0;
% %         
%         %         blink_data_S1(abs(blink_data_S1)>outlier_S1) = 1;
%         %         blink_data_S2(abs(blink_data_S2)>outlier_S2) = 1;
%         
% %         blink_data_S1_diff = diff(blink_data_S1);
% %         blink_data_S2_diff = diff(blink_data_S2);
%         
% outlier_S1 = mean(blink_data_S1_diff)+outlier_value*std(blink_data_S1_diff)



        
        blink_data_S1_diff = diff(abs(blink_data_S1));
        blink_data_S2_diff = diff(abs(blink_data_S2));
        
%         
        blink_data_S1_diff(abs(blink_data_S1_diff)<outlier_S1) = 0;
        blink_data_S2_diff(abs(blink_data_S2_diff)<outlier_S2) = 0;
        
        blink_data_S1_diff_time = comp_S1.time{1,1}(2:end);
        
        %         > 0 works if u do abs because diff captures the rise of the eye
        %         blink
        blink_data_S1_diff_time = blink_data_S1_diff_time(find(blink_data_S1_diff>0));
        
        
        blink_data_S2_diff_time = comp_S2.time{1,1}(2:end);
        
        blink_data_S2_diff_time = blink_data_S2_diff_time(find(blink_data_S2_diff>0));
        
        
        k_S1_time = all_timepoints(find(s_start_S1));
%         k_S1_time = all_timepoints(find(all_S1));

        k_S2_time = all_timepoints(find(s_start_S2));
%         k_S2_time = all_timepoints(find(all_S2));

%%
        blink_delay = -0.2;
       k_S1_time_end = all_timepoints(find(s_end_S1)) + blink_delay;
%         k_S1_time = all_timepoints(find(all_S1));

        k_S2_time_end = all_timepoints(find(s_end_S2))+ blink_delay;
     k_S1_time = sort([k_S1_time,k_S1_time_end]);
     k_S2_time = sort([k_S2_time,k_S2_time_end]);

%%
        lag_S1 = [];
        
        for k1_S1_timepoints = 1:length(k_S1_time)
            
            lag_S1(:,k1_S1_timepoints) = blink_data_S1_diff_time - k_S1_time(k1_S1_timepoints);
            
        end
        
        
        lag_S2 = [];
        
        for k1_S2_timepoints = 1:length(k_S2_time)
            
            lag_S2(:,k1_S2_timepoints) = blink_data_S2_diff_time - k_S2_time(k1_S2_timepoints);
            
        end
        

        
        %% figure out sign of lag
        
        
        %%  
        delay_S1 = median(min(abs(lag_S1)));
        delay_S2 = median(min(abs(lag_S2)));
        
%         [value_S1,loc] = min(abs(lag_S1));
%          loc_sign_S1 = arrayfun(@(x,y) sign(lag_S1(x,y)),loc,1:size(lag_S1,2));
% 
%         for lag_no = 1:length(value_S1)
%             cur_value_S1 = loc_sign_S1(lag_no).*value_S1(lag_no);
%             cur_delay(lag_no) = blink_data_S1_diff_time - (all_timepoints(find(all_S1)) + cur_value_S1);
%             
%         end
        %%
        [value,loc] = min(abs(lag_S1));
        loc_sign_S1 = arrayfun(@(x,y) sign(lag_S1(x,y)),loc,1:size(lag_S1,2));
        if sum(loc_sign_S1)<0

            delay_S1 = -delay_S1;
        end
        
        [value,loc] = min(abs(lag_S2));
        loc_sign_S2 = arrayfun(@(x,y) sign(lag_S2(x,y)),loc,1:size(lag_S2,2));
        if sum(loc_sign_S2)<0
            delay_S2 = -delay_S2;
        end               
        %%
        
        figure('units','normalized','outerposition',[0 0 1 1])
        %         plot(comp_S1.time{1,1}(2:end),blink_data_S1_diff)
        plot(comp_S1.time{1,1}(2:end),blink_data_S1(2:end))
        hold on
%         plot(comp_S1.time{1,1}(2:end),blink_data_S1_ori(2:end),'k')
        
        %         plot(comp_S1.time{1,1}(2:end),blink_data_S1(2:end))
%         plot(all_timepoints+delay_S1,k_S1*500,'r')
%         plot(all_timepoints+delay_S1,all_S1*500,'r')
        plot(all_timepoints+delay_S1,s_start_S1*500,'r')
        %         plot(all_timepoints,k_S1*500,'r')
%         pause(2)
        figure('units','normalized','outerposition',[0 0 1 1])
        
        plot(comp_S2.time{1,1}(2:end),blink_data_S2_diff)
        
        %         plot(comp_S2.time{1,1}(2:end),blink_data_S2(2:end))
%                 plot(comp_S2.time{1,1}(2:end),blink_data_S2_ori(2:end),'k')

        hold on
        
%         plot(all_timepoints+delay_S2,k_S2*500,'r')
        plot(all_timepoints+delay_S2,s_start_S2*500,'r')
        %         plot(all_timepoints-delay_S2,k_S2*500,'r')
        
        %         plot(all_timepoints,k_S2*500,'r')
%          pause(2)
        outlier_value = input('continue or retry','s');
        
        if strcmp(outlier_value,'y')
            end_loop = 0;
        else
            outlier_value = str2num(outlier_value);
        end
        end
        close all
        delays_S1(Dyads(Dyad_no),condition_no) = delay_S1;
        delays_S2(Dyads(Dyad_no),condition_no) = delay_S2;
        
    end
end


% for points = 1:5
%         [x1 y1] = ginput(1);
%         [x2 y2] = ginput(1);
%         lag_s1(points) = x1-x2;
%         end
%
%
%         for points = 1:5
%         [x1 y1] = ginput(1);
%         [x2 y2] = ginput(1);
%         lag_s2(points) = x1-x2;
%         end

%         k_S1 = zeros(1,length(all_timepoints));
%         start_indices_S1 = find(s_start_S1);
%         end_indices_S1 = find(s_end_S1);
%         for blink_no = 1:sum(s_start_S1)
%             
%             k_S1(start_indices_S1(blink_no):end_indices_S1(blink_no)) = 1;
%             
%         end

    
%         k_S2 = zeros(1,length(all_timepoints));
%         start_indices_S2 = find(s_start_S2);
%         end_indices_S2 = find(s_end_S2);
%         for blink_no = 1:sum(s_start_S2)
%             
%             k_S2(start_indices_S2(blink_no):end_indices_S2(blink_no)) = 1;
%             
%         end
%         all_S1 = s_start_S1 + s_end_S1;
%         all_S2 = s_start_S2 + s_end_S2;