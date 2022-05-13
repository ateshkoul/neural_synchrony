function convert_bids(Dyd_no,block,root_dir)

  cfg = [];
  cfg.method    = 'convert';
  cfg.datatype  = 'eeg';

  % specify the input file name, here we are using the same file for every subject
  cfg.dataset   = [root_dir sprintf('Dyd_%0.3d\\EEG\\Dyad_%0.2d_%s.bdf', Dyd_no, Dyd_no,block)];
  % specify the output directory
  cfg.bidsroot  = 'Raw_data';
  cfg.sub       = sprintf('%0.2d', Dyd_no);

%   % specify the information for the participants.tsv file
%   % this is optional, you can also pass other pieces of info
%   cfg.participants.age = 25;
%   cfg.participants.sex = 'f';

%   % specify the information for the scans.tsv file
%   % this is optional, you can also pass other pieces of info
%   cfg.scans.acq_time = datestr(now, 'yyyy-mm-ddThh:MM:SS'); % according to RFC3339

  % specify some general information that will be added to the eeg.json file
  cfg.InstitutionName             = 'Istituto Italiano di Tecnologia';
  cfg.InstitutionalDepartmentName = 'Neuroscience of Perception & Action Lab';
  cfg.InstitutionAddress          = 'Viale Regina Elena 291, Rome, Italy';

  % provide the mnemonic and long description of the task
  cfg.TaskName        = strrep(block,'_','');
  cfg.TaskDescription = 'Dyads were asked to simply look at each other';
  cfg.dataset_description.Name = "Dataset for Spontaneous dyadic behavior predicts self-organizing interpersonal neural synchrony";
  % these are EEG specific
  cfg.eeg.PowerLineFrequency = 50;   % since recorded in the USA
  cfg.eeg.EEGReference       = 'None'; % actually I do not know, but let's assume it was left mastoid
 
  data2bids(cfg);
  
end