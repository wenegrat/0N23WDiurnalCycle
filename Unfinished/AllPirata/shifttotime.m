function out = shifttotime(input, sstdates, ldates)
        indbeg = find(sstdates(1) == ldates, 1);
%         indend = find(sstdates(end) == ldates, 1)
        
        lrem = length(ldates) - (length(sstdates) + indbeg-1);
        
        out = [NaN(indbeg-1, 1); input; NaN(lrem, 1)];
end