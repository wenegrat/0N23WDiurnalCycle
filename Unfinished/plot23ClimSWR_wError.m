function plot23ClimSWR_wError(data23)

figure

[clim23 sste sstt] = averageMonthly(data23.sstDC, data23.sstDCdates); %OK already monthly averages
[clim23w we wt] = averageMonthly(data23.wind, data23.winddates); %OK already monthly averages
[clim23swr swre swrt] = averageMonthly(data23.sw, data23.swdates); %OK already monthly averages

sstci(:,1) =  sste;
sstci(:,2) =  sste;
windci(:,1) = we;
windci(:,2) = we;
swrci(:,1) = swre;
swrci(:,2) = swre;

h1 = boundedline( datenum(1998, 1:12, 1), clim23,  sstci,'-k');
set(h1, 'LineWidth', 2);
set(gca, 'yLim', [.1 .5], 'ytick', [.1:.1:.5]);

[hp1 ha1] = addaxisbounded(datenum(1998, 1:12, 1), clim23w, [2 8], '-b', windci);
set(hp1, 'LineWidth', 2);
% boundedline(datenum(1998, 1:12, 1), clim23w, windci, ha1);
[hptemp hatemp] = addaxis(datenum(1998, 1:12, 1), clim23w, [2 8], 'b', 'LineWidth', 2);
set(hatemp, 'visible', 'off')

[hp2 ha2] = addaxisbounded(datenum(1998, 1:12, 1), clim23swr, [220 300], 'r', swrci);
set(hp2, 'LineWidth', 2);

set(gca, 'FontSize', 16);
set(get(gca, 'ylabel'), 'string', '\circC', 'FontSize', 16);
set(ha1, 'Color', 'w', 'FontSize', 16);
set(get(ha1, 'ylabel'), 'String', 'm s^{-1}', 'FontSize', 16)
set(ha2, 'Color', 'w', 'FontSize', 16);
set(get(ha2, 'ylabel'), 'String', 'W m^{-2}', 'FontSize', 16)

ch = get(gca, 'children');
%ch(7) is black errors
%ch(6) is black line
%ch(5) is blue error line
%ch(4) is blue line (there are 2 of these)
%ch(3) is other blue line
%ch(2) is red errors
%ch(1) is red line
% set(gca, 'children', ch([1 3 4 6 7 5 2]));
set(gca, 'children', ch([6 3 4 1 7 5 2])); %Lines first, then errors
% set(gca, 'children', ch([6 7 3 4 5 1 2])); %Black, Blue, then Red


set(gca, 'xtick', datenum(1998, 1:12, 1), 'xlim', [datenum(1998, 1, 1) datenum(1998, 12, 1)]);
datetick('x', 'm', 'keepticks', 'keeplimits');
grid on
set(gca, 'GridLineStyle', '--')

box on

title('23\circW Climatology', 'FontSize', 16);
set(gcf, 'color', 'w', 'Position', [10 10 678 439]);
lg = legend([h1, hp1, hp2], 'SST Amp.', 'Wind Speed', 'SWR', 'location', 'NorthEast');
set(lg, 'FontSize', 14);
end