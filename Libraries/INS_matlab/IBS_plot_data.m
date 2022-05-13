function IBS_plot_data(data,sub,channels,y_limits,layout)


if nargin <2
    sub = 1;
   channels = {'1*'}; 
end

if nargin <3
   channels = {'1*'}; 
end

if nargin<4
    y_limits = [-30 30];
end
if nargin <5
layout = sprintf('IBS_S%d_layout_64.mat',sub);
end
cfgint = [];
% cfgint.channel         = {'1-C1','2-C1','1-Pz','2-Pz'}; %{'1-Fp1';'1-AF7';'1-AF3';'1-F1';'1-F3';'1-F5';'1-F7';'1-FT7';'1-FC5';'1-FC3'}
% cfgint.channel         = {'1*'};
cfgint.channel         = channels;
% cfgint.channel         = {'1-EXG5'};

cfgint.viewmode        = 'vertical';
cfgint.layout          =  layout; %'biosemi64.lay';
% cfgint.axisfontsize    = 6; 
cfgint.ylim = y_limits;
cfgint.plotlabels      = 'yes';
% cfgint.artifact        = [];
% cfgint.continuous      = 'no';
% cfgint.selectmode      = 'markartifact';
ft_databrowser(cfgint,data)
end