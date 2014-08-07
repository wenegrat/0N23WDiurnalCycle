% Analyze Fairall 96 output
trange = tiwwarm; %calm(1800:2170);%tiwcold(1:end-14); %1900-2270

%%
hfmask = double(netheat >0);
hfmask(hfmask == 0) = NaN; % use this mask to multiply

plotDetailsWF96(dataset, trange,  Dt, mldm, hfmask, [-10 -6:.125:-1], [-4 -2]);

%%
% Temperature
traded = 1:86;
calmed = 87:224;
mask = isfinite(Dt) & Dt>1;

%Note this is incorrect due to masking before taking deltaDaily.
dels = deltaDaily(dataset.density.fulldepth.temps(1,mask), dataset.descriptors.datesen(mask));

delsm = deltaDaily(T(mask) , dataset.descriptors.datesen(mask));
% delsm = maxDaily(T(mask), dataset.descriptors.datesen(mask));
figure
scatter(dels(traded), delsm(traded), 30, dataset.measures.taudird(traded), 'filled');
hold on
scatter(dels(calmed), delsm(calmed), 30, 'b', 'filled');
hold off
grid on
onetoone
mask = isfinite(dels) & isfinite(delsm);
r = regress(delsm(mask) ,dels(mask));
c = corr(dels, delsm, 'rows', 'pairwise');
title(['r = ', num2str(r), '   Corr = ', num2str(c)])


%%
% Find the MLD
hfmask = double(netheat >0);
hfmask(hfmask == 0) = NaN; % use this mask to multiply


deltaT = .047; %See CalculateDensity.m
mldm = deltaT*Dt'./T + 1;
mask = mldm < Dt';
mldm(~mask) = NaN;


figure
scatter(dataset.density.fulldepth.mldT, hfmask.*mldm, 20, netheat);
grid on
onetoone
c = corr(dataset.density.fulldepth.mldT, hfmask.*mldm, 'rows', 'pairwise');
title(num2str(c))
%%
% Velocity Shear
clear sh msh dtt
figure
sh = 0;
msh = 0;
dtt = 0;
for i=1:5967
    mask = (Dt(i) > dataset.deepadcp.riforwarddepths) & (dataset.density.fulldepth.fullmldh(i) > 8) & netheat(i)>0;
    mask = Dt(i) > dataset.deepadcp.fulldepths;
    shtemp = nanmedian(dataset.deepadcp.fullmagsh(i,mask));
%     shtemp = median(dataset.deepadcp.sh2forward(i,mask).^(1/2));
    sh = [sh shtemp];
    msh = [msh U(i)./Dt(i).*ones(size(shtemp))];
    dtt = [dtt Dt(i).*ones(size(shtemp))];
end
X = [sh; msh]';
ctrs{1} = 0:.0005:.02;
ctrs{2} = ctrs{1};
n = hist3(X, ctrs);
close all
xb = ctrs{1};%linspace(nanmin(X(:,1)),nanmax(X(:,1)),size(n,1));
yb = ctrs{2};%linspace(nanmin(X(:,2)),nanmax(X(:,2)),size(n,2));
pcolor(xb, yb, n'/sum(sum(n))); 

% scatter(shmag(mask), U(mask)./Dt(mask), 20, Dt(mask))
onetoone
colorbar
c = corr(sh', msh', 'rows', 'pairwise');
title(num2str(c))
colormap(cptcmap('GMT_haxby'));

%%
mdepth = 4;
g = [.2 .2 .2];
hfmask = double(netheat(trange) >0);
hfmask(hfmask == 0) = NaN; % use this mask to multiply


figure
ts = dataset.density.fulldepth.temps(1,trange);
[tmin tmint] = minDaily(dataset.density.fulldepth.temps(1,:), dataset.descriptors.datesen(:));

subtightplot(3, 1, 1)
plot(dataset.descriptors.datesen(trange), (ts) , 'k', 'LineWidth', 2)
hold on
plot(dataset.descriptors.datesen(trange),  (tmint(trange-1)'+ (T(trange) - T(trange)./Dt(trange)')), '--g', 'LineWidth', 2.5);
plot(dataset.descriptors.datesen(trange),  hfmask.*(tmint(trange-1)'+ (T(trange) - T(trange)./Dt(trange)')), 'g', 'LineWidth', 2.5);
hold off
grid on
set(gca, 'xtick', dataset.descriptors.datesen(trange(1)) + (datenum(0,0,1:300)), 'xlim', dataset.descriptors.datesen(trange([1 end])));
datetick('x', 'mm-dd', 'keepticks', 'keeplimits');
ylabel('^{\circ}C', 'FontSize', 16);
set(gca, 'FontSize', 16, 'XTickLabel', []);
cb = colorbar;
set(cb, 'visible', 'off');

