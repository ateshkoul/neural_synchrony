    raw_data_dir = 'D:\\iannettilab_dropbox\\Dropbox\\Koul_Atesh\\IBS\\';

% Dyad_no = 1;
% condition = 'FaNoOcc_1';
% Sub_no = 0;
sub = table();
sub.behav_analysis = 'joint';
dyad_no = 1;
condition = 'NeNoOcc_1';
auto_smile_S1 = IBS_get_sub_behavior_data('Smile_auto',dyad_no,0,condition,raw_data_dir,sub);
auto_smile_S2 = IBS_get_sub_behavior_data('Smile_auto',dyad_no,1,condition,raw_data_dir,sub);

plot(auto_smile_S1.time_stamps_rel_0,auto_smile_S1.mouth_size_0)
hold on
plot(auto_smile_S2.time_stamps_rel_1,auto_smile_S2.mouth_size_1)
ax = gca;
ax.Box = 'off';




plot(auto_smile_S1.time_stamps_rel_0,normalize(auto_smile_S1.mouth_size_0,'range'))
hold on
plot(auto_smile_S2.time_stamps_rel_1,normalize(auto_smile_S2.mouth_size_1,'range'))
ax = gca;
ax.Box = 'off';





