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

plot(edges + diff/2, Nt./sum(Nt));
hold on;
plot(edges + diff/2 , Nc./sum(Nc), 'k');
hold off;