function makeShearPlot(erel, nrel, wx, wy, flux, mld, av, rivar, ds, timerange, tempbins)
%%
% Make Plots
%==========================================================================

% riatmld = valAtMLD(rivar(timerange,:), ds.density.fulldepth.fullmldh(timerange), ds.deepadcp.riforwarddepths);

%============================== Bin Data ==================================
% Temperature Anomaly
tempanom = ds.density.fulldepth.temps(1:6, timerange) - ...
    nanmean(nanmean(ds.density.fulldepth.temps(1:5, timerange))); %XXX Consider this further
tempsbyhr = bindatabyhour(tempanom', ds.descriptors.datesen(timerange));
stempbyhr = bindatabyhour(ds.density.fulldepth.temps(1,timerange)', ds.descriptors.datesen(timerange));
stempbyhr = stempbyhr - mean(stempbyhr);

mldbyhr = bindatabyhour(mld(timerange), ds.descriptors.datesen(timerange));

% Sh Vectors
[erelbyhr, ~] = bindatabyhour(erel(timerange,:), ds.descriptors.datesen(timerange));
[nrelbyhr, ~] = bindatabyhour(nrel(timerange,:), ds.descriptors.datesen(timerange));

% Wind Vectors
wxbyhr = bindatabyhour(wx(timerange), ds.descriptors.datesen(timerange));
wybyhr = bindatabyhour(wy(timerange), ds.descriptors.datesen(timerange));

fluxbyhr = bindatabyhour(flux(timerange), ds.descriptors.datesen(timerange));

[avbyhr avbin] = bindatabyhour(log(av(timerange)), ds.descriptors.datesen(timerange));
avbyhr = exp(avbyhr);
avbin = exp(avbin);
[~, nbin, ~] = size(avbin);
avmed = nanmedian(avbin,2);

% riatmldh = bindatabyhour(riatmld, ds.descriptors.datesen(timerange));

%============================== Plot Vars =================================
plottobin = 29;                                         % Defines how deep
scalefactor = .6;                                       % Sizes vectors
scalevel = .012;

windtimelocs = [1 3 5 7 9 11 13 15 17 19 21 23];        % Vectors of Times
velocitygrid = repmat(eye(2),12,  ceil(plottobin/2));   % Decimate vel grid
velocitygrid = logical(velocitygrid(:,1:plottobin));
timezone = -2;                                          % Shift to local time
xlabs = cell(1, 24);
for i=1:2:24
    xlabs{i} = i-1;
end



gap = [.02 .1];
margh = .1;
margw = .225;
%============================== Plotting ==================================

figSh = figure;
set(figSh,'units', 'pixels', 'Position', [0 0 782 674])

%Flux Plot
subtightplot(13,1,1:2,gap, margh, margw);
lvar = shifttolocal(fluxbyhr, timezone);
% [AX h1 h2] = plotyy(0:23, shifttolocal(fluxbyhr, timezone),0:23, shifttolocal(stempbyhr, timezone));
plot(0:23, shifttolocal(fluxbyhr, timezone), 'k', 'LineWidth', 2);
mask = lvar>=0;
times = 0:23;
lvart = lvar;
lvart(mask) = 0;
% h = area(times, lvart, 'FaceColor', 'r');

% set(h1, 'color','k', 'LineWidth', 2);
% set(h2, 'color', 'k', 'LineWidth', 2);
hold on
lvart = lvar;
lvart(~mask) = 0;
% area(times, lvart, 'FaceColor', 'b');
xt = get(gca, 'xtick');
plot(xt, 0*xt, 'k', 'LineWidth', 1.5);
grid on;
xlim([0 23]);
cb = colorbar;
set(cb, 'visible', 'off')
title('Mean Diurnal Composite', 'FontSize', 16);
set(gca, 'FontSize', 16);
% axis square
set(gca, 'XTick',0:23,'XTickLabel', []);
ylabel({'Heat Flux','W m^{-2}'}, 'FontSize', 16);
ylim([-200 800]);

% SST Amp
subtightplot(13, 1, 3, gap, margh, margw)
plot(0:23, shifttolocal(stempbyhr, timezone), 'k', 'LineWidth', 2);
cb = colorbar;
set(cb, 'visible', 'off')
set(gca, 'FontSize', 16, 'XTick', 0:23, 'xlim', [0 23], 'XTickLabel', [],...
    'ylim', [-.35 .35], 'ytick', -.35:.1725:.35, 'yTickLabel', {'-.35', [], '0', [], '.35'});
ylabel({'SSTA','\circC'}, 'FontSize', 16);

grid on

% Shear Plot
subtightplot(13, 1, 4:11, gap, margh, margw);
[~, children] = contourf(0:23, ds.density.fulldepth.tempdepth(1:6), shifttolocal(tempsbyhr(:,:),timezone)', [tempbins-.1 tempbins]);
caxis([tempbins(1) tempbins(end)]);
set(children,'edgecolor','none');

ylim([-3 ds.descriptors.sendepth(plottobin)]);
xlim([0 23]);

cb = colorbar;
set(get(cb, 'YLabel'), 'String', 'Temperature Anomaly (\circC)', 'FontSize', 16);

hold on

plot(0:23, shifttolocal(mldbyhr,timezone), '--k', 'LineWidth', 1.5);

% negative values for meriodional vel necessary for axis flip.
cx = scalevel*shifttolocal(erelbyhr(:,1:plottobin),timezone)';
cy = -scalevel*shifttolocal(nrelbyhr(:,1:plottobin),timezone)';

hvel = quiver(0:23,ds.descriptors.sendepth(1:plottobin), cx.*velocitygrid', cy.*velocitygrid', 'k',  'LineWidth', 1.1);
wx = scalefactor*shifttolocal(wxbyhr(:),timezone)';
wy =  -scalefactor*shifttolocal(wybyhr(:),timezone)';

xleg = 2;
yleg = 2;
fudge = .5;
legq = quiver(xleg, yleg, (scalevel*200), 0, 'k', 'LineWidth', 1.2);
text(xleg, yleg - fudge, 'Wind: 4 m/s', 'FontSize', 14)

text(xleg, yleg + fudge, 'Current: 20 cm/s', 'FontSize', 14)


hwind = quiver(windtimelocs,0, wx(windtimelocs),wy(windtimelocs), 'k',  'LineWidth', 1.1);

set(legq, 'autoscale', 'off');
% set(legq2, 'autoscale', 'off');

set(hvel, 'autoscale', 'off');
set(hwind, 'autoscale', 'off');
% axis(axis_q);
%  axis_q = get(hwind, 'axis');

% pos1 = get(gca, 'Position');
colormap(flipud(othercolor('RdBu5')));
set(gca, 'ydir', 'reverse')
set(gca, 'XTick', [0:1:23]);

set(gca, 'XTickLabel',[]);
set(gca, 'FontSize', 16);


% axis equal
axis square
grid on;
ylabel({'Wind Stress, Current Shear','Depth (m)'});
hold off


set(gca, 'XTickLabel',[]);

%AV Plot
subtightplot(13,1,12:13,gap, margh, margw);
plot(0:23, shifttolocal(avbyhr, timezone), 'k', 'LineWidth', 2);
grid on;
xlim([0 23]);
cb = colorbar;
set(cb, 'visible', 'off')
% title('Mean Diurnal Composite', 'FontSize', 16);
set(gca, 'FontSize', 16);
% axis square
set(gca, 'XTick',0:23,'XTickLabel', xlabs, 'yscale', 'log');
ylabel({'A_v','m^{-2}s^{-1}'}, 'FontSize', 16);
ylim([5e-4 1e-2]);
xlabel('Local Hour');
set(gca, 'FontSize', 16);
set(gcf, 'Position', [0 0 705 747]);
set(gcf, 'Color', 'w');
end