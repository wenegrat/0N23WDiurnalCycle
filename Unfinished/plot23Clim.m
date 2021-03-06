function plot23Clim(data23)

figure

[clim23 sste sstt] = averageMonthly(data23.sstDC, data23.sstDCdates);
[clim23w we wt] = averageMonthly(data23.wind, data23.winddates);
[clim23swr swre swrt] = averageMonthly(data23.sw, data23.swdates);

[AX h1 h2] = plotyy(datenum(1998,1:12, 1), clim23, datenum(1998,1:12, 1), clim23w);
set(h1,'color', 'k', 'LineWidth', 2);
set(h2, 'color', 'k', 'LineStyle', '--', 'LineWidth', 1.5);
% % [AX h] = multiplotyyy({1:12, clim23}, {1:12, clim23w},{1:12, clim23swr});
% set(h(1),'color', 'k', 'LineWidth', 2);
% set(h(2), 'color', 'k', 'LineStyle', '--', 'LineWidth', 1.5);

set(get(AX(2), 'ylabel'), 'string', 'm s^-1', 'FontSize', 16)
set(AX, {'xtick'}, {datenum(1998,1:12, 1); datenum(1998,1:12, 1) }, {'xlim'},...
    {[datenum(1998,1,1) datenum(1998, 12, 1)]; [datenum(1998,1,1) datenum(1998, 12, 1)]} );
% set(AX, {'xtick'}, {1:12; 1:12; 1:12 }, {'xlim'},...
%     {[1 12]; [1 12]; [1 12]} );
set(AX, {'ycolor'}, {'k';'k'});

set(get(AX(2), 'ylabel'), 'string', 'm s^-1', 'FontSize', 16)
set(get(AX(1), 'ylabel'), 'string', '\circ C', 'FontSize', 16)
set(AX(2), 'ylim', [0 10], 'ytick', 0:2.5:10, 'FontSize', 16);
set(AX(1), 'ylim', [0 .4], 'ytick', 0:.1:.4, 'FontSize', 16);
datetick(AX(1),'x', 'm', 'keepticks');
datetick(AX(2),'x', 'm', 'keepticks');
% datetick(AX(3), 'x', 'm', 'keepticks');
grid on
% hold(AX(1), 'on')
% plot(datenum(1998, 1:12, 1), 2*sstt+clim23, '-k')
% plot(datenum(1998, 1:12, 1), clim23 - 2*sstt, '-k')
% hold(AX(1), 'off');
% 
% hold(AX(2), 'on')
% plot(AX(2), datenum(1998, 1:12, 1), 2*wt+clim23w, '--k')
% plot(AX(2), datenum(1998, 1:12, 1), clim23w - 2*wt, '--k')
% hold(AX(2), 'off');
title('23\circW Climatology', 'FontSize', 16);
set(gcf, 'color', 'w', 'Position', [10 10 678 439]);
legend('SST Amp.', 'Wind Speed');
end