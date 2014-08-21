%%
% Figure 1
% =========================================================================
% Create the overview plot

%Formatting
xdepthoffset(1) = 4.5; %sets the outer dim of the depth hatches
xdepthoffset(2) = 7; %sets the inner dimension of the depth hatches
depthtitleoffset(1) = 0;%2; %moves the depth bar header in x dim
depthtitleoffset(2) = 2.5; %moves the depth bar header in y dim
yaxisoffset = 0; %Sets distance between data and axis in y dimension
xaxisoffset = 8; %sets dist between data and axis in x dimension
plottobin = 46;
% cmap1 = othercolor('BuDRd_12');
cmap1 = othercolor('BuOr_12');

% cmap2 = flipud(othercolor('BuDRd_18'));
yticks = 0:20:100;
dticks = [datenum(2008,10,1) datenum(2008, 11, 1) datenum(2008,12,1) datenum(2009,1,1) datenum(2009,2,1)...
    datenum(2009,3,1) datenum(2009,4,1) datenum(2009,5,1) datenum(2009,6,1)];
densitymask = NaN * zeros([1 plottobin]);
densitymask([2 13 22 26 72]) = 1;
shearbins = 0:.005:.095; %Bins for shear
bins = -1000:100:1000; %bins for vel
binsinvri = -10:.25:10;

dateranged = 1:249;
daterange = 1:5967;

figure
h=tight_subplot(9,1, .012, .05, [.1 .05]);

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
set(gca, 'ytick', 0:.1:.5, 'ylim', [0 .5]);
set(gca,'XTickLabel',[])

hold on
yt = get(gca, 'ytick');
plot(dataset.descriptors.datesen(trades(end)).*ones(size(yt)), yt, 'k', 'LineWidth', 1.5);
plot(dataset.descriptors.datesen(calm(end)).*ones(size(yt)), yt, 'k', 'LineWidth', 1.5);
grid on
hold off
ylabel({'SST Amp', '\circC'}, 'FontSize', 12);
axes_label('a)', 50, 50);

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
plot(dataset.descriptors.datesend(5:end-5),  var(5:end-5) , '-.k', 'LineWidth', 1.5);
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
ylabel({'E-P', 'cm day^{-1}'});
ylim([-10 1]);
axes_label('c)', 50, 5);
grid on


%==============
% h(1) = subplot(5,1,1);
axes(h(4))
quiver(dataset.descriptors.datesend(dateranged), 1, dataset.measures.uwndd', dataset.measures.vwndd', 'k');
cb = colorbar;
set(cb, 'visible', 'off');
set(gca, 'XTick', dticks);
datetick('x',3,'keepticks');
set(gca,'XTickLabel',[])
set(gca, 'YTick', -12:6:12);
axis equal
hold on
yt = get(gca, 'ytick');
plot(dataset.descriptors.datesen(trades(end)).*ones(size(yt)), yt, 'k', 'LineWidth', 1.5);
plot(dataset.descriptors.datesen(calm(end)).*ones(size(yt)), yt, 'k', 'LineWidth', 1.5);
hold off

xlim([dataset.descriptors.datesen(daterange(1))-xaxisoffset dataset.descriptors.datesen(daterange(end))+xaxisoffset]);
ylabel({'Wind', 'm s^{-1}'});
ylim([-12 12]);
axes_label('d)', 50, 5);
grid on

