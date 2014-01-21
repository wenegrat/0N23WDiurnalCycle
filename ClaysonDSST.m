dataset.measures.wspdd = averageDaily(dataset.measures.wspdh, 1, dataset.descriptors.datesen);

% Correct for log layer assumption cf. Sivareddy et al. 2013
z0= 1.52*1e-4;
zm = 4;
z = 10;
logcorr = log(z./z0)/log(zm./z0);

U = logcorr.*dataset.measures.wspdd;
P = -netevap.*heaviside(netevap); % Note this isn't quite right.
P = averageDaily(P, 1, dataset.descriptors.datesen);
P = 0.*P;

PS = maxDaily(swnet, dataset.descriptors.datesen);

for i=1:length(U)
   if(U(i) > 2)
       f = .262;
       a = .00265;
       b = .028;
       c = -.838;
       d = -.00105;
       e = .158;
   else
       f = .328;
       a = .002;
       b = .041;
       c = .212;
       d = -.000185;
       e = -.329;
   end
   
   dsst(i) = f + a.*PS(i) + b.*P(i) + c.*log(U(i)) + d.*PS(i).*log(U(i)) + e.*U(i);
end
