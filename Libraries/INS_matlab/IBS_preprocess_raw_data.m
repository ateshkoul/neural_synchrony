function dataset_filt = IBS_preprocess_raw_data(Dyad_no,block)



    dataset = IBS_load_raw_sub_data(Dyad_no,block);
    %% clean the dataset
    
    %% remove extra channels
    dataset = IBS_remove_extra_chans(dataset);
    
    %% filter the data
    dataset_filt = IBS_filter_raw_data(dataset);
    
    
end