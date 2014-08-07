function [hrhigh hrlow] = riPhase( dataset, rivar)


rimax = maxDaily(rivar(:), dataset.descriptors.datesen(:));
rimin = minDaily(rivar(:), dataset.descriptors.datesen(:));


numDays = ceil(length(dataset.descriptors.datesen)/24);
outh = NaN * zeros(numDays, 1);
outl = outh;


[~, i] = max(rivar(1:21));
dv = datevec(dataset.descriptors.datesen(i));
outh(1) = dv(4);
[~, i] = min(rivar(1:21));
dv = datevec(dataset.descriptors.datesen(i));
outl(1) = dv(4);

averageCounter = 22;%First Full Day (by GMT)
for obsNum = 2:numDays-1
    [~, i] = max(rivar(averageCounter:averageCounter+23));
    dv = datevec(dataset.descriptors.datesen(i));
    outh(obsNum) = dv(4);
    [~, i] = min(rivar(averageCounter:averageCounter+23));
    dv = datevec(dataset.descriptors.datesen(i));
    outl(obsNum) = dv(4);
    
    
    
    averageCounter = averageCounter + 24;
end

%Finally do the partial last day
[~, i] = max(rivar(averageCounter:end));
dv = datevec(dataset.descriptors.datesen(i));
outh(end) = dv(4);
[~, i] = min(rivar(averageCounter:end));
dv = datevec(dataset.descriptors.datesen(i));
outl(end) = dv(4);

hrhigh = outh;
hrlow = outl;
end