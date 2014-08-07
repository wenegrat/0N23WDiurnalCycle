function plot23Inter(data23)

gap = [.03 .105]; margh = .1; margw = .1;

figure

% AMM
subtightplot(5,1,1, gap, margh, margw)
var = data23.AMM_sst;
vardates = data23.AMM_dates;
mask = (var>=0);
% bar(data23.AMM_dates, data23.AMM_sst, 'k', 'LineWidth', 2);
bar(vardates(mask), var(mask), 'r');



hold on
bar(vardates(~mask), var(~mask), 'b');
yt = get(gca, 'ytick');
plot(datenum(2008, 10, 13).*ones(size(yt)), yt, 'k');
plot(datenum(2009, 5, 18).*ones(size(yt)), yt, 'k');
xt = get(gca, 'xtick');
plot(xt, 0*xt, 'k', 'LineWidth', 1.5);

hold off
set(gca, 'xtick', datenum(1998:1:2014,1, 1), 'ylim', [-2.5 2.5], 'ytick', -2.5:1.25:2.5);
grid on

ylabel({'AMM Index',  ' '}, 'FontSize', 16);
xlim([datenum(1998, 1, 1) datenum(2014,1,1)]);

set(gca, 'FontSize', 16, 'xtickLabel', []);
title('23\circW Interannual Variability', 'FontSize', 16);
box on

% ATL3
subtightplot(5,1,2, gap, margh, margw)
var = data23.atl3;
vardates = data23.atl3dates;
mask = (var>=0);
% bar(data23.AMM_dates, data23.AMM_sst, 'k', 'LineWidth', 2);
bar(vardates(mask), var(mask), 'r');


hold on
bar(vardates(~mask), var(~mask), 'b');
yt = get(gca, 'ytick');

plot(datenum(2008, 10, 13).*ones(size(yt)), yt, 'k');
plot(datenum(2009, 5, 18).*ones(size(yt)), yt, 'k');
xt = get(gca, 'xtick');
plot(xt, 0*xt, 'k', 'LineWidth', 1.5);
hold off
set(gca, 'xtick', datenum(1998:1:2014,1, 1), 'ylim', [-1 1], 'ytick', -1:.5:1);
grid on

ylabel({'ATL3 Residuals',  '(\circC)'}, 'FontSize', 16);
xlim([datenum(1998, 1, 1) datenum(2014,1,1)]);

set(gca, 'FontSize', 16, 'xtickLabel', []);

% SST 
subtightplot(5,1,3, gap, margh, margw)
anom = interannualAnom(data23.sstDC, data23.sstDCdates);
anom = conv(anom, [1 1 1]./3,  'same');
plot(data23.sstDCdates, anom, 'k', 'LineWidth', 2);
yt = get(gca, 'ytick');

hold on
plot(datenum(2008, 10, 13).*ones(size(yt)), yt, 'k');
plot(datenum(2009, 5, 18).*ones(size(yt)), yt, 'k');
xt = get(gca, 'xtick');
plot(xt, 0*xt, 'k', 'LineWidth', 1.5);
hold off
set(gca, 'xtick', datenum(1998:1:2014,1, 1), 'ylim', [-.05 .05], 'ytick', -.05:.025:.05);
grid on

ylabel({'SST Amp.',  '(\circC)'}, 'FontSize', 16);
xlim([datenum(1998, 1, 1) datenum(2014,1,1)]);

set(gca, 'FontSize', 16, 'xtickLabel', []);

% Wind
subtightplot(5,1,4, gap, margh, margw)
anom = interannualAnom(data23.wind, data23.winddates);
anom = conv(anom, [1 1 1]./3,  'same');
plot(data23.winddates, anom, 'k', 'LineWidth', 2);
set(gca, 'xtick', datenum(1998:1:2014,1, 1), 'ylim', [-1 1], 'ytick', -1:.5:1);
yt = get(gca, 'ytick');
hold on
plot(datenum(2008, 10, 13).*ones(size(yt)), yt, 'k');
plot(datenum(2009, 5, 18).*ones(size(yt)), yt, 'k');
xt = get(gca, 'xtick');
plot(xt, 0*xt, 'k', 'LineWidth', 1.5);
hold off
grid on
ylabel({'Wind', '(m s^{-1})'}, 'FontSize', 16);
set(gca, 'FontSize', 16, 'xtickLabel', []);
xlim([datenum(1998, 1, 1) datenum(2014,1,1)]);


% % delta SST
% subtightplot(7,1,5, gap, margh, margw)
% 
% anom = interannualAnom(data23.tempdiff, data23.tempdiffdates);
% anom = conv(anom, [1 1 1]./3,  'same');
% 
% plot(data23.tempdiffdates, anom, 'k', 'LineWidth', 2);
% set(gca, 'xtick', datenum(1998:1:2014,1, 1), 'ylim', [-.1 .1], 'ytick', -.1:.05:.1);
% yt = get(gca, 'ytick');
% hold on
% plot(datenum(2008, 10, 13).*ones(size(yt)), yt, 'k');
% plot(datenum(2009, 5, 18).*ones(size(yt)), yt, 'k');
% hold off
% grid on
% ylabel({'\DeltaSST', '(\circC)'}, 'FontSize', 16);
% set(gca, 'FontSize', 16, 'xtickLabel', []);
% xlim([datenum(1998, 1, 1) datenum(2014,1,1)]);
% 
% % MLD & Z20
% 
% subtightplot(7,1,6, gap, margh, margw)
% 
% anom = interannualAnom(data23.mldT, data23.mldTdates);
% anom = conv(anom, [1 1 1]./3,  'same');
% 
% plot(data23.mldTdates, anom, 'LineWidth', 2, 'Color', 'k');
% 
% set(gca, 'xtick', datenum(1998:1:2014,1, 1), 'ylim', [-10 10],'ytick', -10:10:10, 'ydir', 'reverse');
% ylabel({'MLD, Z20', '(m)'}, 'FontSize', 16);
% yt = get(gca, 'ytick');
% 
% hold on
% plot(datenum(2008, 10, 13).*ones(size(yt)), yt, 'k');
% plot(datenum(2009, 5, 18).*ones(size(yt)), yt, 'k');
% % plot(data23.z20dates, data23.z20, 'LineWidth', 1.5, 'Color', 'k', 'LineStyle', '--');
% hold off
% xlim([datenum(1998, 1, 1) datenum(2014,1,1)]);
% grid on
% set(gca, 'FontSize', 16, 'xtickLabel', []);
% 

% Heat
subtightplot(5,1,5, gap, margh, margw)

anom = interannualAnom(data23.sw, data23.swdates);
anom = conv(anom, [1 1 1]./3,  'same');

plot(data23.swdates, anom, 'LineWidth', 2, 'Color', 'k');
set(gca, 'xtick', datenum(1998:1:2014,1, 1), 'ylim', [-40 40], 'ytick', -40:20:40);
ylabel({'SWR', '(W m^{-2})'}, 'FontSize', 16);
yt = get(gca, 'ytick');

hold on
plot(datenum(2008, 10, 13).*ones(size(yt)), yt, 'k');
plot(datenum(2009, 5, 18).*ones(size(yt)), yt, 'k');
xt = get(gca, 'xtick');
plot(xt, 0*xt, 'k', 'LineWidth', 1.5);
hold off
xlim([datenum(1998, 1, 1) datenum(2014,1,1)]);
grid on
datetick('x', 'yyyy', 'keeplimits', 'keepticks');

set(gca, 'FontSize', 16);

set(gcf, 'Color', 'w', 'Position', [0 0 963 694]);
end