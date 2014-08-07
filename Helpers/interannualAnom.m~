function out = interannualAnom(input, times)

out = NaN(size(input));



clim = averageMonthly(input, times);

dv = datevec(times);
for i=1:length(input)
    dvi = dv(i,:);
    out(i) = input(i) - clim(dvi(2)); 
end

end