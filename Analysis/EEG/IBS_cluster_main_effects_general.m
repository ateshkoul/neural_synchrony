function [stat] = IBS_cluster_main_effects_general(combined_correlations,levels,test_freq,varargin_table,cluster_cfg)
%% function to perform cluster based stats
% combined_correlations: (cell) ncond x nchan x nfreq cells e.g. repmat({ones(64,95)},23,7)
% levels               : (table) a table describing condition groups -Between subject parameter for rows, within subject in cols
% test_freq            : (array) freq values at which to test
% varargin_table       : (table) table with properties of 
% cluster_cfg          : (fieldtrip cfg) cfg file for cluster based stats

%% level table examples
% for a mixed design
% sub_group_1 = [1,5,7,8,12,13,19,22];
% sub_group_2 = [3,6,10,11,15,17,18,20,21,23];
% sub_group_3 = [2,4,9,14,16];
% 
% all_sub = nan(1,23);
% all_sub(sub_group_1) = 1;
% all_sub(sub_group_2) = 2;
% all_sub(sub_group_3) = 3;
% 
% levels = table();
% levels.Between = all_sub; % first factor between subject
% levels.Within = [1 2]; % second within subject factor

% depending on the design things would change -.
% example:
% % for mixed 2x2
% levels = table();
% levels.Between = [repmat(1,1,8) repmat(1,1,10) repmat(3,1,5)];
% levels.Within = [1 2];

% % for within 2x2
% levels = table();
% levels.Within_1 = [1 1 2 2];
% levels.Within_2 = [1 2 1 2];


%% anova table examples
% e.g.
% anova_table = table();
% anova_table.anova_design = '1'; % for one way anova, 2x3 for 2 by 3 anova
% anova_table.test_type = {'one_way_anova'}; % for 1 way anova,
% {'two_sample_paired','two_sample_independent'} for paired ttest on first
% factor and an independent ttest on the 2nd factor.
% other example {'two_sample_paired','one_way_anova'}
% test_type = {'one_way_anova','two_sample_paired'};

%% script checked for one-way anova, 2x2 repeated measures anova and 2x3 mixed anova

% script for main effects of a generic nxn ANOVA

if nargin <5

    cluster_cfg = IBS_get_anova_cluster_cfg();
end




%%

xpos_in_str  = strfind(varargin_table.anova_design,'x');
levels_pos   = [1 xpos_in_str+1];
Man_levels   = [];
for f = 1: length(levels_pos)
    Man_levels = [Man_levels str2num(varargin_table.anova_design(levels_pos(f)))];
end



% average_cond_fun = @(y) arrayfun(@(x) IBS_subs_data(template_struct,mean(cat(3,y{x,:}),3)),1:size(y,1),'UniformOutput',false);
average_cond_fun = @(y) arrayfun(@(x) mean(cat(3,y{x,:}),3),1:size(y,1),'UniformOutput',false);
    

test_type = varargin_table.test_type;
stat = cell(1,length(Man_levels));
for main_effect_no = 1:length(Man_levels)
    if (contains(levels.Properties.VariableNames{main_effect_no},'Within'))
        % goes in the col
        cur_level = levels.(levels.Properties.VariableNames{main_effect_no});
        
        unique_levels = unique(cur_level);
        combined_correlation_levels = cell(1,length(unique_levels));
        for level_no = 1:length(unique_levels)
            combined_correlation_levels{level_no} = combined_correlations(:,cur_level==unique_levels(level_no));
            
        end
        
        % transpose is important here
        avg_combined_correlation_main_effect = cellfun(@(x) average_cond_fun(x)',combined_correlation_levels,'UniformOutput',false);
        
        avg_combined_correlation_main_effect = cat(2,avg_combined_correlation_main_effect{:});
        
        sub_levels = arrayfun(@(x) repmat(x,1,size(avg_combined_correlation_main_effect,1)),1:size(avg_combined_correlation_main_effect,2),'UniformOutput',false);
        sub_levels = cat(2,sub_levels{:});
    else
        if (contains(levels.Properties.VariableNames{main_effect_no},'Between'))
            % between factor            % goes in the row
            cur_level = levels.(levels.Properties.VariableNames{main_effect_no});
            unique_levels = unique(cur_level);
            
            for level_no = 1:length(unique_levels)
                
                combined_correlation_levels{level_no} = combined_correlations(cur_level==unique_levels(level_no),:);
                
            end
            
            % transpose is important here
            avg_combined_correlation_main_effect = cellfun(@(x) average_cond_fun(x)',combined_correlation_levels,'UniformOutput',false);
            
            avg_combined_correlation_main_effect = cat(1,avg_combined_correlation_main_effect{:});
            
            sub_levels = arrayfun(@(x) repmat(x,1,sum(cur_level==x)),unique_levels,'UniformOutput',false);
            sub_levels = cat(2,sub_levels{:});
        else
            error('wrong level name');
        end
    end  
    
    
    switch(test_type{main_effect_no})
        
        case 'two_sample_paired'
            cur_test_type = 'paired';
          stat{main_effect_no} = IBS_cluster_two_sample(avg_combined_correlation_main_effect,test_freq,sub_levels,cur_test_type,cluster_cfg);            
        case 'two_sample_independent'
            cur_test_type = 'independent';
          stat{main_effect_no} = IBS_cluster_two_sample(avg_combined_correlation_main_effect,test_freq,sub_levels,cur_test_type,cluster_cfg);
        case 'one_way_anova_independent'            
            stat{main_effect_no} = IBS_cluster_one_way_anova(avg_combined_correlation_main_effect,test_freq,sub_levels,cluster_cfg);
            
    end
    clear avg_combined_correlation_main_effect combined_correlation_levels
end

end


%
% [FieldTrip] depsamplesF
% Eric Maris e.maris at donders.ru.nl
% Fri Jan 28 10:43:42 CET 2011
% Previous message (by thread): [FieldTrip] depsamplesF
% Next message (by thread): [FieldTrip] help with inverse computing
% Messages sorted by: [ date ] [ thread ] [ subject ] [ author ]
% Hi Tom,
%
%
%
%
%
% To test main and interaction effects in your 2x2 within subjects design, you
% have to perform 3 tests, each using the statfun desamplesT. Say you have the
% output of ft_timelockanalysis for all four conditions: tlout_Ia, tlout_Ib,
% tlout_IIa, tlout_IIb. Your then proceed as follows:
%
%
%
% 1.   Main effect of I versus II: calculate the mean of tlout_Ia.avg and
% tlout_Ib.avg and put this is a a new struct variable tlout_I, which has the
% same fields as tlout_Ia and tlout_Ib. Do the same with tlout_IIa.avg and
% tlout_IIb.avg and make a new struct variable tlout_II. Then run
% ft_timelockstatistics with input arguments tlout_I and tlout_II. With this
% analysis you will test the main effect of I-versus-II.
%
% 2.   In the same way, you now test the main effect of a versus b. In your
% calculations, the roles of (I,II) and (a,b) are now reversed.
%
% 3.   Interaction of I-vs-II and a-vs-b. Calculate the differences
% (tlout_Ia.avg-tlout_Ib.avg) and (tlout_IIa.avg-tlout_IIb.avg), put them in
% output structures and statistically compare them using
% ft_timelockstatistics. With this analysis, you test the interaction of
% I-vs-II and a-vs-b.
%
%
%
% There is no need for Bonferroni correction or an adjustment of
% cfg.clusteralpha (which does not affect the false alarm rate anyhow) and
% cfg.alpha.
%
%
%
%
%
% Best,
%
%
%
% Eric Mari