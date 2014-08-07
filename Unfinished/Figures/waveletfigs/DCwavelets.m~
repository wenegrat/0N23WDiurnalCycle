% Wavelets
close all
var1 = dataset.density.fulldepth.temps(7,:)';
var2 = shmag;

var1 = (naninterpmatrix(var1));
var2 = log10(naninterpmatrix(var2));

figure('name', 'Hist Var1');
hist(var1, 50);
figure('name', 'Hist Var2');
hist(var2, 50);
figure('name', 'Wavelet var1')
subplot(3,1,1)
wt(var1);
hline(4.5, 'k'); % 24 hour period
% figure('name', 'Wavelet var2')
subplot(3,1,2)
wt(var2);
hline(4.5, 'k'); % 24 hour period
% figure('name', 'Xwave');
subplot(3,1,3);
wtc(var1, var2,'mcc', 0);
hline(4.5, 'k'); % 24 hour period
figure
xwt(var1, var2);
%%
clear wave waven
shvar = sqrt(dataset.deepadcp.sh2forward);
shvar = (naninterpmatrix(shvar));
ndepths = 15;
wave = NaN(ndepths, 121, 5967);
waven = wave;
sig95 = wave;
for i=1:ndepths;
[wave(i,:,:), period, scale, coi, sig95(i,:,:)] = wt(shvar(:,i));
for j=1:5967
    waven(i,:,j) = (wave(i,:,j)).*conj(wave(i,:,j))./sum((wave(i,:,j)).*conj(wave(i,:,j)));
end
end


%%
freq = 44;
tp = 1:5967;
wavef = squeeze(mean(waven(1:10, 41:46, tp),2));

% contourf(detail1, dataset.deepadcp.riforwarddepths(1:7), angle(squeeze((wave(1:7,freq,detail1)))')');  set(gca, 'ydir', 'reverse');
% hold on
% contourf(trades, dataset.deepadcp.riforwarddepths(1:ndepths), log10(abs(squeeze(wave(1:ndepths, freq, trades))))); set(gca, 'ydir', 'reverse');
pcolor(tp, dataset.deepadcp.riforwarddepths(1:5), (wavef(1:5,:)));shading interp; set(gca, 'ydir', 'reverse');

% hold off
hold on
plot(tp, dataset.density.fulldepth.fullmldh(tp), 'k');
contour
hold off