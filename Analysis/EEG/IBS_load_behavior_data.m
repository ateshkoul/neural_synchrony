function [behavior_data] = IBS_load_behavior_data(behavior,data_analysis_type,Dyads,condition,behav_analysis,analysis_sub_type,output_data,sub_behav_table)

if nargin <7
    output_data = 'only_joint';
    sub_behav_table = table();
    
end
behavior_params = IBS_get_behavior_type(behavior,behav_analysis,analysis_sub_type);
joint_covariate_fun = behavior_params.process_behav_data{1,1};

behav_type = behavior_params.behav_type{1,1};
norm_fun = behavior_params.norm_fun{1,1};

sub_behav_table.behav_analysis = behav_analysis;
sub_behav_table.analysis_sub_type = analysis_sub_type;
%
% e.g. import_fun = @IBS_import_pupil_csv_data
% e.g. import_fun = @IBS_import_gaze_positions_on_body_data
% varargin_table.norm_method = @(x) normalize(x);
% varargin_table.norm_method = 'range';
varargin_table.norm_method = 'zscore';
% according to bat paper:
% varargin_table.norm_method = 'norm';

% varargin_table.norm_method = @(x) x;
switch(behavior_params.behavior_type{1,1})
    
    case 'individual'
        
        
        behavior_data_sub_1 = cell(1,length(Dyads));
        behavior_data_sub_2 = cell(1,length(Dyads));
        joint_covariate_col = cell(1,length(Dyads));
        for Dyad_no = 1:length(Dyads)
            
            Sub_1 = 0;
            Sub_2 = 1;
            analysis_type_params = IBS_get_params_analysis_type(data_analysis_type);
            
            raw_data_dir = analysis_type_params.raw_data_dir{1,1};
            
            behavior_data_1 = cellfun(@(x) IBS_get_sub_behavior_data(behavior,Dyads(Dyad_no),Sub_1,x,raw_data_dir,sub_behav_table),condition,...
                'UniformOutput',false);
            
            behavior_data_2 = cellfun(@(x) IBS_get_sub_behavior_data(behavior,Dyads(Dyad_no),Sub_2,x,raw_data_dir,sub_behav_table),condition,...
                'UniformOutput',false);
            
            
            behavior_data_1 = cellfun(@(x) IBS_interpolate_behavior_data(x,behav_type),behavior_data_1,...
                'UniformOutput',false);
            behavior_data_2 = cellfun(@(x) IBS_interpolate_behavior_data(x,behav_type),behavior_data_2,...
                'UniformOutput',false);
            
            
            % this is ok here because there is a normalization at the corr
            % stage
            %              behavior_data_joint = cellfun(@(x,y) joint_covariate_fun(x,y),behavior_data_1,behavior_data_2,...
            %                 'UniformOutput',false);
            
            %             behavior_data_2 = IBS_interpolate_behavior_data(behavior_data_2,behav_type);
            
            % joint behavior has to be after interpolation as the data in
            % two subjects are different in dimensions for eye tracking.
            % but at the same time, it's necessary to have non-normalized
            % values for the joint function?
            behavior_data_joint = cellfun(@(x,y) joint_covariate_fun(x,y),behavior_data_1,behavior_data_2,...
                'UniformOutput',false);
            
            %             figure;
            %             plot(table2array(behavior_data_1{1,1}(:,1)))
            %             hold on
            %             plot(table2array(behavior_data_2{1,1}(:,1)))
            %             plot(table2array(behavior_data_joint{1,1}(:,1)))
            % %             xlim([0 100])
            % %             ylim([-3 12])
            %             title(analysis_sub_type,'Interpreter','none')
            
            %             joint_covariate_col{Dyads(Dyad_no)} = [ joint_covariate_fun(behavior_data_1,behavior_data_2) repmat(Dyads(Dyad_no),size(behavior_data_1,1),1)];
            %
            %             % add subject column here
            %             behavior_data_sub_1{Dyads(Dyad_no)} = [behavior_data_1 repmat(Dyads(Dyad_no),size(behavior_data_1,1),1)];
            %             behavior_data_sub_2{Dyads(Dyad_no)} = [behavior_data_2 repmat(Dyads(Dyad_no),size(behavior_data_2,1),1)];
            
            %             joint_covariate_col{Dyads(Dyad_no)} = table(joint_covariate_fun(behavior_data_1,behavior_data_2),...
            %                 repmat(Dyads(Dyad_no),size(behavior_data_1,1),1),'VariableNames',{'behavior_data_joint','Dyad_no'});
            
            
            behavior_data_1 = cellfun(@(x) norm_fun(x,varargin_table.norm_method),behavior_data_1,...
                'UniformOutput',false);
            
            behavior_data_2 = cellfun(@(x) norm_fun(x,varargin_table.norm_method),behavior_data_2,...
                'UniformOutput',false);
            
            
            % alternate location for the joint function - after individual norm
            %            behavior_data_joint = cellfun(@(x,y) joint_covariate_fun(x,y),behavior_data_1,behavior_data_2,...
            %                 'UniformOutput',false);
            %
            behavior_data_joint = cellfun(@(x) norm_fun(x,varargin_table.norm_method),behavior_data_joint,...
                'UniformOutput',false);
            %
            
            %              behavior_data_1 = cellfun(@(x,y) [x table(repmat(y,size(x,1),1),...
            %                  'VariableNames',{['condition_' behavior]})],behavior_data_1,condition,...
            %                 'UniformOutput',false);
            %
                        behavior_data_2 = cellfun(@(x,y) [x table(repmat(y,size(x,1),1),...
                             'VariableNames',{['condition_' behavior]})],behavior_data_2,condition,...
                            'UniformOutput',false);
            %
            behavior_data_joint = cellfun(@(x,y) [x table(repmat(y,size(x,1),1),...
                'VariableNames',{['condition_' behavior]})],behavior_data_joint,condition,...
                'UniformOutput',false);
            
            
            
            behavior_data_1 = cat(1,behavior_data_1{:});
            behavior_data_2 = cat(1,behavior_data_2{:});
            behavior_data_joint = cat(1,behavior_data_joint{:});
            
            
            %             behavior_data_1 = norm_fun(behavior_data_1,varargin_table.norm_method);
            %             behavior_data_2 = norm_fun(behavior_data_2,varargin_table.norm_method);
            %             behavior_data_joint = norm_fun(behavior_data_joint,varargin_table.norm_method);
            
            % add subject column only here
            behavior_data_sub_1{Dyads(Dyad_no)} = behavior_data_1;
