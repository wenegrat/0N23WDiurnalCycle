function makeDCPlot(dc, ds)


figure
plot(ds.descriptors.datesen, dc.semimaj, '--k', 'LineWidth', 1.0);
set(gca, 'xtick', datenum(2008,10:19, 0));
datetick('x', 'mm-yy', 'keepticks');
hold on
plot(ds.descriptors.datesen, smooth(dc.semimaj, 24*14), 'k', 'LineWidth', 2);
hold off
ylim([0 .5]);
xlim(ds.descriptors.datesen([1 end]));
grid on

ylabel('SST Diurnal Cycle Amplitude (\circ C)', 'FontSize', 16);

set(gca, 'FontSize', 16);
set(gcf, 'Color', 'w');
set(gcf, 'Position', [0 0 1155  458]);
end