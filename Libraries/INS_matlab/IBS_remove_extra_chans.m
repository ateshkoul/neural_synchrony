function dataset = IBS_remove_extra_chans(dataset,channels_to_remove)

if nargin <2

channels_to_remove = {'1-GSR1','1-GSR2','1-Erg1','1-Erg2','1-Resp','1-Plet','1-Temp','2-GSR1','2-GSR2','2-Erg1','2-Erg2','2-Resp','2-Plet','2-Temp'};
end
dataset = Giac_removeChannels( dataset, channels_to_remove );


end