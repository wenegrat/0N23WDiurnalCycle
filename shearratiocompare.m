shratio = nanmean(abs(dataset.deepadcp.shvforward(:, 1:7)), 2)./nanmean(abs(dataset.deepadcp.shuforward(:, 1:7)), 2);

plot(dataset.descriptors.datesen, ratio,'k'); datetick('x', 'mm'); ylim([-10 10])

ylim([0 5]);

grid on
vline(dataset.descriptors.datesen(calm(1)), 'r')
