%%
data_analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
analysis = 'Brain_behavior_glm_power_freqwise';

save_dir_figures = IBS_get_params_analysis_type(data_analysis_type,analysis).analysis_save_dir_figures{1,1};

%%
offset = 222500;
ylimits = [-2450 -500];

%% cluster 1

figure
% a = [-222631.60+offset -222619.14+offset ];
% a = [-222649.90+offset -222644.26+offset ];
a = [-224617.66+offset -224617.12+offset ];

% errors = [260.112081 260.109213];

% errors = [281.74 281.77];
errors = [283.11 283.06];

bar(a);hold on
errorbar(a,errors,'k','linestyle','none')
ax = gca();
% ax = gca;
ax.XAxis.FontSize = 12;
% ax.XAxis.TickLabelRotation = 45;
ax.YAxis.Label.FontSize = 12;
xtl = '\begin{tabular}{c} Social Behavior \\ model \end{tabular}';
xtl_null = '\begin{tabular}{c} Null \\ model \end{tabular}';

set(gca, 'XTickLabel', {xtl_null xtl}, 'TickLabelInterpreter', 'latex');
ylim(ylimits)
yticklabels(cellfun(@(x) str2num(x)-offset, ax.YTickLabel, 'UniformOutput', false))

ylabel('LOO (a.u.)')

exportgraphics(gcf,[save_dir_figures '\\cluster_1_LOO_limits_insta_abs_detrend_smile_cor7.eps'],'BackgroundColor','none','ContentType','vector')
close all
%% cluster 2
figure
% a = [-221364.88+offset -220911.56+offset ];
% a = [-221648.75+offset -221419.66+offset ];
a = [-223632.62+offset -223359.73+offset ];
% errors = [312.747717 312.864086];

% errors = [326.77 326.23];

errors = [328.34 327.99];
bar(a);hold on
errorbar(a,errors,'k','linestyle','none')
ax = gca();
% ax = gca;
ax.XAxis.FontSize = 12;
% ax.XAxis.TickLabelRotation = 45;
ax.YAxis.Label.FontSize = 12;
xtl = '\begin{tabular}{c} Social Behavior \\ model \end{tabular}';
xtl_null = '\begin{tabular}{c} Null \\ model \end{tabular}';

set(gca, 'XTickLabel', {xtl_null xtl}, 'TickLabelInterpreter', 'latex');
ylim(ylimits)
yticklabels(cellfun(@(x) str2num(x)-offset, ax.YTickLabel, 'UniformOutput', false))

ylabel('LOO (a.u.)')

exportgraphics(gcf,[save_dir_figures '\\cluster_2_LOO_limits_insta_abs_detrend_smile_cor7.eps'],'BackgroundColor','none','ContentType','vector')
close all
%% cluster 3
figure
% a = [-222556.278540+offset -222540.230551+offset ];
% a = [-222615.33+offset -222597.98+offset ];
a = [-224615.00+offset -224594.53+offset ];

% errors = [258.50 258.52];
errors = [259.73 259.73];
bar(a);hold on
errorbar(a,errors,'k','linestyle','none')
ax = gca();
% ax = gca;
ax.XAxis.FontSize = 12;
% ax.XAxis.TickLabelRotation = 45;
ax.YAxis.Label.FontSize = 12;
xtl = '\begin{tabular}{c} Social Behavior \\ model \end{tabular}';
xtl_null = '\begin{tabular}{c} Null \\ model \end{tabular}';

set(gca, 'XTickLabel', {xtl_null xtl}, 'TickLabelInterpreter', 'latex');
ylim(ylimits)
yticklabels(cellfun(@(x) str2num(x)-offset, ax.YTickLabel, 'UniformOutput', false))
ylabel('LOO (a.u.)')

exportgraphics(gcf,[save_dir_figures '\\cluster_3_LOO_limits_insta_abs_detrend_smile_cor7.eps'],'BackgroundColor','none','ContentType','vector')
close all
%%


%% AND XOR
data_analysis_type = 'no_aggressive_CAR_ASR_10_ICA_appended_trials';
analysis = 'Brain_behavior_glm_power_freqwise';

save_dir_figures = IBS_get_params_analysis_type(data_analysis_type,analysis).analysis_save_dir_figures{1,1};

offset = 233850;
ylimit = 900;
%% cluster 1 AND XOR
figure
a = [-234670.868073+offset -234648.492546+offset ];
errors = [258.135212 258.242789];
bar(a);hold on
% errorbar(a,errors,'k','linestyle','none')
ax = gca();
% ax = gca;
ax.XAxis.FontSize = 12;
% ax.XAxis.TickLabelRotation = 45;
ax.YAxis.Label.FontSize = 12;
xtl = '\begin{tabular}{c} Rec \\ model \end{tabular}';
xtl_null = '\begin{tabular}{c} Ind \\ model \end{tabular}';

set(gca, 'XTickLabel', {xtl_null xtl}, 'TickLabelInterpreter', 'latex');
ylim([-ylimit 0])
yticklabels(cellfun(@(x) str2num(x)-offset, ax.YTickLabel, 'UniformOutput', false))

ylabel('LOO (a.u.)')

exportgraphics(gcf,[save_dir_figures '\\cluster_1_LOO_AND_XOR_limits.eps'],'BackgroundColor','none','ContentType','vector')

%% cluster 2 AND XOR
figure
a = [-233904.779839+offset -233861.544392+offset ];
errors = [266.538703 267.885261];
bar(a);hold on
% errorbar(a,errors,'k','linestyle','none')
ax = gca();
% ax = gca;
ax.XAxis.FontSize = 12;
% ax.XAxis.TickLabelRotation = 45;
ax.YAxis.Label.FontSize = 12;
xtl = '\begin{tabular}{c} Rec \\ model \end{tabular}';
xtl_null = '\begin{tabular}{c} Ind \\ model \end{tabular}';

set(gca, 'XTickLabel', {xtl_null xtl}, 'TickLabelInterpreter', 'latex');
ylim([-ylimit 0])
yticklabels(cellfun(@(x) str2num(x)-offset, ax.YTickLabel, 'UniformOutput', false))

ylabel('LOO (a.u.)')
exportgraphics(gcf,[save_dir_figures '\\cluster_2_LOO_AND_XOR_limits.eps'],'BackgroundColor','none','ContentType','vector')


%%
figure
a = [-234657.460352+offset -234669.553222+offset ];
errors = [240.297764 240.376022];
bar(a);hold on
% errorbar(a,errors,'k','linestyle','none')
ax = gca();
% ax = gca;
ax.XAxis.FontSize = 12;
% ax.XAxis.TickLabelRotation = 45;
ax.YAxis.Label.FontSize = 12;
xtl = '\begin{tabular}{c} Rec \\ model \end{tabular}';
xtl_null = '\begin{tabular}{c} Ind \\ model \end{tabular}';

set(gca, 'XTickLabel', {xtl_null xtl}, 'TickLabelInterpreter', 'latex');
ylim([-ylimit 0])
yticklabels(cellfun(@(x) str2num(x)-offset, ax.YTickLabel, 'UniformOutput', false))


ylabel('LOO (a.u.)')
exportgraphics(gcf,[save_dir_figures '\\cluster_3_LOO_AND_XOR_limits.eps'],'BackgroundColor','none','ContentType','vector')
close all