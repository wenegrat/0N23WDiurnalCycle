time = detail1(40);
alpha = 3.145e-4;
beta = 7.1975e-4;


subplot(1,3,1)

plot(dataset.density.fulldepth.fulldensitysortedi(time,:), dataset.deepadcp.fulldepths, 'b')
% plot(dataset.density.fulldepth.temps(:,tiwcold(time)), dataset.density.fulldepth.tempdepth, 'k');

hold on
plot(dataset.density.fulldepth.fulldensity(time, :), dataset.density.fulldepth.tempdepth, '--k');
plot(sort(dataset.density.fulldepth.fulldensity(time, :)), (dataset.density.fulldepth.tempdepth), '--r')
plot(dataset.density.fulldepth.fulldensityi(time,:), dataset.deepadcp.fulldepths, 'k')

hold off
set(gca, 'ydir', 'reverse')
ylim([0 40])
grid on
subplot(1,3,2)


plot(log10(dataset.deepadcp.n2forward_sort(time,:)), dataset.deepadcp.riforwarddepths)
set(gca, 'ydir', 'reverse')
ylim([0 40])
hold on
plot(log10(dataset.deepadcp.n2forward(time,:)), dataset.deepadcp.riforwarddepths, 'k')
hold off
grid on


subplot(1,3,3)

plot(beta.*(dataset.density.fulldepth.sals(time,:)-dataset.density.fulldepth.sals(time,1)), dataset.density.fulldepth.saldepth);
hold on
plot(-alpha.*(dataset.density.fulldepth.temps(:,time)-dataset.density.fulldepth.temps(1,time)), dataset.density.fulldepth.tempdepth, 'k');
hold off
set(gca, 'ydir', 'reverse')
ylim([0 40]);