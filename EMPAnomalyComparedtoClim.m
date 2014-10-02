[clim23 sste sstt] = averageMonthly(data23.sstDC, data23.sstDCdates); %OK already monthly averages
[clim23w we wt] = averageMonthly(data23.wind, data23.winddates); %OK already monthly averages
[clim23swr swre swrt] = averageMonthly(data23.sw, data23.swdates); %OK already monthly averages

shortssta = averageMonthly( cmodDC.semimaj, dataset.descriptors.datesen);
shortw = averageMonthly(dataset.measures.wspdh, dataset.descriptors.datesen);
shortswr = averageMonthly(swnet, dataset.descriptors.datesen);

mths = 3:5;
diffssta = mean(clim23(mths) - shortssta(mths))
diffwind = mean(clim23w(mths) - shortw(mths))
diffswr = mean(clim23swr(mths) - shortswr(mths))

close all
subplot(1,3,1)
plot(1:12, clim23);
hold on
plot(1:12, shortssta, '--b');
hold off
title('SSTA');

subplot(1,3,2)
plot(1:12, clim23w);
hold on
plot(1:12, shortw, '--b');
hold off
title('Wind');

subplot(1,3,3)
plot(1:12, clim23swr);
hold on
plot(1:12, shortswr, '--b');
hold off
title('SWR');



%%

% Do it directly from the long time series data

sstaANOM = interannualAnom(data23.sstDC, data23.sstDCdates);
windANOM = interannualAnom(data23.wind, data23.winddates);
swrANOM = interannualAnom(data23.sw, data23.swdates);

subplot(1,3,1)
ind1 = find(data23.sstDCdates > datenum(2008,10,1), 1, 'first');
ind2 = find(data23.sstDCdates > datenum(2009, 6, 1),1, 'first');

plot(datenum(2008, 10:1:18,1), sstaANOM(ind1:ind2));
datetick('x', 'mm');
title(num2str(mean(sstaANOM((ind1+5):(ind1+7)))))

subplot(1,3,2)
ind1 = find(data23.winddates > datenum(2008,10,1), 1, 'first');
ind2 = find(data23.winddates > datenum(2009, 6, 1),1, 'first');

plot(datenum(2008, 10:1:18,1), windANOM(ind1:ind2));
datetick('x', 'mm');
title(num2str(mean(windANOM((ind1+5):(ind1+7)))))

subplot(1,3,3)
ind1 = find(data23.swdates > datenum(2008,10,1), 1, 'first');
ind2 = find(data23.swdates > datenum(2009, 6, 1),1, 'first');

plot(datenum(2008, 10:1:18,1), swrANOM(ind1:ind2));
datetick('x', 'mm');
title(num2str(mean(swrANOM((ind1+5):(ind1+7)))))

