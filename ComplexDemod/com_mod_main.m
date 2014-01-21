% temp = dataset.variables.Emmpersec20mh(:,:);
temp = dataset.deepadcp.n2forward;

temp = naninterpmatrix(temp);

[b, a] = butter(7, 2/48, 'low');

% res = complex_demodulate(temp, 1/24, b, a, @filtfilt);

sst = dataset.density.fulldepth.temps(1,:)';
ressst = complex_demodulate(sst, 1/24, b, a, @filtfilt);

tri=triang(48-1)./24;
ressttest = complex_demodulatetest(sst, 1/24, tri);

var2 = naninterpmatrix(dataset.density.fulldepth.fullmld);

fluxtest = complex_demodulatetest(var2, 1/24, tri);
% pcolor(res.semimaj(:,1:5)'); shading interp;
set(gca, 'ydir', 'reverse');

subplot(3,1,1)
plot(dataset.descriptors.datesen, ressttest.semimaj, '--k');
% plot(dataset.descriptors.datesen, ressst.semimaj);
datetick('x');
hold on
% plot(dataset.descriptors.datesen, ressttest.semimaj, 'k');
plot(dataset.descriptors.datesen, smooth(ressttest.semimaj, 24*14), 'k', 'LineWidth', 2);
hold off
ylim([0 .6]);
xlim([dataset.descriptors.datesen([1 end])]);


subplot(3,1,2)
plot(dataset.descriptors.datesen, var2, '--k');

hold on
plot(dataset.descriptors.datesen, smooth(var2, 24*14), 'k', 'LineWidth', 2);
hold off
datetick('x');
xlim(dataset.descriptors.datesen([1 end]));

subplot(3,1,3)
plot(dataset.descriptors.datesen, fluxtest.semimaj, '--k');

hold on
plot(dataset.descriptors.datesen, smooth(fluxtest.semimaj, 24*14), 'k', 'LineWidth', 2);
hold off
datetick('x');
xlim(dataset.descriptors.datesen([1 end]))
%%
resbyhr = bindatabyhour(res.semimaj(timerange, :), dataset.descriptors.datesen(timerange));

pcolor(resbyhr(:,1:20)'); set(gca, 'ydir', 'reverse');


%%

for i=1:5967
   tp = dataset.density.fulldepth.temps(:,i) -  dataset.density.fulldepth.temps(6,i);
   dt(i) = 1./dataset.density.fulldepth.temps(1,i)*trapz(dataset.density.fulldepth.tempdepth(1:6), tp(1:6));
end