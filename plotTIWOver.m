%%

ylimits = [0 80];
tickfreq = 2;
dateform = 'dd';
% eyepics = dataset.density.isopycs(logical(repmat(eye(1,2), 1, 5)));
eyepics = [1025 1025];
depthrange = 1:18;
r = tiwcold(1):(tiwwarm(end)+24*16);
temp = 1./dataset.deepadcp.riforward_sort;
temp(~isfinite(temp)) = NaN;
mlddef = dataset.density.fulldepth.fullmldh;
% datearray = datenum(2008, 15:2:80, 1);
yti = 0:20:100;
mlw = 1.6;

h = .5*ones(3); h(2,2) = 1; h = 1/5 * h; %Weight center position most
h = 1;
gap=[.02 .05]; margh=.2; margw  = .1;
figure

%===================== Heat Flux ======================
subtightplot(6,1,1, gap, margh, margw)
    plot(dataset.descriptors.datesen(r), dataset.flux.netheat(r), 'k', 'LineWidth', 2)
    grid on
    
    xlim([dataset.descriptors.datesen(r(1)) dataset.descriptors.datesen(r(end))]);
    set(gca, 'xtick', datenum(2008, 10, 1:tickfreq:100), 'FontSize', 12);

    datetick('x', dateform, 'keeplimits', 'keepticks')
    set(gca, 'xtickLabel', [], 'FontSize', 16);
    cb = colorbar;
    set(cb, 'visible', 'off');
    ylim([-250 1000]);
    set(gca, 'ytick', -250:250:1000, 'yticklabel', {'-250', '0', [], '500', [], '1000'});
    hold on
    xt = get(gca, 'xtick');
    plot(xt, 0*xt, 'k', 'LineWidth', 1.5);
    hold off
    ylabel({'Net Heat Flux', 'W m^{-2}'}, 'FontSize', 16);

    axes_label('a)', 200, 5);
    axes_label('b)', 210, 5);
    axes_label('c)', 220, 5);
    axes_label('d)', 230, 5);
    axes_label('e)', 240, 5);
    fl = axes_label('f)', 250, 5);

%===================== SST ======================
subtightplot(6,1,2, gap, margh, margw)
    plot(dataset.descriptors.datesen(r), dataset.density.fulldepth.temps(1,r), 'k', 'LineWidth', 2)
    grid on
    
    xlim([dataset.descriptors.datesen(r(1)) dataset.descriptors.datesen(r(end))]);
    set(gca, 'xtick', datenum(2008, 10, 1:tickfreq:100), 'FontSize', 12);

    datetick('x', dateform, 'keeplimits', 'keepticks')
    set(gca, 'xtickLabel', [], 'FontSize', 16);
    cb = colorbar;
    set(cb, 'visible', 'off');
    ylim([26 28.5]);
    set(gca, 'ytick', 26:.5:28.5, 'yticklabel', {'26', [], '27' ,  [], '28', []});
    hold on
    hold off
    ylabel({'SST', '^{\circ}C'}, 'FontSize', 16);
%     xlabel('SST', 'FontSize', 16);
    
%========== Merid Vel ===================
subtightplot(6,1, 3, gap, margh, margw)
% plot(dataset.descriptors.datesen(r), nanmean(dataset.measures.Nmmpersecih(r,1:35), 2)/1000, 'k', 'LineWidth', 2);

