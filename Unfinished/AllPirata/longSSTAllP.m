%%

data35 = ncdfread('/Users/JacobWenegrat/Documents/Sentinel/PIRATADATA/LongTimeSeries/SST/sst0n35w_10m.cdf');
    tempMins = double(data35.time2(:)/(1000*60)); %mil*sec*min to get hours
    tempDates = double(data35.time(:))+datenum(1968, 5, 23) - 2440000;
    data35.dates = datenum(tempDates) + datenum(0,0,0,0,tempMins,0);
data35.sst = squeeze(data35.T_25);
data35.sst(data35.sst>1e3) = NaN;

data35w = ncdfread('/Users/JacobWenegrat/Documents/Sentinel/PIRATADATA/LongTimeSeries/Wind/w0n35w_mon.cdf');
    tempMins = double(data35w.time2(:)/(1000*60)); %mil*sec*min to get hours
    tempDates = double(data35w.time(:))+datenum(1968, 5, 23) - 2440000;
    data35w.dates = datenum(tempDates) + datenum(0,0,0,0,tempMins,0);
data35.wind = squeeze(data35w.WS_401);
data35.wind(data35.wind>1e3) = NaN;
data35.winddates = data35w.dates;
clear data35w

data23 = ncdfread('/Users/JacobWenegrat/Documents/Sentinel/PIRATADATA/LongTimeSeries/SST/sst0n23w_10m.cdf');
    tempMins = double(data23.time2(:)/(1000*60)); %mil*sec*min to get hours
    tempDates = double(data23.time(:))+datenum(1968, 5, 23) - 2440000;
    data23.dates = datenum(tempDates) + datenum(0,0,0,0,tempMins,0);
data23.sst = squeeze(data23.T_25);
data23.sst(data23.sst>1e3) = NaN;

data23w = ncdfread('/Users/JacobWenegrat/Documents/Sentinel/PIRATADATA/LongTimeSeries/Wind/w0n23w_mon.cdf');
    tempMins = double(data23w.time2(:)/(1000*60)); %mil*sec*min to get hours
    tempDates = double(data23w.time(:))+datenum(1968, 5, 23) - 2440000;
    data23w.dates = datenum(tempDates) + datenum(0,0,0,0,tempMins,0);
data23.wind = squeeze(data23w.WS_401);
data23.wind(data23.wind>1e3) = NaN;
data23.winddates = data23w.dates;
clear data23w

data10 = ncdfread('/Users/JacobWenegrat/Documents/Sentinel/PIRATADATA/LongTimeSeries/SST/sst0n10w_10m.cdf');
    tempMins = double(data10.time2(:)/(1000*60)); %mil*sec*min to get hours
    tempDates = double(data10.time(:))+datenum(1968, 5, 23) - 2440000;
    data10.dates = datenum(tempDates) + datenum(0,0,0,0,tempMins,0);
data10.sst = squeeze(data10.T_25);
data10.sst(data10.sst>1e3) = NaN;


data10w = ncdfread('/Users/JacobWenegrat/Documents/Sentinel/PIRATADATA/LongTimeSeries/Wind/w0n10w_mon.cdf');
    tempMins = double(data10w.time2(:)/(1000*60)); %mil*sec*min to get hours
    tempDates = double(data10w.time(:))+datenum(1968, 5, 23) - 2440000;
    data10w.dates = datenum(tempDates) + datenum(0,0,0,0,tempMins,0);
data10.wind = squeeze(data10w.WS_401);
data10.wind(data10.wind>1e3) = NaN;
data10.winddates = data10w.dates;
clear data10w


data0 = ncdfread('/Users/JacobWenegrat/Documents/Sentinel/PIRATADATA/LongTimeSeries/SST/sst0n0e_10m.cdf');
    tempMins = double(data0.time2(:)/(1000*60)); %mil*sec*min to get hours
    tempDates = double(data0.time(:))+datenum(1968, 5, 23) - 2440000;
    data0.dates = datenum(tempDates) + datenum(0,0,0,0,tempMins,0);
data0.sst = squeeze(data0.T_25);
data0.sst(data0.sst>1e3) = NaN;


data0w = ncdfread('/Users/JacobWenegrat/Documents/Sentinel/PIRATADATA/LongTimeSeries/Wind/w0n0e_mon.cdf');
    tempMins = double(data0w.time2(:)/(1000*60)); %mil*sec*min to get hours
    tempDates = double(data0w.time(:))+datenum(1968, 5, 23) - 2440000;
    data0w.dates = datenum(tempDates) + datenum(0,0,0,0,tempMins,0);
data0.wind = squeeze(data0w.WS_401);
data0.wind(data0.wind>1e3) = NaN;
data0.winddates = data0w.dates;
clear data10w

%%
% Load All SST
clear sst
filenames = getAllFiles('/Users/JacobWenegrat/Documents/Sentinel/PIRATADATA/LongTimeSeries/SST');
% 
% ndepths = 10000;
% depths = NaN * zeros([ndepths length(filenames)+2]);
% temps = NaN * zeros([ndepths length(filenames)+2]);
% sals = NaN * zeros([ndepths length(filenames)+2]);
% times = NaN * zeros([1 length(filenames)+2]);
% cruiseid = NaN * zeros([200 length(filenames)+2]);
% pos = NaN * zeros([length(filenames)+2 2]);
counter = length(filenames) -2;
lats = [-19 -14 -10 -8 -6 -5 -2 0 2 4 8 12 15 20 21];
lons = [322 325 326 328 330 337 350 0 8];
ldates = datenum(1997, 1, 0, 0, 0:10:9460800, 0);

