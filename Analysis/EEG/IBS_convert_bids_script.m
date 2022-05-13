Dyads = 1;
blocks = {'baseline_1','blocks','baseline_2'};

root_dir = 'D:\\iannettilab_dropbox\\Dropbox\\Koul_Atesh\\IBS\\';
for dyd_no = 1:length(Dyads)
    for block = 1:length(blocks)
        convert_bids(Dyads(dyd_no),blocks{block},root_dir);
    end
end


Dyads = 1;
blocks = {'baseline_1','blocks','baseline_2'};



root_dir = 'E:\\INS\\';
for dyd_no = 1:length(Dyads)
    for block = 1:length(blocks)
        convert_bids(Dyads(dyd_no),blocks{block},root_dir);
    end
end
