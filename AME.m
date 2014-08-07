%%
% PE
gamma = .1;
pe = NaN(5967, 61);
ke = NaN(5967, 61);
ape = NaN(5967, 61);
ake = NaN(5967, 61);
ame = NaN(5967, 61);
dps = double([0 dataset.deepadcp.fulldepths]); %add a bin at zero depth
for i=1:5967
    dens = [dataset.density.fulldepth.fulldensitysortedi(i,1) dataset.density.fulldepth.fulldensitysortedi(i,:)]; %extrapolate to uppermost bin
    u = [dataset.deepadcp.fullu(i,1) dataset.deepadcp.fullu(i,:)];
    v = [dataset.deepadcp.fullv(i,1) dataset.deepadcp.fullv(i,:)];
    
    if (i==1430)
        display('here')
    end
    
    for j=2:60;
    pe(i,j) = trapz(dps(1:j), dens(1:j).*dps(1:j));
    rhobar = 1./dps(j) * trapz(dps(1:j), dens(1:j));
    ape(i,j) = -(trapz(dps(1:j), rhobar.*dps(1:j))- pe(i, j)); %Negative sign because z is negative
    
    ke(i,j) = trapz(dps(1:j), dens(1:j).*(u(1:j).^2 + v(1:j).^2)/2);
    meanu = 1./dps(j) * trapz(dps(1:j), u(1:j));
    meanv = 1./dps(j) * trapz(dps(1:j), v(1:j));
    meanke = dps(j).*rhobar.*(meanu.^2+meanv.^2)/2;
    ake(i,j) = ke(i,j) - meanke;
    
    ame(i,j) = gamma.*ake(i,j) - ape(i,j);
%     display(num2str(j));
    end
end

%%
for i=1:5967
    ind = find(ame(i,:) < 0, 1, 'first');
    if (~isempty(ind))
        depthame(i) = dps(ind);
    end
end
%%
maxdepth = 60;
contourf(dataset.descriptors.datesen, dps(1:maxdepth), ame(:,1:maxdepth)');  
hold on
% contour(dataset.descriptors.datesen, dps(1:maxdepth), ame(:,1:maxdepth)',
% [0 0], 'w');
plot(dataset.descriptors.datesen, dataset.density.fulldepth.fullmldh, 'k');
hold off
colorbar
% caxis([-.003 .003]);
set(gca, 'ydir', 'reverse');
colormap(french)
