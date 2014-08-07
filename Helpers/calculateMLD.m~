function mld = calculateMLD(dens, depths, crit)
[~, ntimes] = size(dens);

finedepths = linspace(depths(1), depths(end), 500);

mld = NaN(ntimes, 1);
for i=1:ntimes
    mask = isfinite(dens(:,i));
    if (sum(mask)>=2)
        finedens = interp1(depths(mask), sort(dens(mask,i), 'descend'), finedepths);
    
        ind = find(abs(finedens - dens(1,i)) > crit, 1);
        if (~isempty(ind))
            mld(i) = finedepths(ind);
        end
    end
end

end