function [stdout meandiffout] = bootstrapErrors(noisebase, nboot, amp, avgdays)
tri=triang(48-1)./24; %Following Kessler PDF

ntimes = 300*24;

sig = amp*cos(2 * pi/24 * (1:ntimes));

ampest = NaN(nboot, ntimes/(avgdays*24));
for i=1:nboot
    nois = randn(ntimes, 1); %generate random noise
    nois = sqrt(noisebase)./std(nois)*nois; %scale according to input

    sigwnoise = sig' + nois; % Noisy signal
    
    
    cmodsig = complex_demodulate_tri(sigwnoise, 1/24, tri);
    
    ampest(i,:) = BlockMean(cmodsig.semimaj, avgdays*24, 1);
%     med(i) = median(ampest(i,:));
end
    ampest = reshape(ampest, nboot*ntimes/(avgdays*24), 1);
    ampest = sort(ampest(isfinite(ampest)), 'ascend');
%     meandiffout = nanmedian(abs(amp - ampest))/.6745;
    meandiffout = mad(ampest, 1)/.6745;
    stdout = nanstd(ampest);
end