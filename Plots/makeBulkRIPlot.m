function makeBulkRIPlot(dataset, timerange, collims)
timeoffset = -2;
depthlim = 5;

xlabs = cell(1, 24);
for i=1:2:24
    xlabs{i} = i-1;
end


n2bulkbyhr = bindatabyhour(dataset.deepadcp.n2bulk(timerange,:), dataset.descriptors.datesen(timerange));
sh2bulkbyhr = bindatabyhour(dataset.deepadcp.shmagbulk(timerange,:), dataset.descriptors.datesen(timerange)).^2;

ribulkbyhr = exp(bindatabyhour(log(dataset.deepadcp.riforwardbulk(timerange,:)), dataset.descriptors.datesen(timerange)));

mldbyhr = bindatabyhour(dataset.density.fulldepth.fullmldh(timerange), dataset.descriptors.datesen(timerange));

h = .5*ones(3); h(2,2) = 1; h = 1/5 * h; %Weight center position most


figure
% [~, children] = contourf(0:23, dataset.deepadcp.riforwarddepths(1:depthlim), shifttolocal(ribulkbyhr(:,1:depthlim),timeoffset)', linspace(collims(1), collims(2), 40));
[~, children] = contourf(0:23, dataset.deepadcp.riforwarddepths(1:depthlim),  shifttolocal(n2bulkbyhr(:,1:depthlim)./sh2bulkbyhr(:,1:depthlim),timeoffset)', linspace(collims(1), collims(2), 20));
set(children, 'edgecolor', 'none');

colorbar;
hold on
% contour(0:23, dataset.deepadcp.fulldepths(depthrange), shifttolocal((n2bulkbyhr(:,depthrange))./(magupbyhr(:,depthrange)).^2,timeoffset)', [.65 .65], 'k', 'LineWidth', 1.5);
plot(0:23, shifttolocal(mldbyhr,timeoffset), 'k', 'LineWidth', 1.5);
hold off
grid on
set(gca, 'ydir', 'reverse', 'XTick', 0:23, 'XTickLabel', xlabs, 'clim', collims);
ylabel('Depth', 'FontSize', 16);
xlabel('Local Hr', 'FontSize', 16);
title('Ri_{bulk}', 'FontSize', 16);
set(gca, 'FontSize', 16);

% colormap(flipud(cptcmap('saga-16.cpt')))
set(gcf, 'Color', 'w', 'Position', [ 0 0 799 648]);

end