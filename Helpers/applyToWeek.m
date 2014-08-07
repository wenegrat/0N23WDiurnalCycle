function [out weekdates] = applyToWeek(input, func)
%input should be of length 5967
[ntimes ndepths] = size(input);

numweeks = 49; %skipping last half week
tstep = 5;
weekdates = datenum(2008, 10, 13, (3+24*tstep/2):(24*tstep):(3+24*tstep*numweeks), 0, 0); 

counter = 1;
for i=1:numweeks
    tempvar = input(counter:(counter+(24*tstep)),:);
    if (ndepths>1)
        tempvar = reshape(tempvar, (1+24*tstep)*ndepths, 1);
    end
    out(i) = func(tempvar);
    counter = counter + 24*tstep+1;
end

end