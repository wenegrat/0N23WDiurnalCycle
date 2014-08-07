function data = loadATL3
 data = ncdfread('/Users/JacobWenegrat/Documents/Sentinel/PIRATADATA/LongTimeSeries/ClimateIndices/sst.mnmean.nc'); %NOAA SST: http://www.esrl.noaa.gov/psd/data/gridded/data.noaa.oisst.v2.html

 lats = 88:93;
 lons = 341:360;
 sst = squeeze(data.sst(lons, lats,:)).*.01;
 sst(sst>1e3) = NaN;
 
 dates = datenum(1800, 1, data.time+1);
 
 sstm = squeeze(nanmean(nanmean(sst)));
 
 clim = averageMonthly(sstm(38:end), dates(38:end)); %1985-end
 
 climr = [clim(end); repmat(clim, 32, 1)];
 data.sstm = sstm - climr;
 data.sstdates = dates;
end