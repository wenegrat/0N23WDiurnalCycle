%%
% DC Histograms
bins = 4:7;
edges = linspace(-3e-3, 3e-3, 60);
diffs = (edges(2)-edges(1))/2;

t1 = trades;
sredvec = reshape(dataset.deepadcp.riforwardreduce_sort(t1, bins), length(t1)*length(bins), 1);
ntrades = histc(sredvec, edges);
ntrades = ntrades./sum(ntrades);

t2 = calm;
sredvec = reshape(dataset.deepadcp.riforwardreduce_sort(t2, bins), length(t2)*length(bins), 1);
ncalm = histc(sredvec, edges);
ncalm = ncalm./sum(ncalm);

edgesri  = logspace(-3, 1, 60);

t1 = trades;
sredvec = reshape(dataset.deepadcp.riforward_sort(t1, bins), length(t1)*length(bins), 1);
ntradesri = histc((sredvec), edgesri);
ntradesri = ntradesri./sum(ntradesri);

t2 = calm;
sredvec = reshape(dataset.deepadcp.riforward_sort(t2, bins), length(t2)*length(bins), 1);
ncalmri = histc((sredvec), edgesri);
ncalmri = ncalmri./sum(ncalmri);


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

figure


subplot(4,3,[1 4 7 10])
[h hp] = boundedline(rim, dataset.deepadcp.riforwarddepths(ds), rimci, rimc, dataset.deepadcp.riforwarddepths(ds), rimcci, 'orientation', 'horiz');
set(hp(2), 'FaceColor', [.7 .7 .7], 'FaceAlpha', .5);
% set(hp(1), 'FaceAlpha', .9);
set(h(2), 'Color', 'k', 'LineWidth', 2);
set(h(1), 'LineWidth', 2);
set(gca, 'ydir', 'reverse');
grid on
xlabel('Sh^2_{red} (s^{-2})', 'FontSize', 16);
ylabel('Depth (m)', 'FontSize', 16);
set(gca, 'FontSize', 16, 'box', 'on');
set(gcf, 'Color', 'w');
legend('Trades', 'Variable', 'Location', 'NorthWest');
xlim([-3e-3 1e-3]);

subplot(4,3,[ 2 3 5 6])
plot(edges+diffs, ntrades, 'b', 'LineWidth', 2)
hold on
plot(edges+diffs, ncalm, 'k', 'LineWidth', 2);
hold off
grid on
xlabel('Sh^2_{red} (s^{-2})', 'FontSize', 16);
ylabel('Fraction of Obs', 'FontSize', 16);

legend('Trades', 'Variable');
set(gca, 'FontSize', 16);
xlim([-3e-3 3e-3]);
v1 = vline(0, 'k');
set(v1, 'LineWidth', 1.5);
title(['Depth range: ', num2str(dataset.deepadcp.riforwarddepths(bins(1)), 2), ' - ', num2str(dataset.deepadcp.riforwarddepths(bins(end))), ' m'], 'FontSize', 16); 

subplot(4,3,[8 9 11 12])
% plot([edgesri(1:end-1)+diff(edgesri)/2, edgesri(end)], ntradesri, 'b', 'LineWidth', 2)
plot((edgesri(1:end-1)+edgesri(2:end))/2, ntradesri(1:end-1), 'b', 'LineWidth', 2);

hold on
plot((edgesri(1:end-1)+edgesri(2:end))/2, ncalmri(1:end-1), 'k', 'LineWidth', 2);
hold off
grid on
xlabel('Ri', 'FontSize', 16);
ylabel('Fraction of Obs', 'FontSize', 16);

legend('Trades', 'Variable');
set(gca, 'xscale',  'log','FontSize', 16);
v2 = vline(0.25, 'k');
set(v2, 'LineWidth', 1.5);

xlim([1e-2 5]);



pause;
set(gcf, 'Color', 'w', 'Position', [0 0 1400 900]);