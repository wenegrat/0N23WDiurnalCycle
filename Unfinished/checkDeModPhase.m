delta = .2;
f = linspace(24-12*delta, 24+12*delta, 24);

for i=1:24
    subplot(6,4, i)
    cmri = complex_demodulate_tri(netevap, 1./f(i), tri);
    plot(unwrap(cmri.phase(1:1000)));
    title(num2str(f(i)));
    ylim([-10 10])
    xlim([1 1000])
end