trilong = triang(48*6-1)./(24*6);
% sst = NaN(length(lons), length(lats), length(ldates));
% sstdc = sst;
% sstlong =sst;
% sstdca = sst;
sstdcm = NaN(length(lons), length(lats), 12);
sstadcm = sstdcm;
for i=3:length(filenames)
%    
    disp(num2str(i))
    data = ncdfread(char(filenames(i)));
    lonind = find(data.lon == lons);
    if (isempty(lonind))
        display('Error in Lon');
    end
    latind = find(data.lat == lats);
    if isempty(latind)
        display('Error in Lat');
    end
    
    tempMins = double(data.time2(:)/(1000*60)); %mil*sec*min to get hours
    tempDates = double(data.time(:))+datenum(1968, 5, 23) - 2440000;
    sstdates = datenum(tempDates) + datenum(0,0,0,0,tempMins,0);
    
    temp = shifttotime(squeeze(data.T_25), sstdates, ldates);
    temp(temp>1e3) = NaN;
    
    tempDC = complex_demodulate_tri(squeeze(temp), 1/(24*6), trilong);
    tempDCamp = tempDC.semimaj;
%     sstdca(lonind, latind,:) = interannualAnom(squeeze(sstdc(lonind,latind,:)), ldates);
    
    sstdcm(lonind, latind,:) = averageMonthly(tempDCamp, ldates);
%     sstadcm(lonind, latind,:) = averageMonthly(sstdca(lonind,latind,:), ldates);
%     catch
%         counter = counter -1;
%     end
end

% sst(sst>1e3) = NaN;

%%
figure
lt = lons-360;
lt(end) = 8;

crange = linspace(0,.3, 64);
colors = colormap;
[X Y] = meshgrid(lats, lt);

for i=1:12
    subplot(4,3,i)
    m_proj('Mercator', 'longitudes', [-45 15], 'latitudes', [-20 20]);
    m_coast;
    m_grid;
    hold on
    temp = squeeze(sstdcm(:,:,i));
    mask = isfinite(temp);
%     z = griddata(X(mask), Y(mask), temp(mask), X, Y);
%     m_contourf(lt, lats, z', crange);
    for j = 1:length(lons)
        for k=1:length(lats)
            
            cind = find(squeeze(double(sstdcm(j,k,i))) < crange, 1);
            if (~isempty(cind)) && (sstdcm(j,k,i)~=0)
             m_line(lt(j), lats(k), 'marker', 'square', 'markersize', 14, 'color', colors(cind,:), 'MarkerFaceColor', colors(cind,:));
            end
        end
    end
    title(num2str(i))
    hold off
      
end
%%
sstclim = ncdfread('/Users/JacobWenegrat/Documents/Sentinel/PIRATADATA/LongTimeSeries/ClimateIndices/sst.ltm.1971-2000.nc');
sstclim.sst(sstclim.sst>30000) = NaN;
sstclim.sst = .01* sstclim.sst;
%%
figure
lt = lons-360;
lt(end) = 8;

crange = linspace(0,.25, 64);
colors = cptcmap('seminf-haxby', 'ncol',64);
[X Y] = meshgrid(lats, lt);
counter = 1;
ssta(1,:,:) = nanmean(sstdcm(:,:,[12 1 2]),3);
ssta(2,:,:) = nanmean(sstdcm(:,:,[3 4 5]), 3);
ssta(3,:,:) = nanmean(sstdcm(:,:,[6 7 8]), 3);
ssta(4,:,:) = nanmean(sstdcm(:,:,[9 10 11]), 3);

sstcl(1,:,:) = nanmean(sstclim.sst(:,:, [12 1 2]), 3);
sstcl(2,:,:) = nanmean(sstclim.sst(:,:, [3 4 5]), 3);
sstcl(3,:,:) = nanmean(sstclim.sst(:,:, [6 7 8]), 3);
sstcl(4,:,:) = nanmean(sstclim.sst(:,:, [9 10 11]), 3);

for i=1:4
    subtightplot(2,2,i, [.1 .1], .1, .15)
    m_proj('Mercator', 'longitudes', [-45 15], 'latitudes', [-22 24]);
    m_coast('patch', [.7 .7 .7]);
    m_grid('box', 'fancy');
    hold on
%     m_contour(sstclim.lons, sstclim.lat, squeeze(sstcl(i,:,:))', 20:1:40);
    for j = 1:length(lons)
        for k=1:length(lats)
            [~, cind] = min(abs(squeeze(double(ssta(i,j,k))) - crange));
%             cind = find(squeeze(double(ssta(i,j,k))) < crange, 1);
            if (~isempty(cind)) && (isfinite(ssttemp(j,k)))
             m_line(lt(j), lats(k), 'marker', 'square', 'markersize', 20, 'color', colors(cind,:), 'MarkerFaceColor', colors(cind,:), 'MarkerEdgeColor', 'k');
            end
        end
    end
    
    hold off
    title(num2str(i));
      
end
colormap(colors);
cb = colorbar;

set(get(cb, 'YLabel'), 'String', '^{\circ}C');
% caxis([crange(1) crange(end)])
set(cb, 'YTick', 0:.05:.25);
set(gcf, 'Color', 'w');
