function [out outtimes] = averageSSTMonthly(sst, times)

dv = datevec(times);

out = NaN([12*(2014-1998) 1]);
outtimes = out;

counter = 1;
for i=1998:2014
    for j=1:12
    
        inds = logical(dv(:,1)==i) & logical(dv(:,2) == j);
        
        out(counter) = nanmean(sst(inds));
        outtimes(counter) = datenum(i, j, 15);
        
        counter = counter+1;
    end
end

end