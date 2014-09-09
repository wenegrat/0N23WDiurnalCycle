
%%
% Make Fig. 1 for Wenegrat & McPhaden 2014


qscale = 20;
ledge = -45;
qlw = 1.25; %quiver plot arrow thickness

% Plot figure
figure
lats = [-19 -14 -10 -8 -6 -5 -2 0 2 4 8 12 15 20 21];
lons = [322 325 326 328 330 337 350 0 8];
lt = lons-360;
lt(end) = 8;
locs = [lt(1) lats(end-1); lt(1) lats(end-2); lt(1) lats(end-3); lt(1) lats(end-4); lt(1) lats(end-5);...
    lt(2) 0; ...
    lt(3) -19; ...
    lt(4) -14; ...
    lt(5) -8; ...
    lt(6) 0; lt(6) 4; lt(6) 12; lt(6) 21; ...
    lt(7) -10; lt(7) -6; lt(7) -2; lt(7) 0; lt(7) 2; ...
    0 0; ...
    lt(9) -6];

gap = [.1 .03]; margh = .1; margw = .1;

subtightplot(2,1,1, gap, margh, margw)
m_proj('Mercator', 'longitudes', [ledge 15], 'latitudes', [-22 22]);
hold on       
    [h C] = m_contourf(circshift(sstclim.lon,180), sstclim.lat, circshift(squeeze(sstavg(:,:,1)),180)', [0 20:.25:30]); 
    set(C,'edgecolor','none');
    
    [c, h] = m_contour(circshift(olrlon, 72), olrlat, circshift(squeeze(olravg(:,:,1)), 72)', 200:20:300, '-k');
    h = clabel(c, h);
    
    m_quiver(taulon, taulat, qscale*tauxavg_summer, qscale*tauyavg_summer, 0, 'linewidth', qlw, 'color', 'k');
    m_quiver(taulon-360, taulat, qscale*tauxavg_summer, qscale*tauyavg_summer, 0,'k', 'linewidth', qlw);
    m_plot(locs(:,1), locs(:,2), 'kd', 'MarkerSize', 10, 'MarkerFaceColor',[.5 .5 .5]);
    m_plot(-23, 0, 'ks', 'MarkerSize', 14, 'MarkerFaceColor',[.5 .5 .5]);

hold off
title('June/July/August', 'FontSize', 16);
m_coast('patch', [.7 .7 .7]);
m_grid('xtick', 7, 'ytick', 5, 'box', 'fancy', 'FontSize', 16);
set(gca, 'FontSize', 16);

hold on
m_quiver(-6, 17.5, .1*qscale, 0, 0,'k', 'linewidth', qlw);
m_text(-8, 16, '.1 N m^{-2}', 'FontSize', 14);
hold off
set(gca, 'clim', [20 30]);
colormap(cptcmap('temperature'));
cb = colorbar;
set(get(cb, 'ylabel'), 'String', '^{\circ}C');
set(cb, 'Position', [.6 .7 .016 .1]);

set(gcf, 'Color', 'w');
set(gca, 'clim', [20 30]);
colormap(cptcmap('temperature'));
axes_label('a)', 20, 20);


subtightplot(2,1,2, gap, margh, margw)
m_proj('Mercator', 'longitudes', [ledge 15], 'latitudes', [-22 22]);
hold on       
    [h C] = m_contourf(circshift(sstclim.lon,180), sstclim.lat, circshift(squeeze(sstavg(:,:,2)),180)', [0 20:.25:30]); 
    set(C,'edgecolor','none');
    
    [c, h] = m_contour(circshift(olrlon, 72), olrlat, circshift(squeeze(olravg(:,:,2)), 72)', 200:20:300, '-k');
    h = clabel(c, h);
%     set(h, 'backgroundcolor', [1 1 1]);
    m_quiver(taulon, taulat, qscale*tauxavg_winter, qscale*tauyavg_winter, 0,'k', 'linewidth', qlw);
    m_quiver(taulon-360, taulat, qscale*tauxavg_winter, qscale*tauyavg_winter, 0,'k', 'linewidth', qlw);
    m_plot(locs(:,1), locs(:,2), 'kd', 'MarkerSize', 10, 'MarkerFaceColor',[.5 .5 .5]);
    m_plot(-23, 0, 'ks', 'MarkerSize', 14, 'MarkerFaceColor',[.5 .5 .5]);
    
hold off
title('December/January/February', 'FontSize', 16);
m_coast('patch', [.7 .7 .7]);
m_grid('xtick', 7, 'ytick', 5, 'box', 'fancy', 'FontSize', 16);
set(gca, 'FontSize', 16);

hold on
m_quiver(-6, 17.5, .1*qscale, 0, 0,'k', 'linewidth', qlw);
m_text(-8, 16, '.1 N m^{-2}', 'FontSize', 14);
hold off
set(gca, 'clim', [20 30]);
colormap(cptcmap('temperature'));
cb = colorbar;
set(get(cb, 'ylabel'), 'String', '^{\circ}C');
set(cb, 'Position', [.6 .32 .016 .1]);
axes_label('b)', 20, 20);

set(gcf, 'Color', 'w');