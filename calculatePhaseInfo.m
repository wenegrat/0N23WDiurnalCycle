% phase info


pt = 27-cmodDC.phase(trades)*12/pi;
pc = 27-cmodDC.phase(calm)*12/pi;

pt(pt>24) = pt(pt>24) - 24;
pc(pc>24) = pc(pc>24) - 24;

disp(['Phase Trades: ', num2str(nanmedian(pt))]);
disp(['Phase Variable: ', num2str(nanmedian(pc))]);

diff = .25;
edges = 0:diff:24;

Nt = histc(pt, edges);
Nc = histc(pc, edges);

figure
subplot(1,2,1)
plot(edges + diff/2, Nt./sum(Nt));
hold on;
plot(edges + diff/2 , Nc./sum(Nc), 'k');
hold off;
title('Phase Histogram');
legend('Trades', 'Calm');
xlabel('UTC Hr');

subplot(1,2,2)
cdfplot(pt);
hold on
H = cdfplot(pc);
set(H, 'Color', 'k');
hold off