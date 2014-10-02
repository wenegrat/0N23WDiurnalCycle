function stdout = bootstrapErrors_smooth(noisebase, nboot, amp, avgdays)
tri=triang(48-1)./24; %Following Kessler PDF

ntimes = 300*24;

sig = amp*cos(2*pi/24* (1:ntimes));

ampest = NaN(nboot, ntimes/(avgdays*24));
for i=1:nboot
    nois = randn(ntimes, 1); %generate random noise
    nois = sqrt(noisebase)./std(nois)*nois; %scale according to input

    sigwnoise = sig' + nois; % Noisy signal
    
    
    cmodsig = complex_demodulate_tri(sigwnoise, 1/24, tri);
    
    ampest(i,:) = BlockMean(cmodsig.semimaj, avgdays*24, 1);
    ampest(i,:) = smooth(ampest(i,:), 5);
end
    ampest = reshape(ampest, nboot*ntimes/(avgdays*24), 1);
    ampest = sort(ampest(isfinite(ampest)), 'ascend');
    stdout = nanstd(ampest);
end