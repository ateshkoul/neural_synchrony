function [ft_struct] = IBS_sort_order(ft_struct,sorted_order)

ft_struct.individual = ft_struct.individual(sorted_order,:,:);
end