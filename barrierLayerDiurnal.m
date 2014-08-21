%%
% Salinity Plots
% May need to run loadBuoyancyflux.m first

yticks = 0:20:100;
dticks = [datenum(2008,10,1) datenum(2008, 11, 1) datenum(2008,12,1) datenum(2009,1,1) datenum(2009,2,1)...
    datenum(2009,3,1) datenum(2009,4,1) datenum(2009,5,1) datenum(2009,6,1)];

yaxisoffset = 0; %Sets distance between data and axis in y dimension
xaxisoffset = 8; %sets dist between data and axis in x dimension
dateranged = 1:249;
daterange = 1:5967;


figure
h=tight_subplot(4,1, .01, .05, [.1 .05]);

%===============
axes(h(1))
var = smooth(averageDailY(cmodDC.semimaj,1, dataset.descriptors.datesen), 5); 
plot(dataset.descriptors.datesend, var, 'k', 'LineWidth', 2);
% plot(mtimes, sstm, 'k');
    set(gca, 'xtick', datenum(2008,10:20,1));
cb = colorbar;
set(cb, 'visible', 'off');
xlim([dataset.descriptors.datesen(daterange(1))-xaxisoffset dataset.descriptors.datesen(daterange(end))+xaxisoffset]);
datetick('x', 'keeplimits', 'keepticks')
set(gca, 'ytick', 0:.1:.4, 'ylim', [0 .4]);
set(gca,'XTickLabel',[])

hold on
yt = get(gca, 'ytick');
plot(dataset.descriptors.datesen(trades(end)).*ones(size(yt)), yt, 'k', 'LineWidth', 1.5);
plot(dataset.descriptors.datesen(calm(end)).*ones(size(yt)), yt, 'k', 'LineWidth', 1.5);
grid on
hold off
ylabel({'SST Amp', '\circC'}, 'FontSize', 12);
axes_label('a)', 50, 5);

%==============
% h(1) = subplot(5,1,1);
axes(h(2))
% [mthheat, mtimes] = averageSSTMonthly(dataset.flux.netheat, dataset.descriptors.datesen);
var = smooth(averageDaily(dataset.flux.netheat, 1, dataset.descriptors.datesen), 5);

plot(dataset.descriptors.datesend(5:end-5), var(5:end-5) , 'k', 'LineWidth', 2);
hold on
var = smooth(averageDaily(swnet, 1, dataset.descriptors.datesen), 5);
plot(dataset.descriptors.datesend(5:end-5), var(5:end-5), '--k', 'LineWidth', 1.5);
var = smooth(averageDaily(-lwnet, 1, dataset.descriptors.datesen), 5);
plot(dataset.descriptors.datesend(5:end-5),  var(5:end-5) , '--k', 'LineWidth', 1.5);
var = smooth(averageDaily(-sensnet, 1, dataset.descriptors.datesen), 5);
plot(dataset.descriptors.datesend(5:end-5),  var(5:end-5) , '-b', 'LineWidth', 1.5);
var = smooth(averageDaily(-latnet, 1, dataset.descriptors.datesen), 5);
plot(dataset.descriptors.datesend(5:end-5),  var(5:end-5) , '--b', 'LineWidth', 1.5);
yt = get(gca, 'ytick');
plot(dataset.descriptors.datesen(trades(end)).*ones(size(yt)), yt, 'k', 'LineWidth', 1.5);
plot(dataset.descriptors.datesen(calm(end)).*ones(size(yt)), yt, 'k', 'LineWidth', 1.5);
hold off
cb = colorbar;
set(cb, 'visible', 'off');
set(gca, 'XTick', dticks);
datetick('x',3,'keepticks');
set(gca,'XTickLabel',[])
% axis equal
xlim([dataset.descriptors.datesen(daterange(1))-xaxisoffset dataset.descriptors.datesen(daterange(end))+xaxisoffset]);
ylabel({'Heat Flux', 'W m s^{-2}'}, 'FontSize', 12);
ylim([-100 300]);
axes_label('b)', 50, 5);
grid on
legend('Net Heat Flux', 'SWR', '-LWR', '-Sensible HF', '-Latent HF', 'location', 'East');
%==============
% h(1) = subplot(5,1,1);
axes(h(3))
% [mthheat, mtimes] = averageSSTMonthly(dataset.flux.netheat, dataset.descriptors.datesen);
bar(dataset.descriptors.datesend, averageDaily(netevap.*(24)/10, 1, dataset.descriptors.datesen), 'b');
cb = colorbar;
set(cb, 'visible', 'off');
set(gca, 'XTick', dticks);
datetick('x',3,'keepticks');
set(gca,'XTickLabel',[])

hold on
yt = get(gca, 'ytick');
plot(dataset.descriptors.datesen(trades(end)).*ones(size(yt)), yt, 'k', 'LineWidth', 1.5);
plot(dataset.descriptors.datesen(calm(end)).*ones(size(yt)), yt, 'k', 'LineWidth', 1.5);
hold off
% axis equal
xlim([dataset.descriptors.datesen(daterange(1))-xaxisoffset dataset.descriptors.datesen(daterange(end))+xaxisoffset]);
ylabel({'E-P', 'cm'});
ylim([-10 1]);
axes_label('c)', 50, 5);
grid on


axes(h(4))
% [mthheat, mtimes] = averageSSTMonthly(dataset.flux.netheat, dataset.descriptors.datesen);
bar(dataset.descriptors.datesen, dataset.density.fulldepth.temps(1,:)'-dataset.density.fulldepth.temps(2,:)', 'b');
cb = colorbar;
set(cb, 'visible', 'off');
set(gca, 'XTick', dticks);
datetick('x',3,'keepticks');
set(gca,'XTickLabel',[])

hold on
yt = get(gca, 'ytick');
plot(dataset.descriptors.datesen(trades(end)).*ones(size(yt)), yt, 'k', 'LineWidth', 1.5);
plot(dataset.descriptors.datesen(calm(end)).*ones(size(yt)), yt, 'k', 'LineWidth', 1.5);
hold off
% axis equal
xlim([dataset.descriptors.datesen(daterange(1))-xaxisoffset dataset.descriptors.datesen(daterange(end))+xaxisoffset]);
ylabel({'E-P', 'cm'});
% ylim([-10 1]);
axes_label('c)', 50, 5);
grid on