[~, children] = contourf(dataset.descriptors.datesen(r), dataset.deepadcp.fulldepths(1:50),  filter2(h, naninterpmatrix(dataset.deepadcp.fullv(r,1:50)')));  set(gca, 'ydir', 'reverse')
% [~, children] = contourf(dataset.descriptors.datesen(r), dataset.density.fulldepth.saldepth(1:6),  dataset.density.fulldepth.sals(r,1:6)', 34:.05:37);  set(gca, 'ydir', 'reverse')

set(children, 'edgecolor', 'none');
xlim(dataset.descriptors.datesen(r([1 end])))
set(gca, 'xtick', datenum(2008, 10, 1:tickfreq:100), 'yTick', yti);
ylim(ylimits);

datetick('x', dateform, 'keeplimits', 'keepticks')
set(gca, 'xtickLabel', [], 'FontSize', 16);

hold on
ylabel('Depth (m)');

contour(dataset.descriptors.datesen(r), dataset.deepadcp.fulldepths(:), dataset.density.fulldepth.fulldensityi(r, :)', eyepics, 'k');
plot(dataset.descriptors.datesen(r), mlddef(r), 'k', 'LineWidth', mlw);

% plot(dataset.descriptors.datesen(r), smooth(thermodepth(r), 24*5), 'k', 'LineWidth', 2);
hold off
caxis([-.5 .5]); 
% [~, children] = contourf(dataset.descriptors.datesen(r), dataset.deepadcp.fulldepths(dataset.deepadcp.riforwarddepthmask(depthrange)),  dataset.deepadcp.fullv(r,depthrange)');  set(gca, 'ydir', 'reverse')
% set(children, 'edgecolor', 'none');

cb = colorbar;
set(get(cb, 'XLabel'), 'String', 'V (m s^{-1})', 'FontSize', 16);
set(cb, 'FontSize', 16)
grid on


%============== N2 =================
subtightplot(6,1,4, gap, margh, margw)
[~, children] = contourf(dataset.descriptors.datesen(r), dataset.deepadcp.riforwarddepths,  filter2(h, naninterpmatrix(double(log10(dataset.deepadcp.n2forward(r,:)))')), [-10 -6:.125:-2]);  set(gca, 'ydir', 'reverse')
set(children, 'edgecolor', 'none');

hold on
contour(dataset.descriptors.datesen(r), dataset.deepadcp.fulldepths(:), dataset.density.fulldepth.fulldensityi(r, :)', eyepics, 'k');
% plot(dataset.descriptors.datesen(r), smooth(thermodepth(r), 24*5), 'k', 'LineWidth', 2);

% plot(dataset.descriptors.datesen(r), dataset.density.isopyc(r,5), 'w', 'LineWidth', 2);
% plot(dataset.descriptors.datesen(r), dataset.density.fulldepth.mldT(r), 'w', 'LineWidth', 2);
plot(dataset.descriptors.datesen(r), mlddef(r), 'k', 'LineWidth', mlw);

colormap(jet);
caxis([-6 -3]); 
hold off
xlim(dataset.descriptors.datesen(r([1 end])))
set(gca, 'xtick', datenum(2008, 10, 1:tickfreq:100),'ytick', yti, 'FontSize', 16);

datetick('x', dateform, 'keeplimits', 'keepticks')
set(gca, 'xtickLabel', []);

cb = colorbar;
set(get(cb, 'XLabel'), 'String', 'log_{10}(N^2 s^{-2})', 'FontSize', 16);
set(cb, 'FontSize', 16)
ylabel('Depth (m)');
ylim(ylimits);
grid on

%================= Sh^2 =================
subtightplot(6,1,5, gap, margh, margw)
[~, children] = contourf(dataset.descriptors.datesen(r), dataset.deepadcp.riforwarddepths,  filter2(h, naninterpmatrix(double(log10(dataset.deepadcp.sh2forward(r,:)))')), [-10 -6:.5:-2]);  set(gca, 'ydir', 'reverse')
set(children, 'edgecolor', 'none');
hold on
contour(dataset.descriptors.datesen(r), dataset.deepadcp.fulldepths(:), dataset.density.fulldepth.fulldensityi(r, :)', eyepics, 'k');
% plot(dataset.descriptors.datesen(r), smooth(thermodepth(r), 24*5), 'k', 'LineWidth', 2);

% plot(dataset.descriptors.datesen(r), dataset.density.isopyc(r,5), 'w', 'LineWidth', 2);
% plot(dataset.descriptors.datesen(r), dataset.density.fulldepth.mldT(r), 'w', 'LineWidth', 2);
plot(dataset.descriptors.datesen(r), mlddef(r), 'k', 'LineWidth', mlw);

caxis([-6 -3]); 
hold off
xlim(dataset.descriptors.datesen(r([1 end])))
set(gca, 'xtick', datenum(2008, 10, 1:tickfreq:100),'ytick', yti);

datetick('x', dateform, 'keeplimits', 'keepticks')
set(gca, 'xtickLabel', [], 'FontSize', 16);
cb = colorbar;
set(get(cb, 'XLabel'), 'String', 'log_{10}(u_z^2 s^{-2})', 'FontSize', 16);
set(cb, 'FontSize', 16)
ylabel('Depth (m)');
ylim(ylimits);
grid on


% ===================== Sh^2_red ===============
subtightplot(6,1,6, gap, margh, margw)
rivar = naninterpmatrix(double(dataset.deepadcp.riforwardreduce_sort(r,1:10))');
% [~, children] = contourf(dataset.descriptors.datesen(r), dataset.deepadcp.fulldepths(dataset.deepadcp.riforwarddepthmask(depthrange)),  double(dataset.deepadcp.riforwardreduce(r,depthrange))');  set(gca, 'ydir', 'reverse')
[~, children] = contourf(dataset.descriptors.datesen(r), dataset.deepadcp.riforwarddepths,...
    filter2(h, 10^3.*naninterpmatrix(dataset.deepadcp.riforwardreduce_sort(r,:)')), 10^3.*[-1e-1 linspace(-2e-3, 2e-3,15)]);
%     filter2(h, naninterpmatrix(double((dataset.deepadcp.sh2forward(r,:)))'))./filter2(h, naninterpmatrix(double((dataset.deepadcp.n2forward(r,:)))')), 0:.25:8);
set(gca, 'ydir', 'reverse')

set(children, 'edgecolor', 'none');
hold on
% plot(dataset.descriptors.datesen(r), dataset.density.isopyc(r,:), 'k',
% 'LineWidth', 1);
% plot(dataset.descriptors.datesen(r), smooth(thermodepth(r), 24*5), 'k', 'LineWidth', 2);
contour(dataset.descriptors.datesen(r), dataset.deepadcp.fulldepths(:), dataset.density.fulldepth.fulldensityi(r, :)', eyepics, 'k');
% plot(dataset.descriptors.datesen(r), dataset.density.isopyc(r,5), 'w', 'LineWidth', 2);
plot(dataset.descriptors.datesen(r), mlddef(r), 'k', 'LineWidth', mlw);
% caxis([0 8]); 
caxis([-2e-3 2e-3].*10^3);
xlim(dataset.descriptors.datesen(r([1 end])))
grid on
hold off
set(gca, 'xtick', datenum(2008, 10, 1:tickfreq:100),'ytick', yti, 'FontSize', 16);

datetick('x', dateform, 'keeplimits', 'keepticks')
% set(get(gca, 'xlabel'), 'FontSize', 10);
xlabel('Oct                                                                                     Nov', 'FontSize', 16)

cb = colorbar;
set(get(cb, 'XLabel'), 'String', {'10^3 \times Sh^2_{red}', '(s^{-2})'}, 'FontSize', 16);
set(cb, 'FontSize', 16)
ylabel('Depth (m)');
ylim(ylimits);
% packrows(4,1);
% colormap(othercolor('BuOr_12'));
pause();
hmap = cptcmap('royal');
colormap(hmap(10:198,:));
set(gcf, 'Color', 'w', 'Position', [-100 100 1340 1000]);