function [event_table,eventvalue] = IBS_get_eventtable(Dyd_no,block)


%% Atesh Koul
event_file = IBS_get_dataset_fname(Dyd_no,block);
event_table = ft_read_event(event_file);

switch(block)
    case 'baseline_1'
        if Dyd_no == 1
            rows_to_delete = 4:2:8;
            event_table(rows_to_delete) = [];
        end
        eventvalue = 11:13;
        
    case 'blocks'
        if Dyd_no == 1
            % have to delete 1 and 2 as we had started the experiment with
            % masks so we repeated it.
            rows_to_delete = [2 3:2:27 30:2:34];
            event_table(rows_to_delete) = [];
        end
        
        if Dyd_no ==12
            event_table(4:48) = event_table(3:47);
            event_table(3).sample = 1;
            %             pre_trig_time = 3; %change this to 3 for asr cleaning and 1 for normal condition.
           
            %             event_table(3).sample = pre_trig_time * (2048+1); % this is the case because I am
            % trying to select the time interval [-1 120]
            event_table(3).value = 31;
        end
        
        
        if Dyd_no == 19
            event_table(28).value = 23;
            event_table(30).value = 33;
            event_table(43).value = 63;
            event_table([32:33 35:42]) = [];
        end
        eventvalue = [21:10:61 22:10:62 23:10:63];
    case 'baseline_2'
        if Dyd_no == 1
            rows_to_delete = 4:2:8;
            event_table(rows_to_delete) = [];
        end
        if Dyd_no == 19
            rows_to_delete = 3:6;
            event_table(rows_to_delete) = [];
        end
        
        
        eventvalue = 71:73;
end
end
% what is done is 43 and 53
% left are 23 33 63

% So first 21 becomes 23,31 becomes 33
% ('Baseline_start'):
% codes = (10,15)
%
%
% ('FaOcc'):
% # this is for biosemi so that the codes can be recognized
% codes = (20,25)
%
%
% ('FaNoOcc'):
% codes = (30,35)
%
%
% ('NeOcc'):
% codes = (40,45)
%
%
% ('NeNoOcc'):
% codes = (50,55)
%
%
% ('Baseline_end'):
% codes = (70,75)
%
%
% ('Task'):
% codes = (60,65)