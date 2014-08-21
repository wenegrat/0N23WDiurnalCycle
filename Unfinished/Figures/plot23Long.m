function plot23Long(data23)


pcolor = 'k';

gap = [.035 .105]; margh = .1; margw = .125;

figure

% SST 
subtightplot(5,1,1, gap, margh, margw)

plot(data23.sstDCdates, data23.sstDC, pcolor, 'LineWidth', 2);
yt = get(gca, 'ytick');

hold on
plot(datenum(2008, 10, 13).*ones(size(yt)), yt, 'k');
plot(datenum(2009, 5, 18).*ones(size(yt)), yt, 'k');
hold off
set(gca, 'xtick', datenum(1998:1:2014,1, 1), 'ylim', [0 .4], 'ytick', 0:.1:.4);
grid on

ylabel({'SST Amp.',  '(\circC)'}, 'FontSize', 16);
xlim([datenum(1998, 1, 1) datenum(2014,1,1)]);

set(gca, 'FontSize', 16, 'xtickLabel', []);
set(gca, 'GridLineStyle', '--')
title('23\circW', 'FontSize', 16);
axes_label('a)', 200, 50);

% Wind
subtightplot(5,1,2, gap, margh, margw)
plot(data23.winddates, data23.wind, pcolor, 'LineWidth', 2);
set(gca, 'xtick', datenum(1998:1:2014,1, 1), 'ylim', [0 10], 'ytick', 0:2.5:10);
yt = get(gca, 'ytick');
hold on
plot(datenum(2008, 10, 13).*ones(size(yt)), yt, 'k');
plot(datenum(2009, 5, 18).*ones(size(yt)), yt, 'k');
hold off
grid on
ylabel({'Wind', '(m s^{-1})'}, 'FontSize', 16);
set(gca, 'FontSize', 16, 'xtickLabel', []);
xlim([datenum(1998, 1, 1) datenum(2014,1,1)]);
set(gca, 'GridLineStyle', '--')
axes_label('b)', 200, 50);

% delta SST
subtightplot(5,1,3, gap, margh, margw)
plot(data23.tempdiffdates, data23.tempdiff, pcolor, 'LineWidth', 2);
set(gca, 'xtick', datenum(1998:1:2014,1, 1), 'ylim', [0 .25], 'ytick', 0:.0625:.3);
yt = get(gca, 'ytick');
hold on
plot(datenum(2008, 10, 13).*ones(size(yt)), yt, 'k');
plot(datenum(2009, 5, 18).*ones(size(yt)), yt, 'k');
hold off
grid on
ylabel({'\DeltaT', '(\circC)'}, 'FontSize', 16);
set(gca, 'FontSize', 16, 'xtickLabel', []);
xlim([datenum(1998, 1, 1) datenum(2014,1,1)]);
set(gca, 'GridLineStyle', '--')
axes_label('c)', 200, 50);

% MLD & Z20

subtightplot(5,1,4, gap, margh, margw)

plot(data23.mldTdates, data23.mldT, 'LineWidth', 2, 'Color', pcolor);

set(gca, 'xtick', datenum(1998:1:2014,1, 1), 'ylim', [0 120],'ytick', 0:30:120, 'ydir', 'reverse');
ylabel({'MLD, Z20', '(m)'}, 'FontSize', 16);
yt = get(gca, 'ytick');

hold on
plot(datenum(2008, 10, 13).*ones(size(yt)), yt, 'k');
plot(datenum(2009, 5, 18).*ones(size(yt)), yt, 'k');
plot(data23.z20dates, data23.z20, 'LineWidth', 1.5, 'Color', 'k', 'LineStyle', '--');
hold off
xlim([datenum(1998, 1, 1) datenum(2014,1,1)]);
grid on
set(gca, 'GridLineStyle', '--')

set(gca, 'FontSize', 16, 'xtickLabel', []);
axes_label('d)', 200, 50);

% Heat
subtightplot(5,1,5, gap, margh, margw)
plot(data23.swdates, data23.sw, 'LineWidth', 2, 'Color', pcolor);
set(gca, 'xtick', datenum(1998:1:2014,1, 1), 'ylim', [200 300], 'ytick', 200:25:300);
ylabel({'SWR, OLR', '(W m^{-2})'}, 'FontSize', 16);
yt = get(gca, 'ytick');

hold on
plot(datenum(2008, 10, 13).*ones(size(yt)), yt, 'k');
plot(datenum(2009, 5, 18).*ones(size(yt)), yt, 'k');
plot(data23.olrdates, data23.olr, 'LineWidth', 1.5, 'Color', 'k', 'LineStyle', '--');
hold off
xlim([datenum(1998, 1, 1) datenum(2014,1,1)]);
grid on
datetick('x', 'yyyy', 'keeplimits', 'keepticks');
set(gca, 'GridLineStyle', '--')

set(gca, 'FontSize', 16);
axes_label('e)', 200, 50);

set(gcf, 'Color', 'w', 'Position', [0 0 1117 842]);
end