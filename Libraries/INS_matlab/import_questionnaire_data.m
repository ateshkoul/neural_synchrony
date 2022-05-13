function QuestionnairedetailsS1 = import_questionnaire_data(workbookFile, sheetName, dataLines)
%IMPORTFILE Import data from a spreadsheet
%  QUESTIONNAIRES1 = IMPORTFILE(FILE) reads data from the first
%  worksheet in the Microsoft Excel spreadsheet file named FILE.
%  Returns the data as a table.
%
%  QUESTIONNAIRES1 = IMPORTFILE(FILE, SHEET) reads from the specified
%  worksheet.
%
%  QUESTIONNAIRES1 = IMPORTFILE(FILE, SHEET, DATALINES) reads from the
%  specified worksheet for the specified row interval(s). Specify
%  DATALINES as a positive scalar integer or a N-by-2 array of positive
%  scalar integers for dis-contiguous row intervals.
%
%  Example:
%  QuestionnaireS1 = importfile("C:\Users\Atesh\OneDrive - Fondazione Istituto Italiano Tecnologia\Research projects 2020\Inter-brain synchrony\Results\Questionnaire.xlsx", "Data_dyads", [2, 24]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 13-Aug-2021 11:23:21

%% Input handling

% If no sheet is specified, read first sheet
if nargin == 1 || isempty(sheetName)
    sheetName = 1;
end

% If row start and end points are not specified, define defaults
if nargin <= 2
    dataLines = [2, 24];
end

%% Setup the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 47);

% Specify sheet and range
opts.Sheet = sheetName;
opts.DataRange = "A" + dataLines(1, 1) + ":AU" + dataLines(1, 2);

% Specify column names and types
opts.VariableNames = ["Dyad_no", "Subject1", "Name1", "LastName1", "Hand1Destrimano2Mancino3Ambodestro1", "happiness_participating1", "embarrassment_visual_contact1", "embarrassment_visual_contact_unfamiliar1", "attention_during_expt1", "years_of_familiarity1", "visiting_freq1", "subjective_closeness1", "freedom_head1", "freedom_arms1", "freedom_hands1", "freedom_torso1", "freedom_legs1", "freedom_feet1", "driving_other_mov1", "mov_when_observing1", "driving_other_smile1", "smile_when_observing1", "driving_other_eyegaze1", "eyegaze_when_observing1", "Subject2", "Name2", "LastName2", "Hand1Destrimano2Mancino3Ambodestro2", "happiness_participating2", "embarrassment_visual_contact2", "embarrassment_visual_contact_unfamiliar2", "attention_during_expt2", "years_of_familiarity2", "visiting_freq2", "subjective_closeness2", "freedom_head2", "freedom_arms2", "freedom_hands2", "freedom_torso2", "freedom_legs2", "freedom_feet2", "driving_other_mov2", "mov_when_observing2", "driving_other_smile2", "smile_when_observing2", "driving_other_eyegaze2", "eyegaze_when_observing2"];
opts.VariableTypes = ["double", "char", "char", "char", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "char", "char", "char", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify variable properties
opts = setvaropts(opts, ["Subject1", "Name1", "LastName1", "Subject2", "Name2", "LastName2"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Subject1", "Name1", "LastName1", "Subject2", "Name2", "LastName2"], "EmptyFieldRule", "auto");

% Import the data
QuestionnairedetailsS1 = readtable(workbookFile, opts, "UseExcel", false);

for idx = 2:size(dataLines, 1)
    opts.DataRange = "A" + dataLines(idx, 1) + ":AU" + dataLines(idx, 2);
    tb = readtable(workbookFile, opts, "UseExcel", false);
    QuestionnairedetailsS1 = [QuestionnairedetailsS1; tb]; %#ok<AGROW>
end

end