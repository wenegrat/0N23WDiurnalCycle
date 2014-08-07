%%
% Final Comparison averaged weekly
clear shdc;

bins = 4:7;
[riv ridates] = applyToWeek(dataset.deepadcp.riforwardreduce_sort(:,bins), @nanmedian);

[nh nhdates] = applyToWeek(netheat, @nanmean);
[tu tudates] = applyToWeek(dataset.measures.tauxh, @nanmean);
[tv tvdates] = applyToWeek(dataset.measures.tauyh, @nanmean);

[dSST dsstdates] = applyToWeek(cmodDC.semimaj, @nanmean);

shvar = sqrt(dataset.deepadcp.sh2forward(:,1:2));
sht = complex_demodulate_tri(shvar(:,1), 1/24, tri);
shdc(:,1) = sht.semimaj;
sht = complex_demodulate_tri(shvar(:,1), 1/24, tri);
shdc(:,2) = sht.semimaj;
% sht = complex_demodulate_tri(shvar(:,1), 1/24, tri);
% shdc(:,3) = sht.semimaj;

[duz duzdates] = applyToWeek(shdc, @nanmean);
[duzt duzdatest] = applyToWeek(shvar, @nanmean);

[ml mldates] = applyToWeek(dataset.density.fulldepth.fullmldh, @nanmean);
[z2 z2dates] = applyToWeek(isothermi, @nanmean);


gap = [.05 .1]; margh = .1; margw = .1;

figure
subtightplot(5,1,1, gap, margh, margw);
plot(nhdates, nh, 'k', 'LineWidth', 2);
set(gca, 'FontSize', 16, 'XTick', datenum(2008,10:18,1), 'Xlim', [datenum(2008,10,1) datenum(2009, 6, 31)]);
datetick('x', 'mm-yy', 'keepticks', 'keeplimits');
grid on

subtightplot(5,1,2, gap, margh, margw);
plot(nhdates, tu, 'k', 'LineWidth', 2);
hold on
plot(nhdates, tv, '--k', 'LineWidth', 2);
hold off
set(gca, 'FontSize', 16, 'XTick', datenum(2008,10:18,1), 'Xlim', [datenum(2008,10,1) datenum(2009, 6, 31)]);
datetick('x', 'mm-yy', 'keepticks', 'keeplimits');
grid on

subtightplot(5,1,3, gap, margh, margw);
plot(nhdates, dSST, 'k', 'LineWidth', 2);
hold on
% plot(nhdates, tv, '--k', 'LineWidth', 2);
hold off
set(gca, 'FontSize', 16, 'XTick', datenum(2008,10:18,1), 'Xlim', [datenum(2008,10,1) datenum(2009, 6, 31)]);
datetick('x', 'mm-yy', 'keepticks', 'keeplimits');
grid on

% subtightplot(6,1,4, gap, margh, margw);
% plot(nhdates, duz, 'k', 'LineWidth', 2);
% hold on
% % plot(nhdates, tv, '--k', 'LineWidth', 2);
% hold off
% set(gca, 'FontSize', 16, 'XTick', datenum(2008,10:18,1), 'Xlim', [datenum(2008,10,1) datenum(2009, 6, 31)]);
% datetick('x', 'mm-yy', 'keepticks', 'keeplimits');
% grid on

subtightplot(5,1,4, gap, margh, margw);
plot(nhdates, riv, 'k', 'LineWidth', 2);
hold on
% plot(nhdates, tv, '--k', 'LineWidth', 2);
hold off
set(gca, 'FontSize', 16, 'XTick', datenum(2008,10:18,1), 'Xlim', [datenum(2008,10,1) datenum(2009, 6, 31)]);
datetick('x', 'mm-yy', 'keepticks', 'keeplimits');
grid on

subtightplot(5,1,5, gap, margh, margw);
plot(nhdates, ml, 'k', 'LineWidth', 2);
hold on
plot(nhdates, z2, '--k', 'LineWidth', 2);
hold off
set(gca, 'FontSize', 16, 'XTick', datenum(2008,10:18,1), 'Xlim', [datenum(2008,10,1) datenum(2009, 6, 31)]);
datetick('x', 'mm-yy', 'keepticks', 'keeplimits');
set(gca, 'ydir', 'reverse')
grid on