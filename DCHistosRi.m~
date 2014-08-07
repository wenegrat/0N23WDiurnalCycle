%%
% DC Histograms
bins = 4:7;
edges = linspace(0, 2, 120);
diffs = (edges(1)-edges(2))/2;

t1 = trades;
sredvec = reshape(dataset.deepadcp.riforward_sort(t1, bins), length(t1)*length(bins), 1);
ntrades = histc(sredvec, edges);
ntrades = ntrades./sum(ntrades);

t2 = calm;
sredvec = reshape(dataset.deepadcp.riforward_sort(t2, bins), length(t2)*length(bins), 1);
ncalm = histc(sredvec, edges);
ncalm = ncalm./sum(ncalm);


ds = 1:11;
t1 =  trades;
t2 =  calm;
var = dataset.deepadcp.riforward_sort;

for i=1:length(ds)
    rim(i) = nanmedian(var(t1,i));
    rimci(i,1) = rim(i) - prctile(var(t1,i), 25);
    rimci(i,2) = prctile(var(t1,i), 75) - rim(i);

    rimc(i) = nanmedian(var(t2, i));
    rimcci(i,1) = rimc(i) - prctile(var(t2,i), 25);
    rimcci(i,2) = prctile(var(t2,i), 75) - rimc(i);
end
close all

figure


subplot(1,3,1)
[h hp] = boundedline(rim, dataset.deepadcp.riforwarddepths(ds), rimci, rimc, dataset.deepadcp.riforwarddepths(ds), rimcci, 'orientation', 'horiz');
set(hp(2), 'FaceColor', [.7 .7 .7], 'FaceAlpha', .5);
% set(hp(1), 'FaceAlpha', .9);
set(h(2), 'Color', 'k', 'LineWidth', 2);
set(h(1), 'LineWidth', 2);
set(gca, 'ydir', 'reverse');
grid on
xlabel('Sh^2_{red} (s^{-2})', 'FontSize', 16);
ylabel('Depth (m)', 'FontSize', 16);
set(gca, 'FontSize', 16);
set(gcf, 'Color', 'w');
legend('Trades', 'Variable', 'Location', 'NorthWest');
% xlim([-3e-3 1e-3]);
set(gca, 'xscale', 'log');
vline(0.25, 'k');
subplot(1,3,2:3)
plot(edges-diffs, ntrades, 'b', 'LineWidth', 2)
hold on
plot(edges-diffs, ncalm, 'k', 'LineWidth', 2);
hold off
grid on
xlabel('Sh^2_{red} (s^{-2})', 'FontSize', 16);
ylabel('% of Obs', 'FontSize', 16);
vline(0.25, 'k');

legend('Trades', 'Variable');
set(gca, 'FontSize', 16);
% xlim([-3e-3 3e-3]);
% set(gca, 'xscale', 'log');
title(['Depth range: ', num2str(dataset.deepadcp.riforwarddepths(bins(1)), 2), ' - ', num2str(dataset.deepadcp.riforwarddepths(bins(end))), ' m'], 'FontSize', 16); 
pause;
set(gcf, 'Color', 'w', 'Position', [0 0 1200 700]);
%%
clear rim rimc rimci rimcci
ds = 1:11;
t1 =  trades;
t2 =  calm;
var = dataset.deepadcp.riforwardreduce_sort;
for i=1:length(ds)
    rim(i) = nanmedian(var(t1,i));
    rimci(i,1) = rim(i) - prctile(var(t1,i), 25);
    rimci(i,2) = prctile(var(t1,i), 75) - rim(i);

    rimc(i) = nanmedian(var(t2, i));
    rimcci(i,1) = rimc(i) - prctile(var(t2,i), 25);
    rimcci(i,2) = prctile(var(t2,i), 75) - rimc(i);
end
close all

figure
[h hp] = boundedline(rim, dataset.deepadcp.riforwarddepths(ds), rimci, rimc, dataset.deepadcp.riforwarddepths(ds), rimcci, 'orientation', 'horiz');
set(hp(2), 'FaceColor', [.7 .7 .7], 'FaceAlpha', .5);
% set(hp(1), 'FaceAlpha', .9);
set(h(2), 'Color', 'k', 'LineWidth', 2);
set(h(1), 'LineWidth', 2);
set(gca, 'ydir', 'reverse');
grid on
xlabel('Sh^2_{red} (s^{-2})', 'FontSize', 16);
ylabel('Depth (m)', 'FontSize', 16);
set(gca, 'FontSize', 16);
set(gcf, 'Color', 'w');
legend('Trades', 'Warm', 'Location', 'NorthWest');
%%
% Segment by hour of day
bins = 3:5;

nighthrs = [ 2 3 4 5 6];
dayhrs = [ 14 15 16 17 18];

