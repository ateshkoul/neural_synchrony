function behav_data = IBS_import_gaze_positions_csv_data(filename, dataLines)
%IMPORTFILE Import data from a text file
%  GAZEPOSITIONS = IMPORTFILE(FILENAME) reads data from text file
%  FILENAME for the default selection.  Returns the data as a table.
%
%  GAZEPOSITIONS = IMPORTFILE(FILE, DATALINES) reads data for the
%  specified row interval(s) of text file FILENAME. Specify DATALINES as
%  a positive scalar integer or a N-by-2 array of positive scalar
%  integers for dis-contiguous row intervals.
%
%  Example:
%  gazepositions = importfile("D:\iannettilab_dropbox\Dropbox\Koul_Atesh\IBS\Dyd_001\Eye_tracker\pupil_0\NeNoOcc_1\Sub_0\000\exports\000\gaze_positions.csv", [2, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 23-Dec-2020 10:57:05

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [2, Inf];
end

%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 21);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["gaze_timestamp", "world_index", "confidence", "norm_pos_x", "norm_pos_y", "base_data", "gaze_point_3d_x", "gaze_point_3d_y", "gaze_point_3d_z", "eye_center0_3d_x", "eye_center0_3d_y", "eye_center0_3d_z", "gaze_normal0_x", "gaze_normal0_y", "gaze_normal0_z", "eye_center1_3d_x", "eye_center1_3d_y", "eye_center1_3d_z", "gaze_normal1_x", "gaze_normal1_y", "gaze_normal1_z"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "char", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "base_data", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "base_data", "EmptyFieldRule", "auto");

% Import the data
behav_data = readtable(filename, opts);

end