load('interp_chans_all_sub_corrected_sub_order_corrected_S2_S12_S19.mat')
interp_chans_S1 = cellfun(@(y) cellfun(@(x) length(x),y),interp_ch_S1,'UniformOutput',0);
interp_chans_S2 = cellfun(@(y) cellfun(@(x) length(x),y),interp_ch_S2,'UniformOutput',0);


all_block_S1 = cellfun(@(x) sum(x),interp_chans_S1);
all_block_S2 = cellfun(@(x) sum(x),interp_chans_S2);
mean((all_block_S1+all_block_S2)/(64*3*2)) %1.75

sum((all_block_S1+all_block_S2)) % 155