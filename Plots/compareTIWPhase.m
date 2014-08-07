function compareTIWPhase(dataset, twarm, tcold)

maxdepth = 5;

rivar = dataset.deepadcp.riforward_sort;

[ribyhrwarm riwarmbins] = bindatabyhour(rivar(twarm,:), dataset.descriptors.datesen(twarm));
[ribyhrcold ricoldbins] = bindatabyhour(rivar(tcold,:), dataset.descriptors.datesen(tcold));

[~, nbins] = size(rivar);
% PDF differences by depth
edges = 0:.125:4;

ridiff = ribyhrcold - ribyhrwarm;

for i=1:nbins
    nwarm(:,i) = histc(rivar(twarm,i), edges);
    nwarm(:,i) = nwarm(:,i)./(sum(nwarm(:,i)));
    
    ncold(:,i) = histc(rivar(tcold,i), edges);
    ncold(:,i) = ncold(:,i)./(sum(ncold(:,i)));
    
    ndiff(:,i) = ncold(:,i) - nwarm(:,i);
    
    for j=1:24
        cldhrtemp = histc(ricoldbins(j, :, i), edges);
        cldhrtemp = cldhrtemp./sum(cldhrtemp);
        wrmhrtemp = histc(riwarmbins(j,:,i), edges);
        wrmhrtemp = wrmhrtemp./sum(wrmhrtemp);
        
        bindiff(j,i) = sum(cldhrtemp(1:2) - wrmhrtemp(1:2)); %1:2 sums over Ri<.25
    end
end

% Histogram of surface values
subplot(1,3,1)
bar(edges, nwarm(:,1))
xlim(edges([1 end]));
vline(.25);

subplot(1,3,2)
bar(edges, ncold(:,1));
xlim(edges([1 end]));
vline(.25)

subplot(1,3,3)
bar(edges, ndiff(:,1));
xlim(edges([1 end]));
vline(.25)



% % By Depth
% figure
% 
% 
% pcolor(edges, dataset.deepadcp.riforwarddepths(1:maxdepth), ndiff(:,1:maxdepth)');
% caxis([-.5 .5]);
% colorbar;
% set(gca, 'ydir', 'reverse');
% 
% colormap(cptcmap('dkbluered'));
% 
% % By Hr

h = .5*ones(3); h(2,2) = 1; h = 1/5 * h; %Weight center position most


figure
contourf(0:23, dataset.deepadcp.riforwarddepths(1:maxdepth), filter2(h, bindiff(:, 1:maxdepth)'));
colorbar;
set(gca, 'ydir', 'reverse');
caxis([-.5 .5]);
colormap(cptcmap('dkbluered'));
hold on
plot(0:23, bindatabyhour(dataset.density.fulldepth.fullmldh(twarm), dataset.descriptors.datesen(twarm)), 'k', 'LineWidth', 2)
hold off
title('Percent Diff: Ri<Ri_{cr}');

cl = [-10 10];
figure
contourf(0:23, dataset.deepadcp.riforwarddepths(1:maxdepth), filter2(h, ridiff(:, 1:maxdepth)'), linspace(cl(1), cl(2), 20));
colorbar;
set(gca, 'ydir', 'reverse');
caxis(cl);
colormap(cptcmap('dkbluered'));
hold on
plot(0:23, bindatabyhour(dataset.density.fulldepth.fullmldh(twarm), dataset.descriptors.datesen(twarm)), 'k', 'LineWidth', 2)
hold off
title('Ri_{cold} - Ri{warm}');
end