%trades
dvs = datevec(dataset.descriptors.datesen(trades));
masknight = ismember(dvs(:,4), nighthrs);
maskday = ismember(dvs(:,4), dayhrs);
tradevar = dataset.deepadcp.riforwardreduce_sort(trades, bins);
% tradevar = valAtMLD(dataset.deepadcp.riforwardreduce_sort, dataset.density.fulldepth.fullmldh + 30, dataset.deepadcp.riforwarddepths);
        
%night
sredvec = reshape(tradevar(masknight,:), sum(masknight)*length(bins), 1);
ntradesnight = histc(sredvec, edges);
ntradesnight = ntradesnight./sum(ntradesnight);
%day
sredvec = reshape(tradevar(maskday,:), sum(maskday)*length(bins), 1);
ntradesday = histc(sredvec, edges);
ntradesday = ntradesday./sum(ntradesday);

%calm
dvs = datevec(dataset.descriptors.datesen(calm));
masknight = ismember(dvs(:,4), nighthrs);
maskday = ismember(dvs(:,4), dayhrs);
calmvar = dataset.deepadcp.riforwardreduce_sort(calm, bins);
%night
sredvec = reshape(calmvar(masknight,:), sum(masknight)*length(bins), 1);
ncalmnight = histc(sredvec, edges);
ncalmnight = ncalmnight./sum(ncalmnight);
%day
sredvec = reshape(calmvar(maskday,:), sum(maskday)*length(bins), 1);
ncalmday = histc(sredvec, edges);
ncalmday = ncalmday./sum(ncalmday);


plot(edges-diffs, ntradesnight, 'k');
hold on
plot(edges-diffs, ntradesday, 'b');
plot(edges-diffs, ncalmnight, '--k');
plot(edges-diffs, ncalmday, '--b');
hold off
grid on
title(['Depth range: ', num2str(dataset.deepadcp.riforwarddepths(bins(1)), 2), ' - ', num2str(dataset.deepadcp.riforwarddepths(bins(end))), ' m'], 'FontSize', 16); 


%%
% Segment by hour of day below MLD
bins = 1:1;%4:7;
MLDoff = 10;

nighthrs = [ 2 3 4 5 6];
dayhrs = [ 14 15 16 17 18];

%trades
dvs = datevec(dataset.descriptors.datesen(trades));
masknight = ismember(dvs(:,4), nighthrs);
maskday = ismember(dvs(:,4), dayhrs);
% tradevar = dataset.deepadcp.riforwardreduce_sort(trades, bins);
tradevar = valAtMLD(dataset.deepadcp.riforwardreduce_sort(trades,:), dataset.density.fulldepth.fullmldh(trades) + MLDoff, dataset.deepadcp.riforwarddepths);
        
%night
sredvec = reshape(tradevar(masknight,:), sum(masknight)*length(bins), 1);
ntradesnight = histc(sredvec, edges);
ntradesnight = ntradesnight./sum(ntradesnight);
%day
sredvec = reshape(tradevar(maskday,:), sum(maskday)*length(bins), 1);
ntradesday = histc(sredvec, edges);
ntradesday = ntradesday./sum(ntradesday);

%calm
dvs = datevec(dataset.descriptors.datesen(calm));
masknight = ismember(dvs(:,4), nighthrs);
maskday = ismember(dvs(:,4), dayhrs);

calmvar = dataset.deepadcp.riforwardreduce_sort(calm, bins);
calmvar = valAtMLD(dataset.deepadcp.riforwardreduce_sort(calm,:), dataset.density.fulldepth.fullmldh(calm) + MLDoff, dataset.deepadcp.riforwarddepths);

%night
sredvec = reshape(calmvar(masknight,:), sum(masknight)*length(bins), 1);
ncalmnight = histc(sredvec, edges);
ncalmnight = ncalmnight./sum(ncalmnight);
%day
sredvec = reshape(calmvar(maskday,:), sum(maskday)*length(bins), 1);
ncalmday = histc(sredvec, edges);
ncalmday = ncalmday./sum(ncalmday);


plot(edges-diffs, ntradesnight, 'k');
hold on
plot(edges-diffs, ntradesday, 'b');
plot(edges-diffs, ncalmnight, '--k');
plot(edges-diffs, ncalmday, '--b');
hold off
grid on
title(['Depth range: ', num2str(dataset.deepadcp.riforwarddepths(bins(1)), 2), ' - ', num2str(dataset.deepadcp.riforwarddepths(bins(end))), ' m'], 'FontSize', 16); 


%%
% Depth bins by HR of day
tradevar = dataset.deepadcp.riforwardreduce_sort(trades,:);
dvs = datevec(dataset.descriptors.datesen(trades));
 ds = 1:7;
 clear rim
for i=0:23
   
    mask = (dvs(:,4)==i);

    for j=1:length(ds)
        rim(i+1,j) = nanmedian(tradevar(mask, j));
    end
    
end

pcolor(0:23, dataset.deepadcp.riforwarddepths(ds), double(rim)'); set(gca, 'ydir', 'reverse')