function makeShearPlot(erel, nrel, wx, wy, flux, mld, ds, timerange, tempbins)
%%
% Make Plots
%==========================================================================

%============================== Bin Data ==================================
% Temperature Anomaly
tempanom = ds.density.fulldepth.temps(1:6, timerange) - ...
    nanmean(nanmean(ds.density.fulldepth.temps(1:5, timerange))); %XXX Consider this further
tempsbyhr = bindatabyhour(tempanom', ds.descriptors.datesen(timerange));

mldbyhr = bindatabyhour(mld(timerange), ds.descriptors.datesen(timerange));

% Sh Vectors
[erelbyhr, ~] = bindatabyhour(erel(timerange,:), ds.descriptors.datesen(timerange));
[nrelbyhr, ~] = bindatabyhour(nrel(timerange,:), ds.descriptors.datesen(timerange));

% Wind Vectors
wxbyhr = bindatabyhour(wx(timerange), ds.descriptors.datesen(timerange));
wybyhr = bindatabyhour(wy(timerange), ds.descriptors.datesen(timerange));

fluxbyhr = bindatabyhour(flux(timerange), ds.descriptors.datesen(timerange));


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



gap = [.01 .1];
margh = .1;
margw = .125;
%============================== Plotting ==================================

figSh = figure;
set(figSh,'units', 'pixels', 'Position', [0 0 782 674])

%Flux Plot
subtightplot(5,1,1,gap, margh, margw);
plot(0:23, shifttolocal(fluxbyhr, timezone), 'k', 'LineWidth', 2);
grid on;
xlim([0 23]);
cb = colorbar;
set(cb, 'visible', 'off')
title('Mean Diurnal Composite', 'FontSize', 16);
set(gca, 'FontSize', 16);
% axis square
set(gca, 'XTick',0:23,'XTickLabel', []);
ylabel('W m^{-2}', 'FontSize', 16);
ylim([-250 750]);

% Shear Plot
subtightplot(5, 1, 2:5, gap, margh, margw);
[~, children] = contourf(0:23, ds.density.fulldepth.tempdepth(1:6), shifttolocal(tempsbyhr(:,:),timezone)', tempbins);
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

set(gca, 'XTickLabel',xlabs);
set(gca, 'FontSize', 16);


% axis equal
axis square
grid on;
xlabel('Local Hour');
ylabel('Depth (m)');
hold off


set(gca, 'XTickLabel',xlabs);

set(gcf, 'Position', [0 0 705 747]);
set(gcf, 'Color', 'w');
end