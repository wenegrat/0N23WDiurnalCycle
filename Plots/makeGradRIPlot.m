function makeGradRIPlot(ds, timerange, crange)
%%
timeoffset = -2;

% Grad ri
rivar = (ds.deepadcp.riforwardreduce_sort(timerange,:));
% rivar = (ds.deepadcp.risortedi(timerange,:));

% rivar = removeOutliers(rivar, 2);
[gradribyhr gradribin] = bindatabyhour((rivar), ds.descriptors.datesen(timerange));
% [gradribyhr gradribin] =
% bindatabyhour(log(ds.deepadcp.riforward(timerange,:)), ds.descriptors.datesen(timerange));
gradribyhr(~isfinite(gradribyhr)) = NaN;
% gradribyhr = exp(gradribyhr);
% gradribin = exp(gradribin);
[~, nbin, ~] = size(gradribin);
% gradrimed = nanmedian(reshape(permute(gradribin, [1 3 2]), 10*24, nbin),2);
% gradrimed = reshape(gradrimed, 24,10);
mldbyhr = bindatabyhour(ds.density.fulldepth.fullmldh(timerange), ds.descriptors.datesen(timerange));

% 
gradbinvec = reshape(permute(gradribin, [1 3 2]), 10*24, nbin);
for i=1:(10*24)
    gradriprob(i) = sum(gradbinvec(i,:) > 0)./sum(isfinite(gradbinvec(i,:)));
end
gradripro = reshape(gradriprob, 24, 10);

% Smoothing Function

% h = 1/9*ones(3); % Simple averaging

h = .5*ones(3); h(2,2) = 1; h = 1/5 * h; %Weight center position most
% h = 1;

% Plotting
figure
[~, children] = contourf(0:23, ds.deepadcp.riforwarddepths(1:5), filter2(h,(real(shifttolocal(gradripro(:,1:5),timeoffset)'))), 40); 
% [~, children] = contourf(0:23, ds.deepadcp.fulldepths(1:35), real(shifttolocal(gradribyhr(:,1:35),timeoffset)'), 40); 

% [~, children] = contourf(0:23, ds.deepadcp.riforwarddepths(1:5), filter2(h,real(shifttolocal(gradrimed(:,1:5),timeoffset)')), 20); 
% [~, children] = contourf(0:23, ds.deepadcp.riforwarddepths(1:5), filter2(h, shifttolocal(gradripro(:,1:5),timeoffset)'), 20); 

set(children,'edgecolor','none');

set(gca,'ydir', 'reverse');
% caxis([-.1 .5]); %trades
% caxis([-.1 2*.75]); %calm
% caxis([-1e-4 1e-4]);
caxis(crange);

cb = colorbar;
set(get(cb, 'yLabel'), 'String', 's^{-2}');

hold on
% contour(0:23, ds.deepadcp.riforwarddepths(1:5), filter2(h,real(shifttolocal(gradribyhr(:,1:5),timeoffset)')), [.25 .25] , 'k'); 
plot(0:23, shifttolocal(mldbyhr,timeoffset), 'k', 'LineWidth', 1.5);

% contour(0:23, ds.deepadcp.riforwarddepths(1:5), shifttolocal(gradrimed(:,1:5),timeoffset)', [.25 .25], 'k', 'LineWidth', 1.5);
% contour(1:24, dataset.deepadcp.fulldepths(depthrange), (n2bulkbyhr(:,depthrange)')./(magupbyhr(:,depthrange)').^2, [.0 .0], 'w', 'LineWidth', 1.5);
% plot(0:23, shifttolocal(mldbyhr,timeoffset), 'b', 'LineWidth', 1.5);
hold off
grid on
set(gca, 'XTick', [0:23]);
ylabel('Depth', 'FontSize', 16);
xlabel('Local Hr', 'FontSize', 16);
title('Ri_{grad}', 'FontSize', 16);
set(gca, 'FontSize', 16);

% colormap(cptcmap('dkbluered'))
colormap(jet);
end