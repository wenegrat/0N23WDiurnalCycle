% Make Vert Struct Overview Plot
tri=triang(48-1)./24; %Following Kessler PDF
sst = dataset.density.fulldepth.temps(1,:)';
cmodDC = complex_demodulate_tri(sst, 1/24, tri);

gap = [.05 .1]; margh = .1; margw = .1;
[sstm mtimes] = averageSSTMonthly(sstDC.semimaj(505200:542000), data23.dates(505200:542000));

% Amp of DC
subtightplot(3, 1, 1, gap, margh, margw)
% plot(data23.dates(505200:542000), smooth(sstDC.semimaj(505200:542000), 6), 'k')
plot(dataset.descriptors.datesen, smooth(cmodDC.semimaj,20*24), 'k', 'LineWidth', 2);
% plot(mtimes, sstm, 'k');
    set(gca, 'xtick', datenum(2008,10:20,1));

set(gca, 'xlim', [dataset.descriptors.datesen(1) dataset.descriptors.datesen(end)]);
datetick('x', 'keeplimits', 'keepticks')
set(gca, 'ytick', 0:.1:.4, 'ylim', [0 .4]);
set(gca,'XTickLabel',[])

hold on
yt = get(gca, 'ytick');
plot(dataset.descriptors.datesen(trades(end)).*ones(size(yt)), yt, 'k');
plot(dataset.descriptors.datesen(calm(end)).*ones(size(yt)), yt, 'k');
grid on
hold off
ylabel({'SST Amp', '\circC'}, 'FontSize', 16);

% Wind Stress Mag
subtightplot(3,1,2, gap, margh, margw)
quiver(dataset.descriptors.datesend(:), 1, dataset.measures.uwndd', dataset.measures.vwndd', 'k');
% cb = colorbar;
% set(cb, 'visible', 'off');
    set(gca, 'xtick', datenum(2008,10:20,1));
set(gca, 'xlim', [dataset.descriptors.datesend(1) dataset.descriptors.datesend(end)]);

datetick('x', 'keeplimits', 'keepticks')
set(gca,'XTickLabel',[])
set(gca, 'YTick', -12:6:12);
axis equal
set(gca, 'xlim', [dataset.descriptors.datesend(1) dataset.descriptors.datesend(end)]);

% xlim([dataset.descriptors.datesen(daterange(1))-xaxisoffset dataset.descriptors.datesen(daterange(end))+xaxisoffset]);
ylabel({'Wind', 'm s^{-1}'}, 'FontSize', 16);
ylim([-12 12]);

hold on
yt = get(gca, 'ytick');
plot(dataset.descriptors.datesen(trades(end)).*ones(size(yt)), yt, 'k');
plot(dataset.descriptors.datesen(calm(end)).*ones(size(yt)), yt, 'k');
grid on
hold off

% SWR(monthly)
subtightplot(3, 1, 3, gap, margh, margw)
plot(dataset.descriptors.datesend, smooth(averageDaily(swnet,1, dataset.descriptors.datesen), 5), 'k', 'LineWidth', 2);
% plot(mtimes, sstm, 'k');
    set(gca, 'xtick', datenum(2008,10:20,1));

set(gca, 'xlim', [dataset.descriptors.datesen(1) dataset.descriptors.datesen(end)]);
datetick('x', 'keeplimits', 'keepticks')
set(gca, 'ytick', 120:40:280, 'ylim', [120 280]);
hold on
yt = get(gca, 'ytick');
plot(dataset.descriptors.datesen(trades(end)).*ones(size(yt)), yt, 'k');
plot(dataset.descriptors.datesen(calm(end)).*ones(size(yt)), yt, 'k');
grid on
hold off
ylabel({'SWR', 'W m^{-2}'}, 'FontSize', 16);
