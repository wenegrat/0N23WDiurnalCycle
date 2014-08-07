% Climatological Values
% [clim23 sste sstt] = averageMonthly(data23.sstDC, data23.sstDCdates);
% [clim23w we wt] = averageMonthly(data23.wind, data23.winddates);
% [clim23swr swre swrt] = averageMonthly(data23.sw, data23.swdates);
% [climMLD] = averageMonthly(data23.z20, data23.z20dates);
% 
% % clim23 = circshift(clim23, 3);
% % clim24w = circshift(clim23w, 3);
% clim23swr = circshift(clim23swr, 3);

% EMP Variables
% [empSST] = averageMonthly(cmodDC.semimaj, dataset.descriptors.datesen);
% [empWS] = averageMonthly(dataset.measures.wspdh, dataset.descriptors.datesen);
% [empZ20] = averageMonthly(data23.z20(116:124), data23.z20dates(116:124));

bins = 4:7;
rivar = dataset.deepadcp.riforwardreduce_sort(:,bins);
for i=1:5967
    ridcav(i) = nanmedian(rivar(i,:));
end
empRI = averageMonthly(ridcav, dataset.descriptors.datesen);


% Plotting
% ===================
close all
figure
subplot(4,1,1)
h1 = plot(datenum(1998, 1:12, 1), clim23, '--k', 'LineWidth', 2);
set(gca, 'FontSize', 16);
set(get(gca, 'ylabel'), 'string', '\circC', 'FontSize', 16);
set(gca, 'xtick', datenum(1998, 1:12, 1), 'xlim', [datenum(1998, 1, 1) datenum(1998, 12, 1)]);
datetick('x', 'm', 'keepticks', 'keeplimits');
grid on
set(gca, 'GridLineStyle', '--')
box on
hold on
plot(datenum(1998,1:12, 1), empSST, 'k', 'LineWidth', 2);
hold off
title('23\circW Climatology', 'FontSize', 16);
set(gcf, 'color', 'w', 'Position', [10 10 678 439]);

subplot(4,1,2);
h1 = plot(datenum(1998, 1:12, 1), clim23w, '--k', 'LineWidth', 2);
set(gca, 'FontSize', 16);
set(get(gca, 'ylabel'), 'string', '\circC', 'FontSize', 16);
set(gca, 'xtick', datenum(1998, 1:12, 1), 'xlim', [datenum(1998, 1, 1) datenum(1998, 12, 1)]);
datetick('x', 'm', 'keepticks', 'keeplimits');
grid on
set(gca, 'GridLineStyle', '--')
box on
hold on
plot(datenum(1998,1:12, 1), empWS, 'k', 'LineWidth', 2);
hold off
title('23\circW Climatology', 'FontSize', 16);
set(gcf, 'color', 'w', 'Position', [10 10 678 439]);

subplot(4,1,3);
h1 = plot(datenum(1998, 1:12, 1), climMLD, '--k', 'LineWidth', 2);
set(gca, 'FontSize', 16);
set(get(gca, 'ylabel'), 'string', '\circC', 'FontSize', 16);
set(gca, 'xtick', datenum(1998, 1:12, 1), 'xlim', [datenum(1998, 1, 1) datenum(1998, 12, 1)]);
datetick('x', 'm', 'keepticks', 'keeplimits');
grid on
set(gca, 'GridLineStyle', '--')
box on
hold on
plot(datenum(1998,1:12, 1), empZ20, 'k', 'LineWidth', 2);
hold off
title('23\circW Climatology', 'FontSize', 16);
set(gcf, 'color', 'w', 'Position', [10 10 678 439]);
set(gca, 'ydir', 'reverse');