%==============
% h(2) = subplot(5,1,2);
axes(h(5))
[~, children] = contourf(dataset.descriptors.datesend(dateranged), dataset.deepadcp.fulldepths(1:plottobin), (dataset.deepadcp.fullud(dateranged,1:plottobin))');
grid on
set(gca, 'ydir', 'reverse')
set(gca, 'XTick', dticks);
set(gca, 'XTickLabel', []);
xlim([dataset.descriptors.datesen(daterange(1))-xaxisoffset dataset.descriptors.datesen(daterange(end))+xaxisoffset]);

ylim([0 max(dataset.deepadcp.fulldepths(1:plottobin))+yaxisoffset]);
cb = colorbar;

ylabel({'U', 'Depth (m)'}, 'FontSize', 12);
set(get(cb, 'YLabel'), 'String', 'm s^{-1}', 'FontSize', 12);

hold on
yt = get(gca, 'ytick');
plot(dataset.descriptors.datesend(:), averagedaily(dataset.density.fulldepth.mldT, 1,dataset.descriptors.datesen), '-w', 'LineWidth', 2);

plot(dataset.descriptors.datesend(:), averagedaily(dataset.density.fulldepth.mldT, 1,dataset.descriptors.datesen), '--k', 'LineWidth', 2);

plot(dataset.descriptors.datesen(trades(end)).*ones(size(yticks)), yticks, 'k', 'LineWidth', 1.5);
plot(dataset.descriptors.datesen(calm(end)).*ones(size(yticks)), yticks, 'k', 'LineWidth', 1.5);

%Plot Depths
zz = xlim;
px(1) = zz(1) + xdepthoffset(1);
px(2) = zz(1) + xdepthoffset(2);
py(1) = 1;
py(2) = 1;
for i=1:plottobin
    py(1) = dataset.deepadcp.fulldepths(i);
    py(2) = dataset.deepadcp.fulldepths(i);
    if (dataset.deepadcp.fullmask(i)==1)
        ph = plot(px, py, 'k');
    else
%         ph = plot(px, py, 'Color', [.8 .8 .8]);
    end
end

ty = ylim;

hold off
set(gca, 'Ytick', yticks);

caxis([-1 1]);
colormap(cmap1)

axes_label('e)', 50, 20);


%==============
% h(3) = subplot(5,1,3);
axes(h(6));
[~, children] = contourf(dataset.descriptors.datesend(dateranged), dataset.deepadcp.fulldepths(1:plottobin), (dataset.deepadcp.fullvd(dateranged,1:plottobin))');
grid on
set(gca, 'ydir', 'reverse')
set(gca, 'XTick', dticks);
set(gca, 'XTickLabel', []);
xlim([dataset.descriptors.datesen(daterange(1))-xaxisoffset dataset.descriptors.datesen(daterange(end))+xaxisoffset]);

ylim([0 max(dataset.deepadcp.fulldepths(1:plottobin))+yaxisoffset]);
cb = colorbar;
ylabel({'V', 'Depth (m)'},'FontSize', 12);
set(get(cb, 'YLabel'), 'String', 'm s^{-1}', 'FontSize', 12);
hold on
plot(dataset.descriptors.datesend(:), averagedaily(dataset.density.fulldepth.mldT, 1,dataset.descriptors.datesen), '-w', 'LineWidth', 2);
plot(dataset.descriptors.datesend(:), averagedaily(dataset.density.fulldepth.mldT, 1,dataset.descriptors.datesen), '--k', 'LineWidth', 2);

plot(dataset.descriptors.datesen(trades(end)).*ones(size(yticks)), yticks, 'k', 'LineWidth', 1.5);
plot(dataset.descriptors.datesen(calm(end)).*ones(size(yticks)), yticks, 'k', 'LineWidth', 1.5);

%Plot Depths
zz = xlim;
px(1) = zz(1) + xdepthoffset(1);
px(2) = zz(1) + xdepthoffset(2);
py(1) = 1;
py(2) = 1;
for i=1:plottobin
    py(1) = dataset.deepadcp.fulldepths(i);
    py(2) = dataset.deepadcp.fulldepths(i);
    if (dataset.deepadcp.fullmask(i)==1)
        ph = plot(px, py, 'k');
    else
%         ph = plot(px, py, 'Color', [.8 .8 .8]);
    end
end

ty = ylim;

hold off
set(gca, 'Ytick', yticks);

caxis([-1 1]);
colormap(cmap1)

axes_label('f)', 50, 20);



% h(4) = subplot(5,1,4);
axes(h(7));
[~, children] = contourf(dataset.descriptors.datesend(dateranged), dataset.deepadcp.riforwarddepths(1:10), log10((averageDaily(dataset.deepadcp.sh2forward(:,1:10), 1:10, dataset.descriptors.datesen))'), 8);
grid on

set(gca, 'ydir', 'reverse')
set(gca, 'XTick', dticks);
% datetick('x',3,'keepticks');
set(gca, 'XTickLabel', []);

xlim([dataset.descriptors.datesen(daterange(1))-xaxisoffset dataset.descriptors.datesen(daterange(end))+xaxisoffset]);

ylim([0 max(dataset.deepadcp.fulldepths(1:plottobin))+yaxisoffset]);
cb = colorbar;

ylabel({'Log_{10}(Sh^2)', 'Depth (m)'},'FontSize', 12);
set(get(cb, 'YLabel'), 'String', 'log_{10}(s^{-2})');

hold on
plot(dataset.descriptors.datesend(:), averagedaily(dataset.density.fulldepth.mldT, 1,dataset.descriptors.datesen), '-w', 'LineWidth', 2);
plot(dataset.descriptors.datesend(:), averagedaily(dataset.density.fulldepth.mldT, 1,dataset.descriptors.datesen), '--k', 'LineWidth', 2);

plot(dataset.descriptors.datesen(trades(end)).*ones(size(yticks)), yticks, 'k', 'LineWidth', 1.5);
plot(dataset.descriptors.datesen(calm(end)).*ones(size(yticks)), yticks, 'k', 'LineWidth', 1.5);

%Plot Depths
zz = xlim;
px(1) = zz(1) + xdepthoffset(1);
px(2) = zz(1) + xdepthoffset(2);
py(1) = 1;
py(2) = 1;
for i=1:10
    py(1) = dataset.deepadcp.riforwarddepths(i);
    py(2) = dataset.deepadcp.riforwarddepths(i);
%     if (dataset.deepadcp.fullmask(i)==1)
        ph = plot(px, py, 'k');
%     else
%         ph = plot(px, py, 'Color', [.8 .8 .8]);
%     end
end
caxis([-6 -2]);
set(cb, 'YtickMode', 'manual');
set(cb, 'YTick', [-6 -4 -2]);
set(gca, 'Ytick', yticks);

axes_label('g)', 50, 20);



%==============
% h(5) = subplot(5,1,5);
axes(h(8));
[~, children] = contourf(dataset.descriptors.datesend(dateranged), dataset.deepadcp.riforwarddepths(1:10), log10((averageDaily(dataset.deepadcp.n2forward_sort(:,1:10), 1:10, dataset.descriptors.datesen))'), 12);
grid on


set(gca, 'ydir', 'reverse')
set(gca, 'XTick', dticks);
datetick('x',3,'keepticks');
set(gca, 'XTickLabel', []);
ylim([0 max(dataset.deepadcp.fulldepths(1:plottobin))+yaxisoffset]);
cb = colorbar;
ylabel({'Log_{10}(N^2)', 'Depth (m)'}, 'FontSize', 12);
set(get(cb, 'YLabel'), 'String', 'log_{10}(s^{-2})');
hold on
plot(dataset.descriptors.datesend(:), averagedaily(dataset.density.fulldepth.mldT, 1,dataset.descriptors.datesen), '-w', 'LineWidth', 2);
plot(dataset.descriptors.datesend(:), averagedaily(dataset.density.fulldepth.mldT, 1,dataset.descriptors.datesen), '--k', 'LineWidth', 2);
yt = get(gca, 'ytick');

plot(dataset.descriptors.datesen(trades(end)).*ones(size(yticks)), yticks, 'k', 'LineWidth', 1.5);
plot(dataset.descriptors.datesen(calm(end)).*ones(size(yticks)), yticks, 'k', 'LineWidth', 1.5);

xlim([dataset.descriptors.datesen(daterange(1))-xaxisoffset dataset.descriptors.datesen(daterange(end))+xaxisoffset]);

%Plot Depths
set(gca, 'Ytick', yticks);
%Plot Depths
zz = xlim;
px(1) = zz(1) + xdepthoffset(1);
px(2) = zz(1) + xdepthoffset(2);
py(1) = 1;
py(2) = 1;
for i=1:10
    py(1) = dataset.deepadcp.riforwarddepths(i);
    py(2) = dataset.deepadcp.riforwarddepths(i);
%     if (dataset.deepadcp.fullmask(i)==1)
        ph = plot(px, py, 'k');
%     else
%         ph = plot(px, py, 'Color', [.8 .8 .8]);
%     end
end
% set(cb, 'YTick', 24:.5:25.5)
caxis([-6 -2]);

ty = ylim;
% text(zz(1)+depthtitleoffset(1), ty(1) + depthtitleoffset(2), ['Bins
% '],...
%     'FontSize', 8);
hold off
axes_label('h)', 50, 20);

% packrows(h, 5, 1);

% SAVE 



%==============
% h(5) = subplot(5,1,5);
axes(h(9));
[~, children] = contourf(dataset.descriptors.datesend(dateranged), dataset.deepadcp.riforwarddepths(1:10), (1e3*(averageDaily(dataset.deepadcp.riforwardreduce_sort(:,1:10), 1:10, dataset.descriptors.datesen))'), 12);
grid on


set(gca, 'ydir', 'reverse')
set(gca, 'XTick', dticks);
datetick('x',3,'keepticks');

ylim([0 max(dataset.deepadcp.fulldepths(1:plottobin))+yaxisoffset]);
cb = colorbar;
ylabel({'Sh^2_{red}', 'Depth (m)'}, 'FontSize', 12);
set(get(cb, 'YLabel'), 'String', ' \times 10^{-3} (s^{-2})');
hold on
plot(dataset.descriptors.datesend(:), averagedaily(dataset.density.fulldepth.mldT, 1,dataset.descriptors.datesen), '-w', 'LineWidth', 2);
plot(dataset.descriptors.datesend(:), averagedaily(dataset.density.fulldepth.mldT, 1,dataset.descriptors.datesen), '--k', 'LineWidth', 2);

plot(dataset.descriptors.datesen(trades(end)).*ones(size(yticks)), yticks, 'k', 'LineWidth', 1.5);
plot(dataset.descriptors.datesen(calm(end)).*ones(size(yticks)), yticks, 'k', 'LineWidth', 1.5);

xlim([dataset.descriptors.datesen(daterange(1))-xaxisoffset dataset.descriptors.datesen(daterange(end))+xaxisoffset]);

%Plot Depths
set(gca, 'Ytick', yticks);
%Plot Depths
zz = xlim;
px(1) = zz(1) + xdepthoffset(1);
px(2) = zz(1) + xdepthoffset(2);
py(1) = 1;
py(2) = 1;
for i=1:10
    py(1) = dataset.deepadcp.riforwarddepths(i);
    py(2) = dataset.deepadcp.riforwarddepths(i);
%     if (dataset.deepadcp.fullmask(i)==1)
        ph = plot(px, py, 'k');
%     else
%         ph = plot(px, py, 'Color', [.8 .8 .8]);
%     end
end
% set(cb, 'YTick', 24:.5:25.5)
caxis([-4 1.5]);
set(cb, 'YtickMode', 'manual');
set(cb, 'YTick', [-4 -2 0 1]);
ty = ylim;
% text(zz(1)+depthtitleoffset(1), ty(1) + depthtitleoffset(2), ['Bins
% '],...
%     'FontSize', 8);
hold off
axes_label('i)', 50, 20);

% packrows(h, 5, 1);
% SAVE 

set(gcf, 'Position', [0 0 1112 701], 'Color', 'w');