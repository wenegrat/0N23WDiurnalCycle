function out = calcdiffs(input, depths)
[~, ntimes] = size(input);
out = NaN(ntimes, 1);
warning('off', 'all');
for i=1:ntimes
    mask = isfinite(input(:,i));
    if sum(mask)>=2
     fivemt = interp1(depths(mask), input(mask,i), 5);
     out(i) = input(1,i) - fivemt;
    end
end
warning('on', 'all')
end