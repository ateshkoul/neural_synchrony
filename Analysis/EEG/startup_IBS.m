function startup_IBS(lw)
clc;

if nargin <1
    lw = 'none';
end


comp_name = getenv('computername');

switch comp_name
    case 'IITLW4178'
        fieldtrip_path_name = 'C:\Users\AKoul\Downloads\fieldtrip-20200409\';
        username = 'AKoul';
        addpath(fieldtrip_path_name);
        
    case 'DESKTOP-ALIEN'
        username = 'Atesh';
        fieldtrip_path_name = ['C:\Users\' username '\Downloads\fieldtrip-20200327\'];
        
        addpath(fieldtrip_path_name);
        ft_defaults;
        ft_hastoolbox('brewermap', 1);

        
        lib_function_path = ['C:\Users\' username '\OneDrive - Fondazione Istituto Italiano Tecnologia\Research projects 2020\Inter-brain synchrony\Libraries\IBS_matlab\'];
        addpath(lib_function_path);
        
        Information_theory_toolbox = ['C:\Users\' username '\OneDrive - Fondazione Istituto Italiano Tecnologia\Research projects 2020\Inter-brain synchrony\Libraries\IBS_matlab\Information_theory\'];
        addpath(Information_theory_toolbox);
        
        util_function_path = ['C:\Users\' username '\OneDrive - Fondazione Istituto Italiano Tecnologia\Research projects 2020\EEG_prestimulus\Resources\Giac2Atesh\utils\'];
        addpath(util_function_path);
        Giac_toolbox_path = ['C:\Users\' username '\OneDrive - Fondazione Istituto Italiano Tecnologia\Research projects 2020\EEG_prestimulus\Resources\Giac2Atesh\Giac_ToolBox\'];
        addpath(genpath(Giac_toolbox_path));
        addpath(genpath(['C:\Users\' username '\OneDrive - Fondazione Istituto Italiano Tecnologia\Research projects 2020\EEG_prestimulus\Resources\Giac2Atesh\utilities']));
        % % startup_iannetti;
        % addpath(genpath(['C:\Users\' username '\Downloads\Natural-Frequencies\analyses']));
        Giac_toolbox_path = ['C:\Users\' username '\OneDrive - Fondazione Istituto Italiano Tecnologia\Research projects 2020\EEG_prestimulus\Resources\Giac2Atesh\Giac_ToolBox\'];
        addpath(genpath(Giac_toolbox_path));
        nf_lib_function_path = ['C:\Users\' username '\OneDrive - Fondazione Istituto Italiano Tecnologia\Research projects 2020\Inter-brain synchrony\Libraries\IBS_matlab\Natural_frequencies\'];
        addpath(nf_lib_function_path);
        
  
        
%         eeglab_path = "Y:\Libraries\eeglab2019_1\";
%         
%         
%         addpath(eeglab_path)
        
        letswave6_path = ['C:\Users\' username '\OneDrive - Fondazione Istituto Italiano Tecnologia\Research projects 2020\Libraries\letswave6-master'];
        switch(lw)
            case 'add'
                addpath(genpath(letswave6_path));
            case 'remove'
                rmpath(genpath(letswave6_path));
            case 'add_NF'
                addpath(genpath(lib_function_path));
            case 'blinker'
                rmpath('C:\Users\Atesh\OneDrive - Fondazione Istituto Italiano Tecnologia\Research projects 2020\EEG_prestimulus\Resources\Giac2Atesh\utilities\3rd party utilities\eeglab13_5_4b\')
                eeglab_path = ['C:\Users\' username '\OneDrive - Fondazione Istituto Italiano Tecnologia\Research projects 2020\Libraries\eeglab2020_0\'];
                addpath(eeglab_path)
                addpath(genpath(['C:\Users\' username '\OneDrive - Fondazione Istituto Italiano Tecnologia\Research projects 2020\Libraries\eeglab2020_0\functions\']));
                addpath(genpath(['C:\Users\' username '\OneDrive - Fondazione Istituto Italiano Tecnologia\Research projects 2020\Libraries\eeglab2020_0\plugins\blinkerv1.1.2\']));
            case 'asr'
                              asr_path = "Y:\Libraries\eeglab2019_1\plugins\clean_rawdata";
                addpath(genpath(asr_path))
                           case 'granger'
                addpath(genpath('Y:\Inter-brain synchrony\Libraries\IBS_matlab\mvgc_v1.0\'))
                
            case 'none'
                disp('')
        end
    case 'DESKTOP-79H684G'
        username = 'Atesh';
        fieldtrip_path_name = ['D:\' username '\IBS\Libraries\fieldtrip-20200327\'];
        addpath(fieldtrip_path_name);
        ft_defaults;
%         lib_function_path = ['D:\' username '\IBS\Libraries\IBS_matlab\'];
        lib_function_path = ['Y:\Libraries\IBS_matlab\'];
        addpath(genpath(lib_function_path));
        
        
        Information_theory_toolbox = ['Y:\Libraries\IBS_matlab\Information_theory\'];
        addpath(Information_theory_toolbox);
        
        
        Giac_toolbox_path = ['D:\' username '\IBS\Libraries\Giac_toolbox'];
        addpath(genpath(Giac_toolbox_path));
        
        asr_path = "D:\Atesh\Libraries\eeglab2020_0\plugins\clean_rawdata";
        addpath(genpath(asr_path))
        
        
        letswave6_path = 'D:\\Atesh\\IBS\\Libraries\\letswave6-master';
        switch(lw)
            case 'add'
                addpath(genpath(letswave6_path));
            case 'remove'
                rmpath(genpath(letswave6_path));
            case 'add_NF'
                addpath(genpath(lib_function_path));
            case 'blinker'
%                 eeglab_path = "D:\Atesh\Libraries\eeglab2020_0\";
%                 addpath(eeglab_path)
                
                %% new
%                 rmpath('C:\Users\Atesh\OneDrive - Fondazione Istituto Italiano Tecnologia\Research projects 2020\EEG_prestimulus\Resources\Giac2Atesh\utilities\3rd party utilities\eeglab13_5_4b\')
                eeglab_path = 'Y:\Libraries\eeglab2020_0\';
                addpath(eeglab_path)
                addpath(genpath('Y:\Libraries\eeglab2020_0\functions\'));
                addpath(genpath('Y:\Libraries\eeglab2020_0\plugins\blinkerv1.1.2\'));
            
            case 'granger'
                addpath(genpath('Y:\Inter-brain synchrony\Libraries\IBS_matlab\mvgc_v1.0\'))
                
            case 'none'
                disp('')
        end
        
        
end

% addpath(genpath('libsvm-3.24\'))





end

