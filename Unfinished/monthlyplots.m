function monthlyplots(input, dates)

dv = datevec(dates);

yfir = dv(1,1);
yend = dv(end,1);
counter = 1;
figure
hold on
crange = linspace(yfir, yend, 64);
colors = colormap;
for j=yfir:yend
    d1 = find(dv(:,1) == j, 1);
    d2 = find(dv(:,1) > j, 1);
    cind = find(j >= crange, 1);
    
    plot(datenum(2000, dv(d1:d2-1, 2), dv(d1:d2-1, 3)), smooth(input(d1:d2-1), 24*5*6), 'color', colors(cind,:));
%     colors = colors.*counter;
%     counter = counter + .05;
%     if counter ==1 
%         diff = 366*24*6 - (d2-d1);
%         minp(counter,:) = [NaN(diff,1); input(d1:d2-1)];
%     else
%         minp(counter,:) = input(d1:d2-1); 
%     end
%    counter = counter+1;
end
hold off

% 
% plot(1:12, minp);
% legend;
end


% function out = shifttoyearly(input, dates, ydates)
% 
% if dates ~= datevec(dates(1), 1, 1)
%     f
% end
% 
% out = input;
% end