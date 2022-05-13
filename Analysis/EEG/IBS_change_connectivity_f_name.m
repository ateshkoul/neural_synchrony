function connectivity_fname = IBS_change_connectivity_f_name(coherence_fname,measure)
%% Atesh 17-12-2020
% function that changes the name of coherence files depending on the measure used
% so that I don't have to manually add all the names

connectivity_fname = strrep(coherence_fname,'coherence',measure);


end