%             behavior_data_sub_1{Dyads(Dyad_no)} = [behavior_data_1 table(repmat([ 'Dyad_' sprintf('%0.2d',Dyads(Dyad_no))],size(behavior_data_1,1),1),...
%                 'VariableNames',{['Dyad_no_' behavior]})];
            %
             behavior_data_sub_2{Dyads(Dyad_no)} = behavior_data_2;
%             behavior_data_sub_2{Dyads(Dyad_no)} = table(behavior_data_2,...
%                 repmat(Dyads(Dyad_no),size(behavior_data_2,1),1),'VariableNames',{'behavior_data_2','Dyad_no'});
%             
            behavior_data_sub_2{Dyads(Dyad_no)} = [behavior_data_2 table(repmat([ 'Dyad_' sprintf('%0.2d',Dyads(Dyad_no))],size(behavior_data_1,1),1),...
                'VariableNames',{['Dyad_no_' behavior]})];
            

            %             joint_covariate_col{Dyads(Dyad_no)} = behavior_data_joint;
            joint_covariate_col{Dyads(Dyad_no)} = [behavior_data_joint table(repmat([ 'Dyad_' sprintf('%0.2d',Dyads(Dyad_no))],size(behavior_data_1,1),1),...
                'VariableNames',{['Dyad_no_' behavior]})];
            %
            %             joint_covariate_col{Dyads(Dyad_no)} = joint_covariate_fun(behavior_data_1,behavior_data_2);
            %
            %             behavior_data_sub_1{Dyads(Dyad_no)} = behavior_data_1 ;
            %             behavior_data_sub_2{Dyads(Dyad_no)} = behavior_data_2 ;
            
            
            %             % add subject column only here
            %             behavior_data_sub_1{Dyad_no} = behavior_data_1;
            % %             behavior_data_sub_1{Dyads(Dyad_no)} = [behavior_data_1 table(repmat([ 'Dyad_' sprintf('%0.2d',Dyads(Dyad_no))],size(behavior_data_1,1),1),...
            % %                 'VariableNames',{['Dyad_no_' behavior]})];
            % %
            %             %             behavior_data_sub_2{Dyads(Dyad_no)} = table(behavior_data_2,...
            %             %                 repmat(Dyads(Dyad_no),size(behavior_data_2,1),1),'VariableNames',{'behavior_data_2','Dyad_no'});
            %
            %             behavior_data_sub_2{Dyad_no} = behavior_data_2;
            % %             joint_covariate_col{Dyads(Dyad_no)} = behavior_data_joint;
            %             joint_covariate_col{Dyad_no} = [behavior_data_joint table(repmat([ 'Dyad_' sprintf('%0.2d',Dyads(Dyad_no))],size(behavior_data_1,1),1),...
            %                 'VariableNames',{['Dyad_no_' behavior]})];
            
        end
        
        switch(output_data)
            case 'only_joint'
                behavior_data = {joint_covariate_col};
            case 'no_joint'
                behavior_data = {behavior_data_sub_1 behavior_data_sub_2};
            case 'all'
                behavior_data = {behavior_data_sub_1 behavior_data_sub_2 joint_covariate_col};
                
        end
    case 'joint'
        
        behavior_data_sub_1 = cell(1,length(Dyads));
        behavior_data_sub_2 = cell(1,length(Dyads));
        for Dyad_no = 1:length(Dyads)
            
            Sub_1 = 0;
            Sub_2 = 1;
            analysis_type_params = IBS_get_params_analysis_type(data_analysis_type);
            
            raw_data_dir = analysis_type_params.raw_data_dir{1,1};
            
            behavior_data_1 = IBS_get_sub_behavior_data(behavior,Dyads(Dyad_no),Sub_1,condition,raw_data_dir);
            behavior_data_2 = IBS_get_sub_behavior_data(behavior,Dyads(Dyad_no),Sub_2,condition,raw_data_dir);
            
            % add subject column here
            behavior_data_sub_1{Dyads(Dyad_no)} = [behavior_data_1 repmat(Dyads(Dyad_no),size(behavior_data_1,1),1)];
            behavior_data_sub_2{Dyads(Dyad_no)} = [behavior_data_2 repmat(Dyads(Dyad_no),size(behavior_data_2,1),1)];
        end
        
        
        behavior_data = {behavior_data_sub_1 behavior_data_sub_2};
        
    case 'joint_comb'
        
        behavior_data_sub_1 = cell(1,length(Dyads));
        behavior_data_sub_2 = cell(1,length(Dyads));
        joint_covariate_col = cell(1,length(Dyads));
        
        comb_behaviors = strsplit(behavior,'-');
        
        behav_combs = nchoosek(comb_behaviors,2);
        
        
        
        
        for Dyad_no = 1:length(Dyads)
            
            Sub_1 = 0;
            Sub_2 = 1;
            analysis_type_params = IBS_get_params_analysis_type(data_analysis_type);
            
            raw_data_dir = analysis_type_params.raw_data_dir{1,1};
            
            behaviors_data_1 = cellfun(@(behav) cellfun(@(x) IBS_get_sub_behavior_data(behav,Dyads(Dyad_no),Sub_1,x,raw_data_dir,sub_behav_table),condition,...
                'UniformOutput',false),comb_behaviors,'UniformOutput',false);
            
            behaviors_data_2 = cellfun(@(behav) cellfun(@(x) IBS_get_sub_behavior_data(behav,Dyads(Dyad_no),Sub_2,x,raw_data_dir,sub_behav_table),condition,...
                'UniformOutput',false),comb_behaviors,'UniformOutput',false);
            
            
            behavior_data_1 = cellfun(@(behav_data) cellfun(@(x) IBS_interpolate_behavior_data(x,behav_type),behav_data,...
                'UniformOutput',false),behaviors_data_1,'UniformOutput',false);
            
            behavior_data_2 = cellfun(@(behav_data) cellfun(@(x) IBS_interpolate_behavior_data(x,behav_type),behav_data,...
                'UniformOutput',false),behaviors_data_2,'UniformOutput',false);
            
            behavior_data_joint = create_non_identical_combinations(behavior_data_1,behavior_data_2,2);
            
            %        joint_covariate_fun = @(x,y) array2table(IBS_compute_vector_angle(table2array(x),table2array(y)),...
            %            'VariableNames',strcat(strrep(x.Properties.VariableNames,'eye_gaze_distance','eye'),...
            %            strrep(y.Properties.VariableNames,'eye_gaze_distance','eye')));
            
            %        joint_covariate_comb_fun = @(x,y) cellfun(@(s,t) array2table(table2array(s).*table2array(t),...
            %            'VariableNames',strcat(s.Properties.VariableNames,t.Properties.VariableNames)),x,y,'UniformOutput',0);
            
            joint_covariate_comb_fun = behavior_params.joint_covariate_comb_fun{1,1};
            
            %         joint_covariate_fun = @(x,y) cellfun(@(s,t) array2table(IBS_compute_vector_angle(table2array(s),table2array(t)),...
            %            'VariableNames',strcat(strrep(s.Properties.VariableNames,'eye_gaze_distance','eye'),...
            %            strrep(t.Properties.VariableNames,'eye_gaze_distance','eye'))),x,y,'UniformOutput',0);
            
            behavior_data_joint = cellfun(@(behav_data) joint_covariate_comb_fun(behav_data{1,1},behav_data{1, 2}),...
                behavior_data_joint,'UniformOutput',false);
            
            behavior_data_joint = joint_covariate_fun(behavior_data_joint{1,1},behavior_data_joint{1,2});
            
            %             behavior_data_joint = cellfun(@(x,y) (x,y),behavior_data_joint{1,1},behavior_data_2,...
            %                 'UniformOutput',false);
            
            
            
            %%
            
            behavior_data_1 = cellfun(@(behav) cellfun(@(x) norm_fun(x,varargin_table.norm_method),behav,...
                'UniformOutput',false),behaviors_data_1,'UniformOutput',false);
            
            
            behavior_data_2 = cellfun(@(behav) cellfun(@(x) norm_fun(x,varargin_table.norm_method),behav,...
                'UniformOutput',false),behaviors_data_2,'UniformOutput',false);
            
            
            % alternate location for the joint function - after individual norm
            %            behavior_data_joint = cellfun(@(x,y) joint_covariate_fun(x,y),behavior_data_1,behavior_data_2,...
            %                 'UniformOutput',false);
            %
            behavior_data_joint = cellfun(@(x) norm_fun(x,varargin_table.norm_method),behavior_data_joint,...
                'UniformOutput',false);
            %
            
            %              behavior_data_1 = cellfun(@(x,y) [x table(repmat(y,size(x,1),1),...
            %                  'VariableNames',{['condition_' behavior]})],behavior_data_1,condition,...
            %                 'UniformOutput',false);
            %
            %             behavior_data_2 = cellfun(@(x,y) [x table(repmat(y,size(x,1),1),...
            %                  'VariableNames',{['condition_' behavior]})],behavior_data_2,condition,...
            %                 'UniformOutput',false);
            behavior = strrep(behavior,'video_openpose_landmarks_manual_cleaned','video');
            
            behavior = strrep(behavior,'Gaze_nose_dist','Gaze');
            
            behavior_data_joint = cellfun(@(x,y) [x table(repmat(y,size(x,1),1),...
                'VariableNames',{['condition_' behavior]})],behavior_data_joint,condition,...
                'UniformOutput',false);
            
            
            
            behavior_data_1 = cat(1,behavior_data_1{:});
            behavior_data_2 = cat(1,behavior_data_2{:});
            behavior_data_joint = cat(1,behavior_data_joint{:});
            
            
            
            % add subject column only here
            behavior_data_sub_1{Dyads(Dyad_no)} = behavior_data_1;
            
            behavior_data_sub_2{Dyads(Dyad_no)} = behavior_data_2;
            %             joint_covariate_col{Dyads(Dyad_no)} = behavior_data_joint;
            joint_covariate_col{Dyads(Dyad_no)} = [behavior_data_joint table(repmat([ 'Dyad_' sprintf('%0.2d',Dyads(Dyad_no))],size(behavior_data_joint,1),1),...
                'VariableNames',{['Dyad_no_' behavior]})];
            
            joint_covariate_col{Dyads(Dyad_no)}.Properties.VariableNames=  strrep(joint_covariate_col{Dyads(Dyad_no)}.Properties.VariableNames,...
                'Gaze_nose_dist','Gaze');
            joint_covariate_col{Dyads(Dyad_no)}.Properties.VariableNames = strrep(joint_covariate_col{Dyads(Dyad_no)}.Properties.VariableNames,...
                'video_openpose_landmarks_manual_cleaned','video');
        end
        
        switch(output_data)
            case 'only_joint'
                behavior_data = {joint_covariate_col};
            case 'no_joint'
                behavior_data = {behavior_data_sub_1 behavior_data_sub_2};
            case 'all'
                behavior_data = {behavior_data_sub_1 behavior_data_sub_2 joint_covariate_col};
                
        end
