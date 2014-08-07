function makeDCPlotLong(dc, times, AMM)
trifilt = triang((24*6*30) - 1)./(24*6*15);
% sst = conv(dc.semimaj, trifilt, 'same');
[sst mtimes] = averageSSTMonthly(dc.semimaj, times);

sstanom = interannualAnom(sst, mtimes);
sstanoms = conv(sstanom, [1 1 1]./3, 'same');
clim = averageMonthly(dc.semimaj, times);
climr = repmat(clim, 16, 1);
figure
% plot(times, dc.semimaj, '--k', 'LineWidth', 1.0);
subplot(2,1,1)

plot(mtimes, sst, 'k', 'LineWidth', 2);

% plot(times, dc.semimaj, 'k', 'LineWidth', 2);
set(gca, 'xtick', datenum(1999:1:2014,1, 1));
datetick('x', 'yyyy', 'keepticks');
yt = get(gca, 'ytick');
hold on
plot(datenum(2008, 10, 13).*ones(size(yt)), yt, 'k');
plot(datenum(2009, 5, 18).*ones(size(yt)), yt, 'k');
plot(mtimes, climr, 'b');
hold off
ylim([0 .4]);
xlim([datenum(1999, 1, 1) datenum(2014,1,1)]);
grid on

ylabel('(\circ C)', 'FontSize', 16);
title('23W SST Diurnal Cycle Amplitude', 'FontSize', 16);

set(gca, 'FontSize', 16);

subplot(2,1,2)
plot(mtimes, sstanoms, 'k', 'LineWidth', 2);
set(gca, 'xtick', datenum(1999:1:2014,1, 1));
datetick('x', 'yyyy', 'keepticks');
yt = get(gca, 'ytick');
hold on
plot(datenum(2008, 10, 13).*ones(size(yt)), yt, 'k');
plot(datenum(2009, 5, 18).*ones(size(yt)), yt, 'k');
hold off
% ylim([0 .4]);
xlim([datenum(1999, 1, 1) datenum(2014,1,1)]);
grid on

ylabel('(\circ C)', 'FontSize', 16);
title('Interannual Anomaly', 'FontSize', 16);

set(gca, 'FontSize', 16);
set(gcf, 'Color', 'w');
set(gcf, 'Position', [0 0 1220  466]);
end