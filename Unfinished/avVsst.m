avDC = complex_demodulate_tri(avmag, 1/24, tri);
shDC = complex_demodulate_tri(shmag, 1/24, tri);

avAmpd = averageDaily(avDC.semimaj, 1, dataset.descriptors.datesen);
sstD = averageDaily(cmodDC.semimaj, 1, dataset.descriptors.datesen);

avm = averageSSTMonthly(avDC.semimaj, dataset.descriptors.datesen);
shm = averageSSTMonthly(shDC.semimaj, dataset.descriptors.datesen);

[sstm mtimes] = averageSSTMonthly(cmodDC.semimaj, dataset.descriptors.datesen);

figure
cmaps = linspecer(3);

h1 = plot(mtimes, sstm, 'Color', 'k', 'LineWidth', 2);


set(gca, 'xTick', datenum(2008,1:24,1), 'xlim', [dataset.descriptors.datesen(1) dataset.descriptors.datesen(end)]);
datetick('x','mm-yy', 'keepticks', 'keeplimits');
[hp1 ha1] = addaxis(mtimes, log10(avm), [-3 -2], 'Color', cmaps(1,:), 'LineWidth', 2);
[hptemp hatemp] = addaxis(mtimes, log10(avm), [-3 -2], 'Color', cmaps(1,:), 'LineWidth', 2); % this needed to get next plot axis on left.
set(hatemp, 'visible', 'off')

[hp2 ha2] = addaxis(mtimes, log10(shm), [-2.5 -2], 'Color', cmaps(3,:), 'LineWidth', 2);
set(gca, 'FontSize', 16);
set(get(gca, 'ylabel'), 'string', 'SST   \circC', 'FontSize', 16);
set(ha1, 'Color', 'w', 'FontSize', 16);
set(get(ha1, 'ylabel'), 'String', 'A_v   m^2 s^{-1}', 'FontSize', 16)
set(ha2, 'Color', 'w', 'FontSize', 16);
set(get(ha2, 'ylabel'), 'String', 'Sh   s^{-1}', 'FontSize', 16)
grid on
title('Diurnal Amplitudes', 'FontSize', 16);
set(gcf, 'color', 'w');
