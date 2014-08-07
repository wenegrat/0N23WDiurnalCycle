%%
%
d = 3:5;
nd = 10;

clear ristat dtstat riconf

counter = 1;
dt = deltaDaily(dataset.density.fulldepth.temps(1,:)', dataset.descriptors.datesen);
cd = complex_demodulate_tri(dataset.density.fulldepth.temps(1,:)', 1/24, tri);

for i=1:(5967/(nd*24));
    rivec = reshape(dataset.deepadcp.riforwardreduce_sort(((i-1)*24*nd + 1):(i*nd*24-1), d), (nd*24-1)*length(d), 1);
    ristat(counter) = nanmedian(rivec);
    riconf(counter,1) = prctile(rivec, 25);
    riconf(counter,2) = prctile(rivec, 75);
    dtstat(counter) = nanmedian(dt(((i-1)*nd + 1):(i*nd-1)));
    dtstat(counter) = nanmedian(cd.semimaj(((i-1)*24*nd + 1):(i*nd*24-1)));
    counter = counter +  1;
end
% 
% 
plot(ristat/nanstd(ristat))
hold on
plot(-dtstat./nanstd(dtstat),'k')
hold off

% 
% figure
% errorbar(1:length(ristat), ristat, ristat-riconf(:,1)', riconf(:,2)' - ristat);
% hline(.25)