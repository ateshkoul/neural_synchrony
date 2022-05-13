



label_types  = {'Laugh','Talk','Mov_head',...
    'Mov_trunk','Mov_arms','Mov_legs',...
    'Eye_close','Com',...
    'Caressing_Task','Smile','Yawning',...
    'Eyebrows','Hands_Feet','Deep_breath',...
    'Mov_mouth','NRelaxed'};


Dyads = [1:23];
Sub_no = 1;
conditions = {'FaNoOcc_1','NeNoOcc_1','FaNoOcc_2','NeNoOcc_2','FaNoOcc_3','NeNoOcc_3'};
for Dyd_no = 1:length(Dyads)
    for cond_no = 1:length(conditions)
        s = IBS_load_video_manual_labelled(Dyads(Dyd_no),Sub_no,conditions{cond_no},label_types);
        s2 = IBS_load_video_manual_labelled(Dyads(Dyd_no),2,conditions{cond_no},label_types);
        
        n = table2array(s).*(repmat(1:size(s,2),size(s,1),1));
        imagesc(1:size(s,1),[-0.035 -0.045],sum(n(:,2:end),2)')
        figure
        n2 = table2array(s2).*(repmat(1:size(s2,2),size(s2,1),1));
        imagesc(1:size(s2,1),[-0.035 -0.045],sum(n2(:,2:end),2)')
        
        % k = input('go ahead');
        close all
    end
end

%%

label_types  = {'Laugh','Talk','Mov_head',...
    'Mov_trunk','Mov_arms','Mov_legs',...
    'Eye_close','Com',...
    'Caressing_Task','Smile','Yawning',...
    'Eyebrows','Hands_Feet','Deep_breath',...
    'Mov_mouth','NRelaxed'};


Dyads = [1:23];
Sub_no = 1;
conditions = {'FaNoOcc_1','NeNoOcc_1','FaNoOcc_2','NeNoOcc_2','FaNoOcc_3','NeNoOcc_3'};
for Dyd_no =1:length(Dyads)
    for cond_no = 1:length(conditions)
        s = IBS_load_video_manual_labelled(Dyads(Dyd_no),Sub_no,conditions{cond_no},label_types);
        s2 = IBS_load_video_manual_labelled(Dyads(Dyd_no),2,conditions{cond_no},label_types);
        
        n = table2array(s).*(repmat(1:size(s,2),size(s,1),1));
        imagesc(1:size(s,1),[-0.035 -0.045],sum(n(:,2:end),2)')
        figure
        n2 = table2array(s2).*(repmat(1:size(s2,2),size(s2,1),1));
        imagesc(1:size(s2,1),[-0.035 -0.045],sum(n2(:,2:end),2)')
        
        % k = input('go ahead');
        close all
    end
end

