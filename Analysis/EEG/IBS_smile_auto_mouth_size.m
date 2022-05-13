function data = IBS_smile_auto_mouth_size(data,sub_dir,mouth_size_col_name)
%IBS_SMILE_AUTO_MOUTH_SIZE function that estimates smile from the mouth size
%
% SYNOPSIS: data = IBS_smile_auto_mouth_size(data)
%
% INPUT 
%
% OUTPUT 
%
% REMARKS
%
% created with MATLAB ver.: 9.8.0.1359463 (R2020a) Update 1 on Microsoft Windows 10 Pro Version 10.0 (Build 19042)
%
% created by: Atesh
% DATE: 25-Mar-2021
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin <3
    mouth_size_col_name = 'mouth_size';%'mouth_size';
end
% smoothing is already done in the main function
mouth_size_col = strcmp(data.Properties.VariableNames,mouth_size_col_name);
frame_rate = length(data.time_stamps_rel)/(data.time_stamps_rel(end)-data.time_stamps_rel(1));
minWindow = ceil(frame_rate)*1;
% minWindow = floor(frame_rate)*0.5;

% data.mouth_size = logical(1*(data{:,mouth_size_col} > nanmean(data{:,mouth_size_col})));
% this seems to be determining - without this, the smiles are not properly
% detected.
data.mouth_size = logical(1*(data{:,mouth_size_col} > nanmean(data{:,mouth_size_col}) + nanstd(data{:,mouth_size_col})));




% % the logic is that if there is less variability, participants are most
% % likely not smiling. while when there is more variation, it means they are
% % smiling more possibly?
% if nanstd(data{:,mouth_size_col})>1
% %     data.mouth_size = logical(1*(data{:,mouth_size_col} > nanmean(data{:,mouth_size_col})+ nanstd(data{:,mouth_size_col}));
% data.mouth_size = logical(1*(data{:,mouth_size_col} > nanmean(data{:,mouth_size_col}) + nanstd(data{:,mouth_size_col})));
% 
% else
%     
% % data.mouth_size = logical(1*(data{:,mouth_size_col} > nanmean(data{:,mouth_size_col}) + 2*nanstd(data{:,mouth_size_col})));
% data.mouth_size = logical(1*(data{:,mouth_size_col} > nanmean(data{:,mouth_size_col}) + 1.5*nanstd(data{:,mouth_size_col})));
% 
% end
% I just use it to remove small peaks
% change_locs = IBS_compute_sudden_changes(1*data{:,mouth_size_col},minWindow);
% 
% 
% data{:,mouth_size_col} = zeros(1,length(data{:,mouth_size_col}))';
% data{:,mouth_size_col}(change_locs) = 1;
% data{:,mouth_size_col} = logical(data{:,mouth_size_col});

end




%% old
% windowsize = 10;
% mouth_size_col_x = strcmp(data.Properties.VariableNames,[mouth_size_col_name '_x']);
% mouth_size_col_y = strcmp(data.Properties.VariableNames,[mouth_size_col_name '_y']);

% easier to remove random outliers from x and y and then compute euclidian
% distance

% data{:,mouth_size_col} = sqrt(smoothdata(data{:,mouth_size_col_x},'movmean',windowsize).^2 + smoothdata(smoothdata(data{:,mouth_size_col_y},'movmean',windowsize)).^2);
% 
% outlier_rows = data{:,mouth_size_col} <= 0;
% data{outlier_rows,mouth_size_col} = nan;

% data.(mouth_size_col_name) = smoothdata(data{:,mouth_size_col},'movmean',windowsize);


% if nanstd(data{:,mouth_size_col})>2
%     data.mouth_size = 1*(data{:,mouth_size_col} > nanmean(data{:,mouth_size_col}));
% 
% else
%     
% data.mouth_size = 1*(data{:,mouth_size_col} > nanmean(data{:,mouth_size_col}) + nanstd(data{:,mouth_size_col}));
% end

%% working method
% mouth_size_col = strcmp(data.Properties.VariableNames,mouth_size_col_name);
% 
% outlier_rows = data{:,mouth_size_col} <= 0;
% data{outlier_rows,mouth_size_col} = nan;
% windowsize = 5;
% data{:,mouth_size_col} = smoothdata(data{:,mouth_size_col},'movmean',windowsize);
% 
% 
% 
% if std(data{:,mouth_size_col})>2
%     data.smile_sd = 1*(data{:,mouth_size_col} > mean(data{:,mouth_size_col}));
% 
% else
%     
% data.smile_sd = 1*(data{:,mouth_size_col} > mean(data{:,mouth_size_col}) + std(data{:,mouth_size_col}));
% end



%% old ways

% jsonData = jsondecode(fileread([sub_dir '\\mouth_size.json']));
% 
% manual_selected_mouth_size = jsonData.('mouth_size');
% data.smile_sd = 1*(data{:,mouth_size_col} > manual_selected_mouth_size);
% outlier_values = mean(data{:,mouth_size_col})- 2 * std(data{:,mouth_size_col});
% outlier_rows = data{:,mouth_size_col} < outlier_values;
% 
% data{outlier_rows,mouth_size_col} = nan;

% outlier_rows = data{:,mouth_size_col} <= 0;
% data{outlier_rows,mouth_size_col} = nan;
% windowsize = 5;
% data{:,mouth_size_col} = smoothdata(data{:,mouth_size_col},'movmean',windowsize);
% data{:,mouth_size_col} = smoothdata(data{:,mouth_size_col});
% data.smile_sd = 1*(data{:,mouth_size_col} > (nanmin(data{:,mouth_size_col})));

% data.smile_sd = 1*(data{:,mouth_size_col} > (nanmin(data{:,mouth_size_col}) + 0.1*nanmin(data{:,mouth_size_col})));

% if std(data{:,mouth_size_col})>2
%     data.smile_sd = 1*(data{:,mouth_size_col} > mean(data{:,mouth_size_col}));
% 
% else
%     
% data.smile_sd = 1*(data{:,mouth_size_col} > mean(data{:,mouth_size_col}) + std(data{:,mouth_size_col}));
% end
% data.smile_sd = 1*(data{:,mouth_size_col} > median(data{:,mouth_size_col}));

% data.smile_sd = 1*(data{:,mouth_size_col} > manual_selected_mouth_size);
% data.smile_sd = 1*(data{:,mouth_size_col} > (manual_selected_mouth_size+ 0.1* manual_selected_mouth_size));


% data.smile_sd = 1*(data{:,mouth_size_col} > 42);
% std_dev = 2;
% data.smile_sd = 1*(data{:,mouth_size_col} > mean(data{:,mouth_size_col}) + std_dev * std(data{:,mouth_size_col}));




