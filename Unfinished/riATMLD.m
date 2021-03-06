function riATMLD(ds, tri, twarm, tcold, trades)
rivar = ds.deepadcp.riforwardreduce_sort;
[rimldav, riatmld] = valatmld(naninterpmatrix(rivar(:,1:10)')', ...
    ds.density.fulldepth.fullmldh, ds.deepadcp.riforwarddepths(1:10));
ricmd = complex_demodulate_tri(riatmld, 1/24, tri);

rimldhrcld = bindatabyhour(riatmld(tcold), ds.descriptors.datesen(tcold));
rimldhrwrm = bindatabyhour(riatmld(twarm), ds.descriptors.datesen(twarm));


dlims = 1:1174;
dates = datenum(2008, 10, [1 7 15 24 32 39 46]);
figure
plot(ds.descriptors.datesen(dlims), ricmd.semimaj(dlims), '--k', 'LineWidth', 1.0);
% set(gca, 'xtick', dates);
datetick('x', 'mm-dd', 'keepticks');
hold on
plot(ds.descriptors.datesen(dlims), smooth(ricmd.semimaj(dlims), 24*7), 'k', 'LineWidth', 2);
hold off
ylim([0 6e-4]);
xlim(ds.descriptors.datesen(dlims([1 end])));
grid on

ylabel('Reduced Shear Diurnal Cycle Amplitude', 'FontSize', 16);

set(gca, 'FontSize', 16);
set(gcf, 'Color', 'w');
set(gcf, 'Position', [0 0 1155  458]);


figure
plot(ds.descriptors.datesen(dlims), riatmld(dlims), '--k', 'LineWidth', 1.0);
% set(gca, 'xtick', dates);
datetick('x', 'mm-dd', 'keepticks');
hold on
plot(ds.descriptors.datesen(dlims), smooth(riatmld(dlims), 24*7), 'k', 'LineWidth', 2);
hold off
ylim([-1*1e-3 .5*1e-3]);
xlim(ds.descriptors.datesen(dlims([1 end])));
grid on

ylabel('Reduced Shear at MLD', 'FontSize', 16);

set(gca, 'FontSize', 16);
set(gcf, 'Color', 'w');
set(gcf, 'Position', [0 0 1155  458]);
end