

windowSizes = [  2 3 4 5 10 15 20 25 30];
for window = 1:length(windowSizes)
    window_length = windowSizes(window);
f_name = sprintf('D:\\Atesh\\IBS\\Data\\Moving_window\\no_aggressive_trialwise_CAR\\trialwise_moving_centered_corr_%d_window_1_95_all_dyads_baseline_normchange_0_120s_CAR.mat',window_length);
load(f_name)
s = cellfun(@(x) cellfun(@(y) cellfun(@(t) squeeze(std(t,0,2)),y,...
    'UniformOutput',false),x,'UniformOutput',false),moving_correlation,'UniformOutput',false);


combine_std = @(x) std(cat(3,x{:}),0,3);

combined_std = cellfun(@(x) cellfun(@(y) combine_std(y),x,...
    'UniformOutput',false),s,'UniformOutput',false);

combine_mean = @(x) mean(cat(3,x{:}),3);

combined_mean = cellfun(@(x) cellfun(@(y) combine_mean(y),x,...
    'UniformOutput',false),s,'UniformOutput',false);



std_all_sub = cat(1,combined_mean{:});
std_across_sub = arrayfun(@(x) mean(cat(3,std_all_sub{:,x}),3),1:size(std_all_sub,2),'UniformOutput',false);



std_all_cond = mean(cat(3,std_across_sub{:}),3);
figure('units','normalized','outerposition',[0 0 1 1]);imagesc(std_all_cond);colorbar

saveas(gcf,['std_all_cond_window_' num2str(window_length) '.tif'])
end


