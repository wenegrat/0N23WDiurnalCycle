%%
%==================LOCATION CHART =====================================
% Calculate variables necessary for piratachart_wSST.m

sstclim = ncdfread('/Users/JacobWenegrat/Documents/Sentinel/PIRATADATA/LongTimeSeries/ClimateIndices/sst.wkmean.1990-present.nc');
sstclim.sst(sstclim.sst>30000) = NaN;
ssttimes = datenum(1800,1,1+datenum(sstclim.time));

sstclim.sst = double(.01* sstclim.sst);
sst = NaN(360, 180, 12);
for i=1:360
    for j=1:180
        sst(i,j,:) = averageMonthly(squeeze(sstclim.sst(i,j,:)), ssttimes);
    end
end
sstclim.lon(sstclim.lon>180) = sstclim.lon(sstclim.lon>180) - 360;

sstavg = NaN(360, 180, 2);
sstavg(:,:,1) = mean(sst(:,:,6:8), 3);
sstavg(:,:,2) = mean(sst(:,:,[12 1 2]), 3);

%%
% Wind Stress
%http://cioss.coas.oregonstate.edu/scow/
taux = ncdfread('/Users/JacobWenegrat/Documents/Sentinel/PIRATADATA/LongTimeSeries/Wind Stress Climatology/wind_stress_zonal_monthly_maps.nc');
tauy = ncdfread('/Users/JacobWenegrat/Documents/Sentinel/PIRATADATA/LongTimeSeries/Wind Stress Climatology/wind_stress_meridional_monthly_maps.nc');

% Remove NaNs
taux.june(taux.june<-100) = NaN;
taux.july(taux.july<-100) = NaN;
taux.august(taux.august<-100) = NaN;
tauy.june(tauy.june<-100) = NaN;
tauy.july(tauy.july<-100) = NaN;
tauy.august(tauy.august<-100) = NaN;

tauxavg_summer = 1/3 * (taux.june + taux.july + taux.august);
tauyavg_summer = 1/3 * (tauy.june + tauy.july + tauy.august);

%Remove NaNs
taux.december(taux.december<-100) = NaN;
taux.january(taux.january<-100) = NaN;
taux.february(taux.february<-100) = NaN;
tauy.december(tauy.december<-100) = NaN;
tauy.january(tauy.january<-100) = NaN;
tauy.february(tauy.february<-100) = NaN;

tauxavg_winter = 1/3 * (taux.december + taux.january + taux.february);
tauyavg_winter = 1/3 * (tauy.december + tauy.january + tauy.february);

%Decimate observations to lower resolution for plotting purposes
dx = 4*3;
dy = dx;

[taulat taulon] = meshgrid(taux.latitude(1:dy:length(taux.latitude)), taux.longitude((1:dx:length(taux.longitude))));
tauxavg_summer = tauxavg_summer(1:dx:length(taux.longitude), 1:dy:length(taux.latitude));
tauyavg_summer = tauyavg_summer(1:dx:length(taux.longitude), 1:dy:length(taux.latitude));
tauxavg_winter = tauxavg_winter(1:dx:length(taux.longitude), 1:dy:length(taux.latitude));
tauyavg_winter = tauyavg_winter(1:dx:length(taux.longitude), 1:dy:length(taux.latitude));


%%
% This calculates wind stress using the monthly values of u and v, rather
% than from averaging wind stress...not sure which of these is actually a
% better way to go. Probably stress first, then average.

u = ncdfread('/Users/JacobWenegrat/Documents/Sentinel/PIRATADATA/LongTimeSeries/Wind Stress Climatology/wind_zonal_monthly_maps.nc');
v = ncdfread('/Users/JacobWenegrat/Documents/Sentinel/PIRATADATA/LongTimeSeries/Wind Stress Climatology/wind_meridional_monthly_maps.nc');

u.june(u.june<-100) = NaN;
v.june(v.june<-100) = NaN;
tx = NaN(1440, 560);
ty = tx;
for i=1:1440
    for j=1:560
    [tx(i,j) ty(i,j)] = stresslp_vec(u.june(i,j), v.june(i,j), 10);
    end
end

%%
% OLR
 dataolr = ncdfread('/Users/JacobWenegrat/Documents/Sentinel/PIRATADATA/LongTimeSeries/23WAll/olr.mon.mean.nc'); %NOAA OLR from: http://www.esrl.noaa.gov/psd/data/gridded/data.interp_OLR.html
 tempDates = datenum(1800, 1, 1) + datenum(0, 0, 0, dataolr.time, 0 , 0);
 tempOLR = dataolr.olr;
 tempOLR(tempOLR > 32760) = NaN;
 tempOLR = tempOLR.*.01 + 327.65;
 
 olr = NaN(144, 73, 12);
 for i=1:144
     for j= 1:73
         olr(i,j,:) = averageMonthly(double(squeeze(tempOLR(i,j,:))), tempDates);
     end
 end
 olrlat = dataolr.lat;
 olrlon = dataolr.lon;
 olrlon(olrlon>180) = olrlon(olrlon>180) - 360;
 olravg(:,:,1) = mean(olr(:,:,6:8),3);
 olravg(:,:,2) = mean(olr(:,:,[12 1 2]),3);
