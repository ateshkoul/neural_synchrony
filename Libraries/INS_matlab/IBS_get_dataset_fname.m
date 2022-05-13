function [dataset_fname] = IBS_get_dataset_fname(Dyd_no,block)

comp_name = getenv('computername');

switch comp_name
    case 'DESKTOP-ALIEN'
        processed_dir = 'D:\\iannettilab_dropbox\\Dropbox\\Koul_Atesh\\IBS\\';
    case 'DESKTOP-79H684G'
        processed_dir = 'Z:\\Dropbox\\Koul_Atesh\\IBS\\';
        
end
dataset_fname = [ processed_dir sprintf('Dyd_%0.3d\\EEG\\Dyad_%0.2d_%s.bdf', Dyd_no, Dyd_no,block)];
    
end