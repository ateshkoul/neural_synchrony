Dyads = [1:11 13:18 20:23];
interp_ch_S1 = cell(length(Dyads),1);
interp_ch_S2 = cell(length(Dyads),1);
for Dyd_no = 6:length(Dyads)
   sprintf('loading data Dyd_%0.2d',Dyads(Dyd_no))
   load(sprintf('D:\\Experiments\\IBS\\Processed\\EEG\\Only_eye_artefacts\\Dyd_%0.2d_ICA_func_clean_bp_03_95_120s.mat',Dyads(Dyd_no)),'data_ica_clean_S1','data_ica_clean_S2')  
   [interp_ch_S1_sub,interp_ch_S2_sub] = cellfun(@IBS_get_interpolated_chan,data_ica_clean_S1,'UniformOutput',false);
   interp_ch_S1{Dyd_no,1} = interp_ch_S1_sub;
   interp_ch_S2{Dyd_no,1} = interp_ch_S2_sub;  
   
end
save('interp_chans_all_sub_corrected_sub_order_6_23.mat','interp_ch_S1','interp_ch_S2');

%% checking with excel file
load('interp_chans_all_sub_corrected_sub_order.mat')
interp_ch_S1_excel_format = cat(1,interp_ch_S1{:});
interp_ch_S2_excel_format = cat(1,interp_ch_S2{:});


IBSdatacleaningS1 = IBS_importfile_data_cleaning_excel('IBS_data_cleaning.xlsx', "Sheet2", [2 24]);
S1_excel = IBSdatacleaningS1([1:11 13:18 20:23],2:4);
S2_excel = IBSdatacleaningS1([1:11 13:18 20:23],8:10);


result_S1 = cellfun(@IBS_check_chan_excel_script ,S1_excel(6:end,:), interp_ch_S1_excel_format(6:end,:),'UniformOutput',false);


result_S2 = cellfun(@IBS_check_chan_excel_script ,S2_excel(6:end,:), interp_ch_S2_excel_format(6:end,:),'UniformOutput',false);

sum(cat(1,result_S1{:}) == 0)
sum(cat(1,result_S2{:}) == 0)







%% automatically remove the bad channels

% load the mat file with the bad chan data

% Dyads = [1 2 3 4 5];
Dyads = 23;

% Dyads = [1];
layout_S1 = 'IBS_S1_layout_64.mat';
layout_S2 = 'IBS_S2_layout_64.mat';
neigh_dist = 0.23;
blocks = {'baseline_1','blocks','baseline_2'};

for Dyd_no = 1:length(Dyads)
    % load the data
     load(sprintf('D:\\Experiments\\IBS\\Processed\\EEG\\Dyd_%0.2d_ICA_func_clean_bp_03_95_120s.mat',Dyads(Dyd_no)),'data_ica_clean_S1','data_ica_clean_S2')  
bad_chan_S1 = interp_ch_S1{Dyd_no,1};
    bad_chan_S2 = interp_ch_S2{Dyd_no,1};
    
    
    data_ica_clean_S1 = cellfun(@(x,y) IBS_interpolate_ch(x,y,layout_S1,neigh_dist),data_ica_clean_S1,bad_chan_S1,'UniformOutput',false);
    data_ica_clean_S2 = cellfun(@(x,y) IBS_interpolate_ch(x,y,layout_S2,neigh_dist),data_ica_clean_S2,bad_chan_S2,'UniformOutput',false);

end

%%
save_ICA_processed_IBS_data






