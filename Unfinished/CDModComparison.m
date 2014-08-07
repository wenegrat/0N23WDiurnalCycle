%%
% Example of complex demodulation
gap = [.05 .1]; margh = .1; margw = .1;
trange = tiwcold(1:end-10);

subtightplot(2,1,1, gap, margh, margw);
plot(dataset.descriptors.datesen(trange), dataset.density.fulldepth.temps(1,trange), 'k', 'LineWidth', 2);
grid on
set(gca, 'FontSize', 16, 'XTick', datenum(2008,10,1:100), 'xLim', dataset.descriptors.datesen(trange([1 end])));
datetick('x', 'dd','keeplimits', 'keepticks');
set(gca, 'xtickLabel', '');
ylabel('1 m Temp (^{\circ}C)', 'FontSize', 16);
title('Example Complex Demodulation', 'FontSize', 16);
subtightplot(2,1,2, gap, margh, margw);
plot(dataset.descriptors.datesen(trange), cmodDC.semimaj(trange)'.*cos(2*pi./24.*trange  - 4), 'k', 'LineWidth', 2);
grid on
hold on
plot(dataset.descriptors.datesen(trange), cmodDC.semimaj(trange), '--k');
plot(dataset.descriptors.datesen(trange), -cmodDC.semimaj(trange), '--k');
% plot(dataset.descriptors.datesend, deltaDaily(dataset.density.fulldepth.temps(1,:), dataset.descriptors.datesen)/2, 'ok');
hold off
set(gca, 'FontSize', 16, 'XTick', datenum(2008,10,1:100), 'xLim', dataset.descriptors.datesen(trange([1 end])));
datetick('x', 'dd','keeplimits', 'keepticks');
xlabel('Day of Month', 'FontSize', 16);
ylabel('Amplitude (^{\circ}C)', 'FontSize', 16);


set(gcf, 'Color', 'w');
