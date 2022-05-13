function [event_table,eventvalue] = get_eventtable_custom(Dyd_no,block,eventvalue)


event_file = get_dataset_fname(Dyd_no,block);
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
%         eventvalue = [21:10:61 22:10:62 23:10:63];
    case 'baseline_2'
        if Dyd_no == 1
            rows_to_delete = 4:2:8;
            event_table(rows_to_delete) = [];
        end
        eventvalue = 71:73;
end
end