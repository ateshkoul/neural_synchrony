function all_comb = create_non_identical_combinations(a,b,n)
%% function that creates combinations between two vectors 

elements_a = 1:length(a);
elements_b = length(a)+1:length(a)+length(b);

p = nchoosek([elements_a elements_b],n);

self_a = ismember(num2str(nchoosek([elements_a elements_b],n)),num2str(nchoosek(elements_a,n)),'rows');
self_b = ismember(num2str(nchoosek([elements_a elements_b],n)),num2str(nchoosek(elements_b,n)),'rows');
similar_a_b = ismember(num2str(nchoosek([elements_a elements_b],n)),num2str([elements_a;elements_b]'),'rows');


elements_p = p(setdiff(1:size(p),[find(self_a) find(self_b) find(similar_a_b)']),:);

combined_ = [a b];
for combination = 1:size(elements_p,1)
    
    all_comb{combination} = combined_(elements_p(combination,:));
end

% combinations = 
end