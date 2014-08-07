%%
% DC Histograms
bins = 4:7;
edges = linspace(-3e-3, 3e-3, 60);
diffs = (edges(1)-edges(2))/2;

t1 = trades;
sredvec = reshape(dataset.deepadcp.riforwardreduce_sort(t1, bins), length(t1)*length(bins), 1);
ntrades = histc(sredvec, edges);
ntrades = ntrades./sum(ntrades);

t2 = calm;
sredvec = reshape(dataset.deepadcp.riforwardreduce_sort(t2, bins), length(t2)*length(bins), 1);
ncalm = histc(sredvec, edges);
ncalm = ncalm./sum(ncalm);


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
xlim([-3e-3 1e-3]);
subplot(1,3,2:3)
plot(edges-diffs, ntrades, 'b', 'LineWidth', 2)
hold on
plot(edges-diffs, ncalm, 'k', 'LineWidth', 2);
hold off
grid on
xlabel('Sh^2_{red} (s^{-2})', 'FontSize', 16);
ylabel('Fraction of Obs', 'FontSize', 16);

legend('Trades', 'Variable');
set(gca, 'FontSize', 16);
xlim([-3e-3 3e-3]);

title(['Depth range: ', num2str(dataset.deepadcp.riforwarddepths(bins(1)), 2), ' - ', num2str(dataset.deepadcp.riforwarddepths(bins(end))), ' m'], 'FontSize', 16); 
pause;
set(gcf, 'Color', 'w', 'Position', [0 0 1200 700]);