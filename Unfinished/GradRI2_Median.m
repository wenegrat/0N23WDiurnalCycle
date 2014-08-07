%%
% FIGURE 6
%==========================================================================
% Diurnal Cycle of N, SH, Ri
depthrange = 1:6;
ylimits = [0 35];

    hf = .5*ones(3); hf(2,2) = 1; hf = 1/5 * hf; %Weight center position most
% hf = 1;
% n2var = filter2(hf, n2forwardsort(trange, depthrange));
n2var = n2forwardsort(trange, depthrange);

[n2bulkbyhr n2bulkbins] = (bindatabyhour(log(n2var), dataset.descriptors.datesen(trange)));
n2bulkbins = exp(n2bulkbins);

% shvar = filter2(hf, dataset.deepadcp.sh2forward(trange, depthrange));
shvar = dataset.deepadcp.sh2forward(trange, depthrange);

[magupbyhr shbins] = (bindatabyhour(log(shvar), dataset.descriptors.datesen(trange)));

shbins = exp(shbins);
rbins = nanmedian(shbins,2) - 4*nanmedian(n2bulkbins,2);
% numpos = squeeze(sum(rbins>0,2));
% numbins = squeeze(sum(isfinite(rbins),2));
% fracbins = numpos./numbins;

mldbyhr = bindatabyhour(dataset.density.fulldepth.fullmldh(trange), dataset.descriptors.datesen(trange));
mldTbyhr = bindatabyhour(dataset.density.fulldepth.mldT(trange), dataset.descriptors.datesen(trange));

% Plotting
timeoffset = -2;
figure

xlabs = cell(1, 24);
for i=1:2:24
    xlabs{i} = i-1;
end

limits = [-1e-4 1e-4];
% limits = 10*limits; % for calm period;


rbins = naninterpmatrix(shifttolocal(rbins,timeoffset));
rbins = [rbins(end,:); rbins; rbins(1,:)];
rbinsf = filter2(hf, rbins);
rbins = rbinsf(2:end-1,:);


contourf(0:23, dataset.deepadcp.riforwarddepths(depthrange), rbins', linspace(limits(1), limits(2), 12));
caxis(limits)
set(gca,'ydir', 'reverse');
% caxis([0 .75]); %trades

% caxis([-.1 2*.75]); %calm

cb = colorbar;
set(get(cb, 'ylabel'), 'string', 'Fraction > 0', 'FontSize', 16);
set(cb, 'YTick', [0:.1:.5])
title({'Reduced Shear Squared', 'Sh^2 - 4 \times N^2'}, 'FontSize', 16);
hold on
% contour(0:23, dataset.deepadcp.riforwarddepths(depthrange), rivarcrop', [0 0], 'k', 'LineWidth', 2);

% [C H] = contour(0:23, dataset.deepadcp.riforwarddepths(depthrange),  naninterpmatrix(shifttolocal((n2bulkbyhr(:,depthrange))./(magupbyhr(:,depthrange)),timeoffset)'), [.25 .25], 'k', 'LineWidth', 1.5);
% contour(1:24, dataset.deepadcp.fulldepths(depthrange), (n2bulkbyhr(:,depthrange)')./(magupbyhr(:,depthrange)').^2, [.0 .0], 'w', 'LineWidth', 1.5);
% plot(0:23, shifttolocal(mldbyhr,timeoffset), '--k', 'LineWidth', 1.5);
plot(0:23, shifttolocal(mldTbyhr,timeoffset), '--','color', 'k', 'LineWidth', 1.5);

hold off
grid on
ylim(ylimits);
% caxis([-2e-4 2
set(gca, 'XTick', [0:23]);
set(gca, 'XTickLabel',xlabs);
set(gca, 'ytick', 0:5:35);
ylabel('Depth (m)', 'FontSize', 16);
xlabel('Local Hour', 'FontSize', 16);
% title('Ri_{bulk}', 'FontSize', 16);
set(gca, 'FontSize', 16);


% 
% subplot(7,1,7)
% plot(0:23, shifttolocal(buoybyhr, timeoffset));
% colorbar;
% xlim([0 23])
% axes_label('c)', 50, 20);


colormap(flipud(othercolor('RdBu9')))

% 
% packrows(h, 3,1);
set(gcf, 'Position', [0 0 646 332]);
% 
set(gcf, 'Color', 'w');