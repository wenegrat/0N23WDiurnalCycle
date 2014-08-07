function plotDetails2(dataset, r)

    ylimits = [0 30];
    tickfreq = 4;
    dateform = 'HH';
    datearray = datenum(2008, 10, 1, 0:tickfreq:300*24, 1, 1);
    % eyepics = dataset.density.isopycs(logical(repmat(eye(1,2), 1, 5)));
    eyepics = [1025 1025];
    depthrange = 1:18;

    h = .5*ones(3); h(2,2) = 1; h = 1/5 * h; %Weight center position most
    gap=[.03 .1]; margh=.1; margw  = .1;

    uvar = dataset.descriptors.mask(:,1:35).*dataset.deepadcp.fullu(:,1:35);
    vvar = dataset.descriptors.mask(:,1:35).*dataset.deepadcp.fullv(:,1:35);
    ush = diff(uvar')'./.75;
    vsh = diff(vvar')'./.75;
    
    shvar = interp1(dataset.deepadcp.fulldepths(1:34)+(.75/2), (ush.^2+vsh.^2)', dataset.deepadcp.fulldepths(1:34))';
%     shvar = naninterpmatrix(shvar);
    
figure
    % ======= Flux
    subtightplot(7,1,1, gap, margh, margw)
    plot(dataset.descriptors.datesen(r), dataset.flux.netheat(r), 'k', 'LineWidth', 2)
    grid on
    
    xlim([dataset.descriptors.datesen(r(1)+12) dataset.descriptors.datesen(r(end)-12)]);
    set(gca, 'xtick', datearray, 'FontSize', 12);

    datetick('x', dateform, 'keeplimits', 'keepticks')
    set(gca, 'xtickLabel', []);
    cb = colorbar;
    set(cb, 'visible', 'off');
    ylim([-250 1000]);
    set(gca, 'ytick', -250:250:1000, 'yticklabel', {'-250', '0', [], '500', [], '1000'});
    hold on
    xt = get(gca, 'xtick');
    plot(xt, 0*xt, 'k', 'LineWidth', 1.5);
    hold off
    ylabel({'Net Heat Flux', 'W m^{-2}'}, 'FontSize', 12);
    
    % ======== N^2
    subtightplot(7,1,2:3, gap, margh, margw)
    [~, children] = contourf(dataset.descriptors.datesen(r), dataset.deepadcp.riforwarddepths,   naninterpmatrix(double(log10(dataset.deepadcp.n2forward_sort(r,:)))'), [-10 -6:.125:-2]);  set(gca, 'ydir', 'reverse')
    set(children, 'edgecolor', 'none');

    hold on

    plot(dataset.descriptors.datesen(r), dataset.density.fulldepth.fullmldh(r), 'k', 'LineWidth', 2);

    colormap(jet);
    caxis([-6 -2]); 
    hold off
    xlim([dataset.descriptors.datesen(r(1)+12) dataset.descriptors.datesen(r(end)-12)]);
   set(gca, 'xtick', datearray);

    datetick('x', dateform, 'keeplimits', 'keepticks')
    set(gca, 'xtickLabel', [], 'FontSize', 12);

    cb = colorbar;
    set(get(cb, 'YLabel'), 'String', 'log10(N^2 s^{-2})', 'FontSize', 12);
    ylabel('Depth (m)');
    ylim(ylimits);
    grid on
    
    % ========== Sh^2
    subtightplot(7,1,4:5, gap, margh, margw)
%     [~, children] = contourf(dataset.descriptors.datesen(r), dataset.deepadcp.riforwarddepths,   naninterpmatrix(double(log10(dataset.deepadcp.sh2forward(r,:)))'), [-10 -6:.125:-2]);  set(gca, 'ydir', 'reverse')
    [~, children] = contourf(dataset.descriptors.datesen(r), dataset.deepadcp.fulldepths(1:34),   naninterpmatrix(double(log10(shvar(r,:)))'), [-10 -6:.125:-2]);  set(gca, 'ydir', 'reverse')

    set(children, 'edgecolor', 'none');
    hold on

    plot(dataset.descriptors.datesen(r), dataset.density.fulldepth.fullmldh(r), 'k', 'LineWidth', 2);

    caxis([-6 -2]); 
    hold off
    xlim([dataset.descriptors.datesen(r(1)+12) dataset.descriptors.datesen(r(end)-12)]);
    set(gca, 'xtick', datearray);

    datetick('x', dateform, 'keeplimits', 'keepticks')
    set(gca, 'xtickLabel', [], 'FontSize', 12);
    cb = colorbar;
    set(get(cb, 'YLabel'), 'String', 'log10(Sh^2 s^{-2})', 'FontSize', 12);
    ylabel('Depth (m)');
    ylim(ylimits);
    grid on

    % ============== RSh^2
    
    [xi yi] = meshgrid(interp1(1:length(r), dataset.descriptors.datesen(r), 1:.25:length(r)), 0:1:50);
    
    subtightplot(7,1,6:7, gap, margh, margw)
%     rivar = naninterpmatrix(double(dataset.deepadcp.riforwardreduce_sort(r,1:10)));
%         rivar = filter2(h, naninterpmatrix(double((dataset.deepadcp.n2forward(r,:)))))./...
%             filter2(h, naninterpmatrix(double((dataset.deepadcp.sh2forward(r,:)))));
    rivar =  naninterpmatrix(dataset.deepadcp.riforwardreduce_sort(r,1:10));
    zi = interp2(dataset.descriptors.datesen(r), dataset.deepadcp.riforwarddepths, rivar', xi, yi);
    
    rilims = [ -2e-4 2e-4];
    % [~, children] = contourf(dataset.descriptors.datesen(r), dataset.deepadcp.fulldepths(dataset.deepadcp.riforwarddepthmask(depthrange)),  double(dataset.deepadcp.riforwardreduce(r,depthrange))');  set(gca, 'ydir', 'reverse')
%     [~, children] = contourf(dataset.descriptors.datesen(r), dataset.deepadcp.riforwarddepths,...
%         naninterpmatrix(rivar'), [-1 linspace(rilims(1), rilims(2),70)]);
 [~, children] = contourf(xi, yi,...
        zi, [-1 linspace(rilims(1), rilims(2),70)]);
    %     filter2(h, naninterpmatrix(double((dataset.deepadcp.sh2forward(r,:)))'))./filter2(h, naninterpmatrix(double((dataset.deepadcp.n2forward(r,:)))')), 0:.25:8);
    set(gca, 'ydir', 'reverse')

    set(children, 'edgecolor', 'none');
    hold on
    % plot(dataset.descriptors.datesen(r), dataset.density.isopyc(r,:), 'k',
    % 'LineWidth', 1);
    % plot(dataset.descriptors.datesen(r), smooth(thermodepth(r), 24*5), 'k', 'LineWidth', 2);
%     contour(dataset.descriptors.datesen(r), dataset.deepadcp.riforwarddepths, filter2(h, naninterpmatrix(rivar')),[.25 .25], 'w');
    % plot(dataset.descriptors.datesen(r), dataset.density.isopyc(r,5), 'w', 'LineWidth', 2);
%         plot(dataset.descriptors.datesen(r), dataset.density.fulldepth.mldT(r), 'color', [.8 .8 .8], 'LineWidth', 1.5);
    plot(dataset.descriptors.datesen(r), dataset.density.fulldepth.fullmldh(r), 'k', 'LineWidth', 2);

    caxis(rilims);
    xlim([dataset.descriptors.datesen(r(1)+12) dataset.descriptors.datesen(r(end)-12)]);
    grid on
    hold off
    set(gca, 'xtick', datearray, 'FontSize', 12);

    datetick('x', dateform, 'keeplimits', 'keepticks')
    set(get(gca, 'xlabel'), 'FontSize', 10);

    cb = colorbar;
    set(get(cb, 'YLabel'), 'String', 'R-Sh^2 (s^{-2})', 'FontSize', 12);
    ylabel('Depth (m)');
    ylim(ylimits);
    xlabel('Hour UTC');
    % packrows(4,1);
% colormap(cptcmap('Blre'))
%     set(gcf, 'Color', 'w', 'units', 'normalized', 'Position', [.1 .1 .6839 .1775] );
    set(gcf, 'Color', 'w');
    colormap(cptcmap('temp_19lev'))

    end