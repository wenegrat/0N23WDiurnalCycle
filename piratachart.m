%%
%==================LOCATION CHART =====================================
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

m_proj('Mercator', 'longitudes', [-45 15], 'latitudes', [-22 22]);
    m_coast('patch', [.7 .7 .7]);
    m_grid('xtick', 5, 'ytick', 9, 'FontSize', 16);
    m_tbase('contour', [-5000:1000:-1000], 'edgecolor', [.7 .7 .7]);

    hold on
    
m_plot(locs(:,1), locs(:,2), 'kd', 'MarkerSize', 10, 'MarkerFaceColor','k');
m_plot(-23, 0, 'rd', 'MarkerSize', 14, 'MarkerFaceColor','r');

hold off
title('PIRATA Array', 'FontSize', 16);


% hold off
set(gca, 'FontSize', 16);
% 
% m_legend([h1 h2], 'ADCP', 'RAMA');
set(gcf, 'Color', 'w');