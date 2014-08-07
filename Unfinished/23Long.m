%SST
data23 = ncdfread('/Users/JacobWenegrat/Documents/Sentinel/PIRATADATA/LongTimeSeries/SST/sst0n23w_10m.cdf');
    tempMins = double(data23.time2(:)/(1000*60)); %mil*sec*min to get hours
    tempDates = double(data23.time(:))+datenum(1968, 5, 23) - 2440000;
    data23.dates = datenum(tempDates) + datenum(0,0,0,0,tempMins,0);
data23.sst = squeeze(data23.T_25);
data23.sst(data23.sst>1e3) = NaN;
trilong = triang(48*6-1)./(24*6);
dc23 = complex_demodulate_tri(data23.sst, 1./(24*6), trilong);
[data23.sstDC data23.sstDCdates] = averageSSTMonthly(dc23.semimaj, data23.dates);

%%
%Wind
data23w = ncdfread('/Users/JacobWenegrat/Documents/Sentinel/PIRATADATA/LongTimeSeries/Wind/w0n23w_mon.cdf');
    tempMins = double(data23w.time2(:)/(1000*60)); %mil*sec*min to get hours
    tempDates = double(data23w.time(:))+datenum(1968, 5, 23) - 2440000;
    data23w.dates = datenum(tempDates) + datenum(0,0,0,0,tempMins,0);
data23.wind = squeeze(data23w.WS_401);
data23.wind(data23.wind>1e3) = NaN;
data23.winddates = data23w.dates;
clear data23w

%Z20
data = ncdfread('/Users/JacobWenegrat/Documents/Sentinel/PIRATADATA/LongTimeSeries/23WAll/iso0n23w_mon.cdf');
 tempMins = double(data.time2(:)/(1000*60)); %mil*sec*min to get hours
    tempDates = double(data.time(:))+datenum(1968, 5, 23) - 2440000;
 data23.z20dates = datenum(tempDates) + datenum(0,0,0,0,tempMins,0);
 data23.z20 = squeeze(data.ISO_6);
 data23.z20(data23.z20 > 1e3) = NaN;
 clear data
%%
 %MLD & Delta SST
 data = ncdfread('/Users/JacobWenegrat/Documents/Sentinel/PIRATADATA/LongTimeSeries/23WAll/t0n23w_dy.cdf');
 tempMins = double(data.time2(:)/(1000*60)); %mil*sec*min to get hours
    tempDates = double(data.time(:))+datenum(1968, 5, 23) - 2440000;
    
 tempdens = squeeze(data.T_20);
 tempdens(tempdens>1e4) = NaN;
 tempmld = calculateMLD(tempdens, data.depth, .5);
 mask1 = isfinite(tempdens);
 mask = (sum(mask1(1:10, :)) > 4) & mask1(1,:);
 tempmld(~mask) = NaN;
 [tempmldm tempDatesm] = averageSSTMonthly(tempmld, tempDates);
 data23.mldT = tempmldm;
 data23.mldTdates = tempDatesm;
 
 tempdiff = calcdiffs(tempdens(1:5,:), data.depth(1:5));
 [tempdiffm tempDatesm] = averageSSTMonthly(tempdiff, tempDates);
 data23.tempdiffdates = tempDatesm;
 data23.tempdiff = tempdiffm;
%  clear data tempmld tempmldm tempDatesm mask mask1 tempdiff
 %%
 
 %Net Heat
 data = ncdfread('/Users/JacobWenegrat/Documents/Sentinel/PIRATADATA/LongTimeSeries/23WAll/qnet0n23w_mon.cdf');
 tempMins = double(data.time2(:)/(1000*60)); %mil*sec*min to get hours
    tempDates = double(data.time(:))+datenum(1968, 5, 23) - 2440000;
 data23.Netheatdates = datenum(tempDates) + datenum(0,0,0,0,tempMins,0);
 data23.Netheat = squeeze(data.QT_210);
 data23.Netheat(data23.Netheat > 1e4) = NaN;
 clear data
 %%
 %LW Rad
 data = ncdfread('/Users/JacobWenegrat/Documents/Sentinel/PIRATADATA/LongTimeSeries/23WAll/lw0n23w_mon.cdf');
 tempMins = double(data.time2(:)/(1000*60)); %mil*sec*min to get hours
    tempDates = double(data.time(:))+datenum(1968, 5, 23) - 2440000;
 data23.lwdates = datenum(tempDates) + datenum(0,0,0,0,tempMins,0);
 data23.lw = squeeze(data.Ql_136);
 data23.lw(data23.lw > 1e4) = NaN;
 clear data
 
  
 %SW Rad
 data = ncdfread('/Users/JacobWenegrat/Documents/Sentinel/PIRATADATA/LongTimeSeries/23WAll/rad0n23w_mon.cdf');
 tempMins = double(data.time2(:)/(1000*60)); %mil*sec*min to get hours
    tempDates = double(data.time(:))+datenum(1968, 5, 23) - 2440000;
 data23.swdates = datenum(tempDates) + datenum(0,0,0,0,tempMins,0);
 data23.sw = squeeze(data.RD_495);
 data23.sw(data23.sw > 1e4) = NaN;
 clear data
 %%
 data = ncdfread('/Users/JacobWenegrat/Documents/Sentinel/PIRATADATA/LongTimeSeries/23WAll/olr.mon.mean.nc'); %NOAA OLR from: http://www.esrl.noaa.gov/psd/data/gridded/data.interp_OLR.html
 lonind = 136;
 latind = 37;
 tempDates = datenum(1800, 1, 1) + datenum(0, 0, 0, data.time, 0 , 0);
 tempOLR = squeeze(data.olr(lonind, latind,:));
 tempOLR(tempOLR > 32760) = NaN;
 tempOLR = tempOLR.*.01 + 327.65;
 data23.olr = tempOLR;
 data23.olrdates = tempDates;
 clear data tempDates tempOLR 
 
%  %%
%  % Plots
%  
%  plot23Long(data23);
%  
%  %%
%  %Climatology
% plot23Clim(data23);
%  
%  %%
%  % Data From http://sunrise.aos.wisc.edu/~dvimont/MModes/Data/
%  importAMMfile('/Users/JacobWenegrat/Documents/Sentinel/PIRATADATA/LongTimeSeries/ClimateIndices/AMM.txt'); %puts into var called 'data'
%  tempDates = datenum(data(:,1), data(:,2), 1);
%  data23.AMM_sst = data(:,3)./std(data(601:end,3)); % Check this...
%  data23.AMM_dates = tempDates;
%  data23.AMM_wind = data(:,4)./std(data(601:end,4));
%  clear tempDates
%  
%  % Data from http://www.cpc.ncep.noaa.gov/data/indices/
%  
%  importSOIfile('/Users/JacobWenegrat/Documents/Sentinel/PIRATADATA/LongTimeSeries/ClimateIndices/soistd.txt'); %puts into var called 'data'
%  for i=1:length(data)
%      tempDates(i,:) = datenum(data(i,1), 1:12, 1);
%  end
%  tempDates = reshape(tempDates', length(data).*12, 1);
%  tempInd = reshape(data(:,2:end)', length(data).*12,1);
%  tempInd(abs(tempInd)>10) = NaN;
%  data23.SOI = tempInd;
%  data23.SOIdates = tempDates;
% %  clear data tempDates tempInd
% 
% %%
% % Data for ATL3 Index
% data = loadATL3();
% data23.atl3 = data.sstm;
% data23.atl3dates = data.sstdates;
% clear data
%  %%
%  plot23Inter(data23);