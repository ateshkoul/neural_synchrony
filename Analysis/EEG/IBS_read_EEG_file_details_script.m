

for dyad = 1:23
EEG_file_details{dyad} = IBS_read_EEG_file_details(dyad,'blocks');
end
cat(1,EEG_file_details{:})