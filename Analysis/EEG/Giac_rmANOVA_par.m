function [ data_out_F, data_out_P ] = Giac_rmANOVA_par( data, design, levels, channels, field_oi )
%
% Input is a series of 'data' structures from FT (a 1xN cell with 1 structure in each). It performs a repeated measures ANOVA
% on each time point of the field of interest ('field_oi'), only for the channels of interest ('channels'),
% according to the design specified in 'design' (e.g. 4x2 with small 'x', max 9 levels within each factor).
% 'design' (e.g. '4x2') and 'levels' (e.g. {{'1','2','3','4','1','2','3','4'}',{'1','1','1','1','2','2','2','2'}'})
% specify details about the ANOVA.
% The outputs are also data structures, similar to
% the inputted data, one for F and one for P values. 
%
%% Giacomo Novembre

% Select only channels of interest
for d = 1: length(data)
    cfg         = [];
    cfg.channel = channels;
    data{d}     = ft_selectdata(cfg, data{d});
end

% Figure out how many manipulations and levels
xpos_in_str  = strfind(design,'x');
levels_pos   = [1 xpos_in_str+1];
Man_levels   = [];
for f = 1: length(levels_pos)
    Man_levels = [Man_levels str2num(design(levels_pos(f)))];
end

% Extract only data of interest and place it within useful matrix for later computations ... 
n_pts        = size(data{1}.(field_oi),1);
n_conditions = prod(Man_levels);
n_timePoints = size(data{1}.(field_oi),3);
n_channels   = length(channels);
ANOVA_MAT    = nan(n_pts,n_conditions, n_timePoints, n_channels);

for c = 1 : n_conditions
    interaction = data{c}.(field_oi);
    for ch = 1:n_channels
        ANOVA_MAT(:,c,:,ch) = interaction(:,ch,:);
    end
end

% Prepare condition names
condition_names      = cell(1,n_conditions+1);
condition_names{1,1} = 'pts';
for c = 2:(n_conditions+1)
    condition_names{1,c} = ['cond' num2str(c-1)];
end

% Prepare level names ... 
table_fillin_start = levels; 
table_fillin_end   = cell(1,length(Man_levels));

for m = 1: length(Man_levels) % number of manipulations loop   
    table_fillin_end{1,m}   = ['C' num2str(m)];  
end

%% Prepare interaction term
interaction = [];
for i=1:length(table_fillin_end)
    if i==1
    interaction = [interaction table_fillin_end{i}];
    else
    interaction = [interaction '*' table_fillin_end{i}];
    end
end

%% Determine n of main effect and interactions
switch length(Man_levels)
    case 2
        m_i_num = 3;
    case 3
        m_i_num = 7;
    case 4
        display('GIAC: code me for it... ');
    otherwise
        display('GIAC: code me for it... ');
end

%% Perform ANOVA
% added parallel loop - Atesh (03-12-2020)
% F_values = nan(n_channels,m_i_num,n_timePoints);
% P_values = nan(n_channels,m_i_num,n_timePoints);

parfor ch = 1:n_channels
    display(['Giac: ANOVA starting with ch ' num2str(ch) ' of ' num2str(n_channels)]);
    
    for t = 1:n_timePoints
        DataTable   = array2table([(1:n_pts)',ANOVA_MAT(:,:,t,ch)],'VariableNames',condition_names);
        CondTable   = table(table_fillin_start{:},'VariableNames',table_fillin_end);
        rm          = fitrm(DataTable,['cond' num2str(1) '-cond' num2str(n_conditions) ' ~ 1'],'WithinDesign',CondTable);
        [ranovatbl] = ranova(rm,'WithinModel',interaction);
            F_values_cur_ch_t{ch}(:,t) = ranovatbl.F(3:2:end)';
            P_values_cur_ch_t{ch}(:,t) = ranovatbl.pValue(3:2:end)';
            % for inner par loop
%             F_values_cur_t{t} = ranovatbl.F(3:2:end)';
%             P_values_cur_t{t} = ranovatbl.pValue(3:2:end)';
% original
%             F_values(ch,:,t) = ranovatbl.F(3:2:end)';
%             P_values(ch,:,t) = ranovatbl.pValue(3:2:end)';
    end
% for inner par loop
%     F_values(ch,:,:) = cat(1,F_values_cur_t{:})';
%     P_values(ch,:,:) = cat(1,P_values_cur_t{:})';
    

end
% Atesh - for parallel loop only
F_values = permute(cat(3,F_values_cur_ch_t{:}),[3 1 2]);
P_values = permute(cat(3,P_values_cur_ch_t{:}),[3 1 2]);

%% Output me as a data structure
data_out                = struct;
data_out.trial          = cell(1,m_i_num);
data_out.label          = data{1}.label;
data_out.cfg            = [];
data_out.hdr            = [];
data_out.cfg.continuous = 'no';
data_out_F              = data_out;
data_out_P              = data_out;

for tmp=1:m_i_num
    data_out_F.trial{1,tmp} = squeeze(F_values(:,tmp,:));
%     data_out_F.time{1,tmp}  = data{1}.time;
    data_out_P.trial{1,tmp} = squeeze(P_values(:,tmp,:));
%     data_out_P.time{1,tmp}  = data{1}.time;
end

end