end
end




%% old way
% behavior_data_1 = IBS_get_sub_behavior_data(behavior,Dyads(Dyad_no),Sub_1,condition,raw_data_dir);
%         behavior_data_2 = IBS_get_sub_behavior_data(behavior,Dyads(Dyad_no),Sub_2,condition,raw_data_dir);
%
%
%         behavior_data_1 = IBS_interpolate_behavior_data(behavior_data_1,behav_type);
%         behavior_data_2 = IBS_interpolate_behavior_data(behavior_data_2,behav_type);
%
%         % joint behavior has to be after interpolation as the data in
%         % two subjects are different in dimensions for eye tracking.
%         % but at the same time, it's necessary to have non-normalized
%         % values for the joint function?
%         behavior_data_joint = joint_covariate_fun(behavior_data_1,behavior_data_2);
%
%
%         %             joint_covariate_col{Dyads(Dyad_no)} = [ joint_covariate_fun(behavior_data_1,behavior_data_2) repmat(Dyads(Dyad_no),size(behavior_data_1,1),1)];
%         %
%         %             % add subject column here
%         %             behavior_data_sub_1{Dyads(Dyad_no)} = [behavior_data_1 repmat(Dyads(Dyad_no),size(behavior_data_1,1),1)];
%         %             behavior_data_sub_2{Dyads(Dyad_no)} = [behavior_data_2 repmat(Dyads(Dyad_no),size(behavior_data_2,1),1)];
%
%         %             joint_covariate_col{Dyads(Dyad_no)} = table(joint_covariate_fun(behavior_data_1,behavior_data_2),...
%         %                 repmat(Dyads(Dyad_no),size(behavior_data_1,1),1),'VariableNames',{'behavior_data_joint','Dyad_no'});
%
%         behavior_data_1 = norm_fun(behavior_data_1,varargin_table.norm_method);
%         behavior_data_2 = norm_fun(behavior_data_2,varargin_table.norm_method);
%         behavior_data_joint = norm_fun(behavior_data_joint,varargin_table.norm_method);
%
%         % add subject column only here
%         behavior_data_sub_1{Dyads(Dyad_no)} = [behavior_data_1 table(repmat(Dyads(Dyad_no),size(behavior_data_1,1),1),repmat(condition,size(behavior_data_1,1),1),...
%             'VariableNames',{['Dyad_no_' behavior],['condition_' behavior]})];
%
%         %             behavior_data_sub_2{Dyads(Dyad_no)} = table(behavior_data_2,...
%         %                 repmat(Dyads(Dyad_no),size(behavior_data_2,1),1),'VariableNames',{'behavior_data_2','Dyad_no'});
%
%         behavior_data_sub_2{Dyads(Dyad_no)} = behavior_data_2;
% %             joint_covariate_col{Dyads(Dyad_no)} = behavior_data_joint;
%         joint_covariate_col{Dyads(Dyad_no)} = [behavior_data_joint table(repmat(Dyads(Dyad_no),size(behavior_data_1,1),1),repmat(condition,size(behavior_data_1,1),1),...
%             'VariableNames',{['Dyad_no_' behavior],['condition_' behavior]})];
%         %
%         %             joint_covariate_col{Dyads(Dyad_no)} = joint_covariate_fun(behavior_data_1,behavior_data_2);
%         %
%         %             behavior_data_sub_1{Dyads(Dyad_no)} = behavior_data_1 ;
%         %             behavior_data_sub_2{Dyads(Dyad_no)} = behavior_data_2 ;
%
%
%
%