subtightplot(3,1,2:3)
contourf(dataset.descriptors.datesen(trange), dataset.density.fulldepth.tempdepth(1:mdepth), dataset.density.fulldepth.temps(1:mdepth,trange), 20);
set(gca, 'ydir', 'reverse')
hold on
plot(dataset.descriptors.datesen(trange), Dt(trange), '--k', 'LineWidth', 2.5);
plot(dataset.descriptors.datesen(trange), hfmask'.*Dt(trange), 'k', 'LineWidth', 2.5);
plot(dataset.descriptors.datesen(trange), mldm(trange), '--','color', 'm' ,'LineWidth', 2.5);
plot(dataset.descriptors.datesen(trange), hfmask.*mldm(trange), 'color', 'm', 'LineWidth', 2.5);

hold off
grid on
set(gca, 'xtick', dataset.descriptors.datesen(trange(1)) + (datenum(0,0,1:300)));
datetick('x', 'mm-dd', 'keepticks', 'keeplimits');
ylabel('Depth m', 'FontSize', 16);
cb = colorbar;
set(get(cb, 'ylabel'), 'String', '^{\circ}C', 'FontSize', 16);
set(gca, 'FontSize', 16);

set(gcf, 'color', 'w', 'Position', [0 0 1300 660]);

%%
plotDetails(dataset, trange);
hold on
plot(dataset.descriptors.datesen(trange), Dt(trange), 'g', 'LineWidth', 2);
hold off



%%
% Shear
%%
mdepth = 5;
g = [.2 .2 .2];
hfmask = double(netheat(trange) >0);
hfmask(hfmask == 0) = NaN; % use this mask to multiply


figure
ts = dataset.density.fulldepth.temps(1,trange);
[tmin tmint] = minDaily(dataset.density.fulldepth.temps(1,:), dataset.descriptors.datesen(:));

subtightplot(3, 1, 1)
plot(dataset.descriptors.datesen(trange), (ts) , 'k', 'LineWidth', 2)
hold on
plot(dataset.descriptors.datesen(trange),  (tmint(trange-1)'+ (T(trange) - T(trange)./Dt(trange)')), '--g', 'LineWidth', 2.5);
plot(dataset.descriptors.datesen(trange),  hfmask.*(tmint(trange-1)'+ (T(trange) - T(trange)./Dt(trange)')), 'g', 'LineWidth', 2.5);
hold off
grid on
set(gca, 'xtick', dataset.descriptors.datesen(trange(1)) + (datenum(0,0,1:300)), 'xlim', dataset.descriptors.datesen(trange([1 end])));
datetick('x', 'mm-dd', 'keepticks', 'keeplimits');
ylabel('^{\circ}C', 'FontSize', 16);
set(gca, 'FontSize', 16, 'XTickLabel', []);
cb = colorbar;
set(cb, 'visible', 'off');

subtightplot(3,1,2:3)
contourf(dataset.descriptors.datesen(trange), dataset.deepadcp.riforwarddepths(1:mdepth), log10(dataset.deepadcp.sh2forward(trange,1:mdepth))', 20);
set(gca, 'ydir', 'reverse')
hold on
plot(dataset.descriptors.datesen(trange), Dt(trange), '--k', 'LineWidth', 2.5);
plot(dataset.descriptors.datesen(trange), hfmask'.*Dt(trange), 'k', 'LineWidth', 2.5);
plot(dataset.descriptors.datesen(trange), mldm(trange), '--','color', 'm' ,'LineWidth', 2.5);
plot(dataset.descriptors.datesen(trange), hfmask.*mldm(trange), 'color', 'm', 'LineWidth', 2.5);
plot(dataset.descriptors.datesen(trange), (Dt(trange)')/2, 'r', 'LineWidth', 3);

hold off
grid on
set(gca, 'xtick', dataset.descriptors.datesen(trange(1)) + (datenum(0,0,1:300)));
datetick('x', 'mm-dd', 'keepticks', 'keeplimits');
ylabel('Depth m', 'FontSize', 16);
cb = colorbar;
set(get(cb, 'ylabel'), 'String', '^{\circ}C', 'FontSize', 16);
set(gca, 'FontSize', 16);

set(gcf, 'color', 'w', 'Position', [0 0 1300 660]);
