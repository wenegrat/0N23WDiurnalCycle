% Compare two methods of diurnal SST amplitude

% Delta method
ltri = 24*3*6;
tri = triang(ltri)/sum(triang(ltri));

longsst_trend = conv(data23.sst, tri, 'same');
longsst_trend(1:ceil(ltri/2)) = NaN;
longsst_trend(end-ceil(ltri/2):end) = NaN;

longsst_de = data23.sst - longsst_trend;
[m mi] = maxDaily_full(longsst_de, data23.dates-datenum(0,0,2));
longsst_delta = (m-mi)/2;
dvslong = datenum(1999, 3, 6:5190);
longsst_m = averageSSTMonthly(longsst_delta, dvslong);
longsst_deltai = interp1(dvslong, longsst_delta, data23.dates);

% Complex Demod Method
trilong = triang(48*6-1)./(24*6);
dc = complex_demodulate_tri(data23.sst, 1./(24*6), trilong);
longsst_cmod = dc.semimaj;
longsst_cmodd = interp1(data23.dates, longsst_cmod, dvslong);
[longsst_cmodm monthdates] = averageSSTMonthly(longsst_cmod, data23.dates);

%%
% Average longs to one hour

counter = 1;
sstav = NaN(ceil(length(data23.dates)/6), 1);
datesav = sstav;
counter = 1;
for i=1:6:(length(data23.dates)-5)
    if mod(i,100000) == 0
        disp(['i =- ', num2str(i), '/', num2str(length(data23.dates)-5)]);
    end
    sstav(counter) = nanmean(data23.sst(i:i+5));
    datesav(counter) = data23.dates(i);
    counter = counter+1;
end
%%
ltri = 24*3;
tri = triang(ltri)/sum(triang(ltri));
trend = conv(sstav, tri, 'same');
trend(1:ceil(ltri/2)) = NaN; trend(end-ceil(ltri/2):end) = NaN;
sstde = sstav - trend;
sstde = conv(sstde, [1 2 1]/4, 'same');
[m mi] = maxDaily_full(sstde, datesav - datenum(0,0,2));
del = (m-mi)/2;

tri = triang(48-1)./sum(triang(48-1));
dc = complex_demodulate_tri(sstav, 1./24, tri);
amps = dc.semimaj;

subplot(1,2,1)
amps = interp1(datesav(1:end-1), amps(1:end-1), dvslong(1:5185));
scatter(del, amps); onetoone;
mask = isfinite(amps + del);
b = regress(del(mask)', amps(mask)');
title(num2str(b));

ampsm = averageSSTMonthly(amps, dvslong);
delm = averageSSTMonthly(del, dvslong);
subplot(1,2,2)
scatter(ampsm, delm);onetoone
mask = isfinite(ampsm+delm);
b = regress(delm(mask), ampsm(mask));
title(num2str(b));
%%
% Short
ltri = 24*3;
tri = triang(ltri)/sum(triang(ltri));
shortsst_trend = conv(dataset.density.fulldepth.temps(1,:)', tri, 'same');

shortsst_trend(1:ceil(ltri/2)) = NaN;
shortsst_trend(end-ceil(ltri/2):end) = NaN;

shortsst_de = dataset.density.fulldepth.temps(1,:)' - shortsst_trend;
[m mi] = maxDaily_full(shortsst_de, dataset.descriptors.datesen-datenum(0,0,2));
shortsst_delta = (m-mi)/2;

dcd = averageDaily(cmodDC.semimaj, 1, dataset.descriptors.datesen);


scatter(dcd, shortsst_delta); onetoone;

%%
% plot(dvslong, longsst_delta); hold on; plot(data23.dates, longsst_cmod,
% 'r'); hold off

plot(monthdates, longsst_m); hold on;
plot(monthdates, longsst_cmodm, 'k') ; hold off