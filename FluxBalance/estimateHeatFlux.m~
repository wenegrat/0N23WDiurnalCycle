function estimateHeatFlux(dataset, twarm, tcold, av)

cp = 4000; %J kg^-1 K-1;
rho = 1023;

for i=1:5967
    ind = find(dataset.density.fulldepth.tempdepth > dataset.density.fulldepth.fullmldh(i), 1);
    
    if (~isempty(ind))
        tz(i) = (dataset.density.fulldepth.temps(ind,i) - dataset.density.fulldepth.temps(ind+1,i))...
            ./(dataset.density.fulldepth.tempdepth(ind+1) - dataset.density.fulldepth.tempdepth(ind));
    end
end

jest = -rho.*cp.*av'.*tz;

T = (-dataset.flux.netheat - jest')./(rho*cp.*dataset.density.fulldepth.fullmldh);
jestbyhr = bindatabyhour(jest(twarm)', dataset.descriptors.datesen(twarm));
qbyhr = bindatabyhour(dataset.flux.netheat(twarm), dataset.descriptors.datesen(twarm));
tbyhr = bindatabyhour(T(twarm), dataset.descriptors.datesen(twarm));

subplot(1,2,1)
% plot(0:23, jestbyhr)
% hold on
% plot(0:23, qbyhr);
% plot(0:23, qbyhr - jestbyhr, 'k', 'LineWidth', 2);
% hold off
plot(0:23, tbyhr);

jestbyhr = exp(bindatabyhour(log(jest(tcold)'), dataset.descriptors.datesen(tcold)));
qbyhr = bindatabyhour(dataset.flux.netheat(tcold), dataset.descriptors.datesen(tcold));
subplot(1,2,2)
plot(0:23, jestbyhr)
hold on
plot(0:23, qbyhr);
plot(0:23, qbyhr + jestbyhr, 'k', 'LineWidth', 2);
hold off


end