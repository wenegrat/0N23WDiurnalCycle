range = detail1;
maxdepth = 30;
dateform ='dd-mm';
cl = [-10 10];

hf = .5*ones(3); hf(2,2) = 1; hf = 1/5 * hf; %Weight center position most


% vari = diff(ame(range, 1:maxdepth+1),1,2);
% vari = diff(ame([range range(end)+1], 1:maxdepth),1,1);

vari = ame(range, 1:maxdepth);
% 
% bvari = naninterpmatrix(vari')';
% for i=1:20
% bvari = filter2(hf, bvari);
% end
% vari = vari-bvari;



gap = [.02 .1];
margh = .1; margw = .1;


subtightplot(8,1,1, gap, margh, margw)
    plot(dataset.descriptors.datesen(range), dataset.flux.netheat(range), 'k', 'LineWidth', 2)
    set(gca, 'xlim', [dataset.descriptors.datesen(range([1 end]))]);
    
%     set(gca, 'xtick', datearray, 'FontSize', 12);

    datetick('x', dateform, 'keeplimits', 'keepticks')
    set(gca, 'xtickLabel', [], 'FontSize', 16);
    cb = colorbar;
    set(cb, 'visible', 'off');
    ylim([-250 1000]);
    set(gca, 'ytick', -250:250:1000, 'yticklabel', {'-250', '0', [], '500', [], '1000'});
    hold on
%     xt = get(gca, 'xtick');
%     plot(xt, 0*xt, 'k', 'LineWidth', 1.5);
    hold off
    ylabel({'Neat Heat Flux', 'W m^{-2}'}, 'FontSize', 16);
    title([datestr(dataset.descriptors.datesen(range(1))), ' UTC   -   ', datestr(dataset.descriptors.datesen(range(end))), ' UTC'], 'FontSize', 16);
    grid on
    
    subtightplot(8,1,2, gap, margh, margw)
    plot(dataset.descriptors.datesen(range), dataset.measures.tauxh(range), 'k', 'LineWidth', 2)
        set(gca, 'xlim', [dataset.descriptors.datesen(range([1 end]))]);

    grid on
    
%     xlim([dataset.descriptors.datesen(r(1)+12) dataset.descriptors.datesen(r(end)-12)]);
%     set(gca, 'xtick', datearray, 'FontSize', 12);

    datetick('x', dateform, 'keeplimits', 'keepticks')
    set(gca, 'xtickLabel', [], 'FontSize', 16);
    cb = colorbar;
    set(cb, 'visible', 'off');
%     ylim([-250 1000]);
%     set(gca, 'ytick', -250:250:1000, 'yticklabel', {'-250', '0', [], '500', [], '1000'});
    hold on
        plot(dataset.descriptors.datesen(range), dataset.measures.tauyh(range), '--k', 'LineWidth', 2)

%     xt = get(gca, 'xtick');
%     plot(xt, 0*xt, 'k', 'LineWidth', 1.5);
    hold off
    ylabel({'Wind Stress', 'N m^{-2}'}, 'FontSize', 16);
    grid on

subtightplot(8,1,3:4, gap, margh, margw)
    contourf(dataset.descriptors.datesen(range), dps(1:maxdepth), vari', linspace(cl(1), cl(end), 20));  set(gca, 'ydir', 'reverse');
    caxis(cl);
    datetick('x', dateform, 'keeplimits', 'keepticks')
    set(gca, 'XTickLabel', []);
    hold on
    plot(dataset.descriptors.datesen(range), dataset.density.fulldepth.fullmldh(range), 'k', 'LineWidth', 2);
    % contour(dataset.descriptors.datesen(range), dps(1:maxdepth), vari', [0 0], 'w', 'LineWidth', 1.5);  

    hold off
    cb = colorbar;
    set(get(cb, 'YLabel'), 'String', 'LME', 'FontSize', 16);
    set(gca, 'FontSize', 16);
    grid on
    
subtightplot(8,1,5:6, gap, margh, margw)
    contourf(dataset.descriptors.datesen(range), dps(1:maxdepth), -ape(range,1:maxdepth)', linspace(cl(1), cl(end), 20));  set(gca, 'ydir', 'reverse');
    caxis(cl);
    datetick('x', dateform, 'keeplimits', 'keepticks')
    set(gca, 'XTickLabel', []);
    hold on
    plot(dataset.descriptors.datesen(range), dataset.density.fulldepth.fullmldh(range), 'k', 'LineWidth', 2);
    % contour(dataset.descriptors.datesen(range), dps(1:maxdepth), vari', [0 0], 'w', 'LineWidth', 1.5);  

    hold off
    cb = colorbar;
    set(get(cb, 'YLabel'), 'String', '-APE', 'FontSize', 16);
    set(gca, 'FontSize', 16);
    grid on
    
subtightplot(8,1,7:8, gap, margh, margw)
    contourf(dataset.descriptors.datesen(range), dps(1:maxdepth), gamma*ake(range,1:maxdepth)', linspace(cl(1), cl(end), 20));  set(gca, 'ydir', 'reverse');
    caxis(cl);
    datetick('x', dateform, 'keeplimits', 'keepticks')

    hold on
    plot(dataset.descriptors.datesen(range), dataset.density.fulldepth.fullmldh(range), 'k', 'LineWidth', 2);
    % contour(dataset.descriptors.datesen(range), dps(1:maxdepth), vari', [0 0], 'w', 'LineWidth', 1.5);  

    hold off
    cb = colorbar;
    set(get(cb, 'YLabel'), 'String', 'LKE', 'FontSize', 16);
    set(gca, 'FontSize', 16);
    grid on 
colormap(cptcmap('dkbluered'))
set(gcf, 'color', 'w');