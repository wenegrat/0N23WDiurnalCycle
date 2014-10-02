%%
% Error analysis of complex demodulation amplitude

r = 1:5967;

sst = dataset.density.fulldepth.temps(1,r)';
sst = detrend(sst, 'constant');
ntimes = length(sst);

[Psi, Lambda] = sleptap(ntimes);
%%
[F,S]=mspec(sst, Psi);
F = F*24;
S = S/24;

semilogx(F, S.*F);
xlabel('cpd');
ylabel('var');


%%
ycr = cmodDC.semimaj(r).*cos(2*pi*1/24*(0:1:(ntimes-1)) + cmodDC.phase(r)')';
sstdiff = sst - ycr;


[F,Sreal]=mspec(sst, Psi);
F = F*24;
Sreal = Sreal/24;

semilogx(F, Sreal.*F);
xlabel('cpd');
ylabel('var');

hold on
[F,S]=mspec(sstdiff, Psi);
F = F*24;
S = S/24;

semilogx(F, S.*F, 'k');
hold off

%%
nois = randn(length(r), 1);



df = F(3)-F(2);
noisebase = df*sum(Sreal([58:240 261:436]));
noisebase = noisebase*length(Sreal)./((436-58)-21);
nois = sqrt(noisebase)./std(nois)*nois;




hold on
[F,S]=mspec(nois, Psi);
F = F*24;
S = S/24;

semilogx(F, S.*F, 'r');
hold off
%%
tri=triang(48-1)./24; %Following Kessler PDF

f = exp( - 2 * pi * (0:5967-1)' * 1/24 * 1i );
sstf = conv(f.*sst, tri, 'same');

%%
[F,S]=mspec(sstf, Psi);
F = F*24;
S = S/24;

semilogx(F, S.*F);
xlabel('cpd');
ylabel('var');


%%

amparray = 0:.05:.5;
days = 1;
stdarray = NaN(size(amparray));
meanarray = stdarray;
% stdsmooth = stdarray;
for i=1:length(amparray)
%     stdsmooth(i) = bootstrapErrors_smooth(2*noisebase, 500, amparray(i), days);
    [stdarray(i) meanarray(i)] = bootstrapErrors(noisebase, 50, amparray(i), days);
%     meanarray(i) = bootstrapErrors(noisebase, 50, amparray(i), days);
end
%%
figure
title(num2str(days));
plot(amparray, stdarray./amparray,'k')
hold on
plot(amparray, 2*meanarray/sqrt(24), 'b');
hold off
grid on
ylabel('Standard Error'); xlabel('True amplitude');