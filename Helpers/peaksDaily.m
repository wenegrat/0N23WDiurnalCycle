function out = peaksDaily(input, depths)

% outtiled = NaN(size(input));
[ntimes ndepths] = size(input);

numDays = ceil(ntimes/24);
out = zeros(ndepths, ntimes);

for i=1:ndepths
 [~, ind] = findpeaks(input(1:21,i), 'NPEAKS', 1);
 if (~isempty(ind))
 out(i, ind) = 1;
 end
% outtiled(1:21) = out(1)*ones(21, 1);

averageCounter = 22;%First Full Day (by GMT)
for obsNum = 2:numDays-1
    [~, ind] = findpeaks(input(averageCounter:averageCounter+23, i), 'NPEAKS', 1);
    if (~isempty(ind))
     out(i,averageCounter + ind -1) = 1;
    end
%     outtiled(averageCounter:averageCounter+23) = out(obsNum).*ones(24,1);
    averageCounter = averageCounter + 24;
end

%Finally do the partial last day
[~, ind] = findpeaks(input(averageCounter:end, i), 'NPEAKS', 1);
if (~isempty(ind))
out(i,averageCounter + ind -1) = 1;
end
% outtiled(averageCounter:end) = out(end)*ones(size(averageCounter:length(input)));

end
end