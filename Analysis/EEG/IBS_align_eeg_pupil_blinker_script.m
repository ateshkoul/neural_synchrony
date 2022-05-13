
startup_IBS('blinker')
data_analysis_type = 'no_aggressive_trialwise_CAR';
thresh = [1 1.5 2 2.5 3 3.5 4];
analysis = 'Blink_detection';
Dyads = 1:23;

% all_conditions = {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'};
% conditions = {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'};

all_conditions =  {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3','Task_1','Task_2','Task_3'};
conditions = {'Task_1','Task_2','Task_3'};



condition_no = contains(all_conditions,conditions);
results_S1_F = cell(length(Dyads),length(condition_no));
results_S2_F = cell(length(Dyads),length(condition_no));
for thresh_no = 2:length(thresh)
    disp(['running ' num2str(thresh(thresh_no))])
%     rng(10)
    
    varargin_table = table();
    varargin_table.blink_EEG = table();
    varargin_table.blink_EEG.stdThreshold = thresh(thresh_no);

    
%     [results_S1_F,results_S2_F] = IBS_blink_load_delays(Dyad_no,condition_no,thresh,thresh_no);
    [results_S1,results_S2] = IBS_align_eeg_pupil_blinker(data_analysis_type,Dyads,conditions,varargin_table);
    results_S1_F(Dyads,condition_no) = results_S1(Dyads,condition_no);
    results_S2_F(Dyads,condition_no) = results_S2(Dyads,condition_no);
    clear results_S1 results_S2
    IBS_blink_save_delays(results_S1_F,results_S2_F,thresh,thresh_no,conditions,[],analysis)
end
%%
cellfun(@(x) x.delay_rms,results_S1_F([1:7 9:10],:),'UniformOutput',0)

cellfun(@(x) x.delay_rms,results_S2_F([2 4:7 9:10],:),'UniformOutput',0)

cellfun(@(x) x.deviance_delay_rms,results_S1_F([1:7 9:10],:),'UniformOutput',0)
cellfun(@(x) x.deviance_delay_rms,results_S2_F([2 4:7 9:10],:),'UniformOutput',0)

cellfun(@(x) x.loc_sign_frac,results_S2_F([2 4:7 9:10],:),'UniformOutput',0)

%%
thresh = [1 1.5 2 2.5 3 3.5 4];
Dyads_S1 = [1:23];
Dyads_S2 =[1:23];
for thresh_no = 1:length(thresh)

% load(['test\\test_all_sub_change_thresh_' num2str(thresh(thresh_no)) '.mat'],'results_S1_F','results_S2_F')
% load(['E:\Projects\IBS\Results\EEG\Blink_detection\no_aggressive_trialwise_CAR\delays_change_thresh_'  num2str(thresh(thresh_no)) '.mat'],'results_S1_F','results_S2_F');
load(['E:\Projects\IBS\Results\EEG\Blink_detection\no_aggressive_trialwise_CAR\delays_change_thresh_'  num2str(thresh(thresh_no)) '.mat'],'results_S1_F','results_S2_F');

results_S1_F = IBS_blink_subs_empty_delays(results_S1_F);
results_S2_F = IBS_blink_subs_empty_delays(results_S2_F);

S1_delays{thresh_no} = cell2mat(cellfun(@(x) x.delay_rms,results_S1_F(Dyads_S1,:),'UniformOutput',0));

S1_delays{thresh_no}(:,end+1) = Dyads_S1';

S1_delays{thresh_no}(:,end+1) = thresh(thresh_no);

S2_delays{thresh_no} = cell2mat(cellfun(@(x) x.delay_rms,results_S2_F(Dyads_S2,:),'UniformOutput',0));

S2_delays{thresh_no}(:,end+1) = Dyads_S2';
S2_delays{thresh_no}(:,end+1) = thresh(thresh_no);

end
%%

s1 = cat(3,S1_delays{:});
s2 = cat(3,S2_delays{:});




% min(abs(s1(:,1:6,:)),[],3)
% min(abs(s2(:,1:6,:)),[],3)


s1_min_loc = bsxfun(@eq, abs(s1),repmat(min(abs(s1),[],3),1,1,7));
s2_min_loc = bsxfun(@eq, abs(s2),repmat(min(abs(s2),[],3),1,1,7));


s1_min_value =  s1.*s1_min_loc;
s1_min_value(s1_min_value==0) = nan;


min(s1_min_value,[],3)

s2_min_value =  s2.*s2_min_loc;
s2_min_value(s2_min_value==0) = nan;


min(s2_min_value,[],3)
%%
thresh = [1 1.5 2 2.5 3 3.5 4];
Dyads_S1 = [1:23];
Dyads_S2 =[1:23];
%% for the task condition
all_conditions =  {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3','Task_1','Task_2','Task_3'};
conditions = {'Task_1','Task_2','Task_3'};


% untested for other conditions:
%conditions = {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'};


condition_no = contains(all_conditions,conditions);


%%
for thresh_no = 1:length(thresh)

% load(['test\\test_all_sub_change_thresh_' num2str(thresh(thresh_no)) '.mat'],'results_S1_F','results_S2_F')
% load(['E:\Projects\IBS\Results\EEG\Blink_detection\no_aggressive_trialwise_CAR\delays_change_thresh_'  num2str(thresh(thresh_no)) '.mat'],'results_S1_F','results_S2_F');
load(['E:\Projects\IBS\Results\EEG\Blink_detection\no_aggressive_trialwise_CAR\Task_delays_change_thresh_' num2str(thresh(thresh_no)) '.mat'])



results_S1_F = IBS_blink_subs_empty_delays(results_S1_F);
results_S2_F = IBS_blink_subs_empty_delays(results_S2_F);

S1_delays{thresh_no} = cell2mat(cellfun(@(x) x.delay_rms,results_S1_F(Dyads_S1,condition_no),'UniformOutput',0));

S1_delays{thresh_no}(:,end+1) = Dyads_S1';

S1_delays{thresh_no}(:,end+1) = thresh(thresh_no);
% this is the one that was used for all the conditions except task
% S2_delays{thresh_no} = cell2mat(cellfun(@(x) x.delay_rms,results_S2_F(Dyads_S2,:),'UniformOutput',0));
% this is used for task because for dyad 3, there are 2 delays
S2_delays{thresh_no} = cell2mat(cellfun(@(x) min(x.delay_rms),results_S2_F(Dyads_S2,condition_no),'UniformOutput',0));

S2_delays{thresh_no}(:,end+1) = Dyads_S2';
S2_delays{thresh_no}(:,end+1) = thresh(thresh_no);

% S1_delays_deviance{thresh_no} = cell2mat(cellfun(@(x) x.deviance_delay_rms,results_S1_F(Dyads_S1,:),'UniformOutput',0));
S1_delays_deviance{thresh_no} = cell2mat(cellfun(@(x) x.deviance_delay_rms,results_S1_F(Dyads_S1,condition_no),'UniformOutput',0));

S1_delays_deviance{thresh_no}(:,end+1) = Dyads_S1';

S1_delays_deviance{thresh_no}(:,end+1) = thresh(thresh_no);

% S2_delays_deviance{thresh_no} = cell2mat(cellfun(@(x) x.deviance_delay_rms,results_S2_F(Dyads_S2,:),'UniformOutput',0));
S2_delays_deviance{thresh_no} = cell2mat(cellfun(@(x) x.deviance_delay_rms,results_S2_F(Dyads_S2,condition_no),'UniformOutput',0));

S2_delays_deviance{thresh_no}(:,end+1) = Dyads_S2';
S2_delays_deviance{thresh_no}(:,end+1) = thresh(thresh_no);

end


%%
s1 = cat(3,S1_delays{:});
s2 = cat(3,S2_delays{:});

s1_deviance = cat(3,S1_delays_deviance{:});
s2_deviance = cat(3,S2_delays_deviance{:});


% 7 is the no. of thresholds
s1_dev_min_loc = bsxfun(@eq, abs(s1_deviance),repmat(min(abs(s1_deviance),[],3),1,1,7));
s2_dev_min_loc = bsxfun(@eq, abs(s2_deviance),repmat(min(abs(s2_deviance),[],3),1,1,7));


s1_min =  s1.*s1_dev_min_loc;
s1_min(s1_min==0) = nan;


S1_delay_min_dev = min(s1_min,[],3);

s2_min =  s2.*s2_dev_min_loc;
s2_min(s2_min==0) = nan;


S2_delay_min_dev =min(s2_min,[],3);
%% 
%p = s1_dev_min_loc;
% squeeze(p(8,:,:))

%%
s1_min_loc_thresh = nan(23,6);
s2_min_loc_thresh = nan(23,6);
for Dyad = 1:23
    for condition = 1:6
        s1_deviance_values = squeeze(s1_deviance(Dyad,condition,:));
        try
        s1_min_loc_thresh(Dyad,condition) = find(s1_deviance_values == min(s1_deviance_values));
        catch
            s1_min_loc_thresh(Dyad,condition) = nan;
        end
        s2_deviance_values = squeeze(s2_deviance(Dyad,condition,:));
        if ~all(isnan(s2_deviance_values))
        s2_min_loc_thresh(Dyad,condition) = find(s2_deviance_values == min(s2_deviance_values));
        end
    end
    
end



%% reanalysis
a = table();
a.Dyads = [4 7 13 14 16 18 19 21 22 23]';
a.conditions = {{'NeNoOcc_1'};
{'FaNoOcc_1','NeNoOcc_1'};
{'FaNoOcc_3','NeNoOcc_2'};
{'FaNoOcc_3'};
{'FaNoOcc_1'};
{'FaNoOcc_2'};
{'NeNoOcc_1','NeNoOcc_2'};
{'FaNoOcc_2','NeNoOcc_2'};
{'FaNoOcc_2','NeNoOcc_3'};
{'NeNoOcc_1'}};


%%
a = table();
a.Dyads = [7 13 14  21 22 ]';
a.conditions = {
{'NeNoOcc_1'};
{'NeNoOcc_2'};
{'NeNoOcc_2'};
{'NeNoOcc_2'};
{'NeNoOcc_3'}};



%%

all_conditions = {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'};
thresh = [1 1.5 2 2.5 3 3.5 4];

data_analysis_type = 'no_aggressive_trialwise_CAR';
analysis = 'Blink_detection';
Dyads = 1:23;
%%
startup_IBS('blinker')

for thresh_no = 1:length(thresh)
        [results_S1_F,results_S2_F] = IBS_blink_load_delays(1:23,1:6,thresh,thresh_no);

for rep = 1:size(a,1)
    

Dyad_no = a.Dyads(rep);

conditions = a.conditions{rep};
condition_no = find(contains(all_conditions,conditions));


    disp(['running ' num2str(thresh(thresh_no))])
    rng(10)
    
    varargin_table = table();
    varargin_table.blink_EEG = table();
    varargin_table.blink_EEG.stdThreshold = thresh(thresh_no);
    
    
    [results_S1,results_S2] = IBS_align_eeg_pupil_blinker(data_analysis_type,Dyads(Dyad_no),conditions,varargin_table);
    results_S1_F(Dyads(Dyad_no),condition_no) = results_S1(Dyads(Dyad_no),condition_no);
    results_S2_F(Dyads(Dyad_no),condition_no) = results_S2(Dyads(Dyad_no),condition_no);
end


    IBS_blink_save_delays(results_S1_F,results_S2_F,thresh,thresh_no,[],analysis)
end


%% Task reanalysis

a = table();
% a.Dyads = [1 1 1 11 20 20]';
% a.conditions = {
% {'Task_1'};
% {'Task_2'};
% {'Task_3'};
% {'Task_1'};
% {'Task_1'};
% {'Task_3'}};


% a.Dyads = [20 20]';
% a.conditions = {
% {'Task_1'};
% {'Task_3'}};

a.Dyads = [11]';
a.conditions = {
{'Task_1'}};

%
% all_conditions = {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'};
all_conditions =  {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3','Task_1','Task_2','Task_3'};
conditions = {'Task_1','Task_2','Task_3'};

Dyads = 1:23;

condition_no = contains(all_conditions,conditions);
results_S1_F = cell(length(Dyads),length(condition_no));
results_S2_F = cell(length(Dyads),length(condition_no));


thresh = [1 1.5 2 2.5 3 3.5 4];

data_analysis_type = 'no_aggressive_trialwise_CAR';
analysis = 'Blink_detection';

%%
startup_IBS('blinker')
for thresh_no = 1:length(thresh)
%         [results_S1_F,results_S2_F] = IBS_blink_load_delays(1:23,1:6,thresh,thresh_no);

for rep = 1:size(a,1)
    

Dyad_no = a.Dyads(rep);

conditions = a.conditions{rep};
condition_no = find(contains(all_conditions,conditions));


    disp(['running ' num2str(thresh(thresh_no))])
    rng(10)
    
    varargin_table = table();
    varargin_table.blink_EEG = table();
    varargin_table.blink_EEG.stdThreshold = thresh(thresh_no);
    
    
    [results_S1,results_S2] = IBS_align_eeg_pupil_blinker(data_analysis_type,Dyads(Dyad_no),conditions,varargin_table);
    results_S1_F(Dyads(Dyad_no),condition_no) = results_S1(Dyads(Dyad_no),condition_no);
    results_S2_F(Dyads(Dyad_no),condition_no) = results_S2(Dyads(Dyad_no),condition_no);
    clear results_S1 results_S2

end
    IBS_blink_save_delays(results_S1_F,results_S2_F,thresh,thresh_no,conditions,[],analysis)

end



%% check that the estimation is correct

load(['E:\Projects\IBS\Results\EEG\Blink_detection\no_aggressive_trialwise_CAR\delays_change_thresh_3.mat'],'results_S1_F','results_S2_F');
load(['E:\Projects\IBS\Results\EEG\Blink_detection\no_aggressive_trialwise_CAR\delays_change_thresh_1.5.mat'],'results_S1_F','results_S2_F');

load('correct_delays_EEG_eye_tracker.mat')

%% For task
load('E:\Projects\IBS\Results\EEG\Blink_detection\no_aggressive_trialwise_CAR\Task_delays_change_thresh_1.mat')
load('E:\Projects\IBS\Results\EEG\Blink_detection\no_aggressive_trialwise_CAR\Task_delays_change_thresh_4.mat')
load('E:\Projects\IBS\Results\EEG\Blink_detection\no_aggressive_trialwise_CAR\Task_delays_change_thresh_3.5.mat')
load('E:\Projects\IBS\Results\EEG\Blink_detection\no_aggressive_trialwise_CAR\Task_delays_change_thresh_2.mat')
load('E:\Projects\IBS\Results\EEG\Blink_detection\no_aggressive_trialwise_CAR\Task_delays_change_thresh_1.5.mat')

load('Task_correct_delays_EEG_eye_tracker.mat')

all_conditions =  {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3','Task_1','Task_2','Task_3'};
conditions = {'Task_1','Task_2','Task_3'};


% untested for other conditions:
%conditions = {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'};


condition_no = contains(all_conditions,conditions);



results_S1_F = results_S1_F(:,condition_no);
results_S2_F = results_S2_F(:,condition_no);

%%
Dyads = [2:9 11:14 16 19 21:23];
Dyads = [3 6 8 11 12 13 14 16 19 21 23];
for Dyad = 1:length(Dyads)%1:23
    for condition = 1:length(conditions)
        disp(['dyad ' num2str(Dyads(Dyad)) ' condition ' num2str(condition)])
        IBS_blink_correct(Dyads(Dyad),condition,results_S1_F,S1_delay_min_dev)
        if ~isnan(S2_delay_min_dev(Dyads(Dyad),condition))
            IBS_blink_correct(Dyads(Dyad),condition,results_S2_F,S2_delay_min_dev)
        end
        input('proceed')
        close all
    end
    
    
end


%% getting values for task reanalysis


thresh = [1 1.5 2 2.5 3 3.5 4];
Dyads_S1 = [1:23];
Dyads_S2 =[1:23];
%% for the task condition
all_conditions =  {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3','Task_1','Task_2','Task_3'};
conditions = {'Task_1','Task_2','Task_3'};


% untested for other conditions:
%conditions = {'FaNoOcc_1','FaNoOcc_2','FaNoOcc_3','NeNoOcc_1','NeNoOcc_2','NeNoOcc_3'};


condition_no = contains(all_conditions,conditions);


%%
for thresh_no = 1:length(thresh)

% load(['test\\test_all_sub_change_thresh_' num2str(thresh(thresh_no)) '.mat'],'results_S1_F','results_S2_F')
% load(['E:\Projects\IBS\Results\EEG\Blink_detection\no_aggressive_trialwise_CAR\delays_change_thresh_'  num2str(thresh(thresh_no)) '.mat'],'results_S1_F','results_S2_F');
% load(['E:\Projects\IBS\Results\EEG\Blink_detection\no_aggressive_trialwise_CAR\Task_delays_change_thresh_' num2str(thresh(thresh_no)) '.mat'])
% load(['E:\Projects\IBS\Results\EEG\Blink_detection\no_aggressive_trialwise_CAR\Task_delays_change_thresh_' num2str(thresh(thresh_no)) '_additional_sub.mat'])
load(['E:\Projects\IBS\Results\EEG\Blink_detection\no_aggressive_trialwise_CAR\Task_delays_change_thresh_' num2str(thresh(thresh_no)) '_additional_20_sub.mat'])




results_S1_F = IBS_blink_subs_empty_delays(results_S1_F);
results_S2_F = IBS_blink_subs_empty_delays(results_S2_F);

S1_delays{thresh_no} = cell2mat(cellfun(@(x) x.delay_rms,results_S1_F(Dyads_S1,condition_no),'UniformOutput',0));

S1_delays{thresh_no}(:,end+1) = Dyads_S1';

S1_delays{thresh_no}(:,end+1) = thresh(thresh_no);
% this is the one that was used for all the conditions except task
% S2_delays{thresh_no} = cell2mat(cellfun(@(x) x.delay_rms,results_S2_F(Dyads_S2,:),'UniformOutput',0));
% this is used for task because for dyad 3, there are 2 delays
S2_delays{thresh_no} = cell2mat(cellfun(@(x) min(x.delay_rms),results_S2_F(Dyads_S2,condition_no),'UniformOutput',0));

S2_delays{thresh_no}(:,end+1) = Dyads_S2';
S2_delays{thresh_no}(:,end+1) = thresh(thresh_no);

% S1_delays_deviance{thresh_no} = cell2mat(cellfun(@(x) x.deviance_delay_rms,results_S1_F(Dyads_S1,:),'UniformOutput',0));
S1_delays_deviance{thresh_no} = cell2mat(cellfun(@(x) x.deviance_delay_rms,results_S1_F(Dyads_S1,condition_no),'UniformOutput',0));

S1_delays_deviance{thresh_no}(:,end+1) = Dyads_S1';

S1_delays_deviance{thresh_no}(:,end+1) = thresh(thresh_no);

% S2_delays_deviance{thresh_no} = cell2mat(cellfun(@(x) x.deviance_delay_rms,results_S2_F(Dyads_S2,:),'UniformOutput',0));
S2_delays_deviance{thresh_no} = cell2mat(cellfun(@(x) x.deviance_delay_rms,results_S2_F(Dyads_S2,condition_no),'UniformOutput',0));

S2_delays_deviance{thresh_no}(:,end+1) = Dyads_S2';
S2_delays_deviance{thresh_no}(:,end+1) = thresh(thresh_no);

end


%
s1 = cat(3,S1_delays{:});
s2 = cat(3,S2_delays{:});

s1_deviance = cat(3,S1_delays_deviance{:});
s2_deviance = cat(3,S2_delays_deviance{:});


% 7 is the no. of thresholds
s1_dev_min_loc = bsxfun(@eq, abs(s1_deviance),repmat(min(abs(s1_deviance),[],3),1,1,7));
s2_dev_min_loc = bsxfun(@eq, abs(s2_deviance),repmat(min(abs(s2_deviance),[],3),1,1,7));


s1_min =  s1.*s1_dev_min_loc;
s1_min(s1_min==0) = nan;


S1_delay_min_dev = min(s1_min,[],3);

s2_min =  s2.*s2_dev_min_loc;
s2_min(s2_min==0) = nan;


S2_delay_min_dev =min(s2_min,[],3);
%%

[a,b] = sort(results_S2_F{12,2}.cur_delay)
results_S2_F{12,2}.actual_delays(b)
sort( results_S2_F{12,2}.actual_delays)



results_S1_F = results_S1_F(:,condition_no);
results_S2_F = results_S2_F(:,condition_no);
sort( results_S2_F{12,2}.actual_delays)
sort( results_S2_F{19,2}.actual_delays)
sort( results_S1_F{21,1}.actual_delays)


blinks_start_time = results.all_timepoints(find(results.blinks_start_loc));
blink_data_EEG_S1 = results.blinks_EEG_times(find(results.blink_data));

IBS_blink_compute_lag(blinks_start_time,blink_data_EEG_S1)
% reverse to get more delays
IBS_blink_compute_lag(blink_data_EEG_S1,blinks_start_time)

%%
% load(['E:\Projects\IBS\Results\EEG\Blink_detection\no_aggressive_trialwise_CAR\delays_change_thresh_1.mat'],'results_S1_F');

% load('correct_delays_EEG_eye_tracker.mat')
Dyad =2;
condition= 4;

IBS_blink_plot_results(results_S1_F,Dyad,condition)


%% checking correct combinations
for thresh_no = 1:length(thresh)
    [results_S1_F,results_S2_F] = IBS_blink_load_delays(1:23,1:6,thresh,thresh_no);
    
    
    load('correct_delays_EEG_eye_tracker.mat')
    [Dyads_S1,conditions_S1] = find(S1_dev_min_loc(:,1:6)==thresh(thresh_no));
    [Dyads_S2,conditions_S2] = find(S2_dev_min_loc(:,1:6)==thresh(thresh_no));
    % Dyads = [Dyads_S1 Dyads_S2];
    % conditions = [conditions_S1 conditions_S2];
    
    for rep = 1:length(Dyads_S1)
        disp(['dyad ' num2str(Dyads_S1(rep)) ' condition ' num2str(conditions_S1(rep))])
        IBS_blink_correct(Dyads_S1(rep),conditions_S1(rep),results_S1_F,S1_delay_min_dev)
        
        input('proceed')
        
        
        
    end
    
    for rep2 = 1:length(Dyads_S2)
        disp(['dyad ' num2str(Dyads_S2(rep)) ' condition ' num2str(conditions_S2(rep))])
        if ~isnan(S2_delay_min_dev(Dyads_S1(rep),conditions_S1(rep)))
            IBS_blink_correct(Dyads_S2(rep2),conditions_S2(rep2),results_S2_F,S2_delay_min_dev)
        end
        input('proceed')
    end
    
end