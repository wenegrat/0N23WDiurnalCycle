%%
%Validation of Sh^2_red

% Horizontal separation
us = NaN(5967,1);
mags = us;
vs = us;
for i=1:5967
    mask = isfinite(dataset.measures.Emmpersecih(i,:));
    if (sum(mask)>1)
    us(i) = interp1(dataset.descriptors.sendepth(mask), dataset.measures.Emmpersecih(i,mask)/1000, 35);
    end
    
        mask = isfinite(dataset.measures.Nmmpersecih(i,:));
    if (sum(mask)>1)
    vs(i) = interp1(dataset.descriptors.sendepth(mask), dataset.measures.Nmmpersecih(i,mask)/1000, 35);
    end
    
    mask = isfinite(dataset.measures.Magmmpersecih(i,:));
    if (sum(mask)>1)
    mags(i) = interp1(dataset.descriptors.sendepth(mask), dataset.measures.Magmmpersecih(i,mask)/1000, 35);
    end
end

rmsu = bootstrp(1000, @(up, dn) sqrt(nanmean((up-dn).^2)), us, dataset.deepadcp.u(:,7)/100);


rmsv = bootstrp(1000, @(up, dn) sqrt(nanmean((up-dn).^2)), vs, dataset.deepadcp.v(:,7)/100);


magdiff = sqrt(rmsu.^2 + rmsv.^2);
magdiff = bootstrp(1000, @(up, dn) sqrt(nanmean((up-dn).^2)), mags, dataset.deepadcp.mag(:,7)/100);

rmsmag = nanmean(magdiff);

slp = 10.1325;

errort = .0181; %From Paul's paper.
errors = .02;
deltaz1 = 5.25;
deltaz2 = 10;

g = 9.8;

meansa = gsw_SA_from_SP(nanmean(dataset.density.fulldepth.sals(:,1:4), 2),slp, 360-23, 0);


meanct = gsw_CT_from_t(meansa, nanmean(dataset.density.fulldepth.temps(1:6,:), 1)', 0);

alpha = gsw_alpha(nanmean(meansa), nanmean(meanct), 0);

beta = gsw_beta(nanmean(meansa), nanmean(meanct), 0);

% 
% alpha * errort*2/deltaz;
% beta * errors*2/deltaz;

%Note that drho/rho = alpha*Dt + beta*Ds.
covts = 0.16; %nancov(dataset.density.fulldepth.temps(3,:)', dataset.density.fulldepth.sals(:,3))

epsu1 = 0.095/sqrt(120);
disp(['\epsilon_{u1}: ', num2str(epsu1)]);

epsu2 = 0.095/sqrt(120) + rmsmag;
disp(['\epsilon_{u2} : ', num2str(epsu2)]);

epsrho = sqrt(alpha.^2*errort.^2 + beta.^2*errors.^2 + 2*alpha*beta*covts);
epsrho = epsrho./sqrt(6);
disp(['\epsilon_{rho} : ', num2str(epsrho)]);



epsuz1 = sqrt(2)*epsu1./deltaz1;
disp(['\epsilon_{u_z1} : ', num2str(epsuz1)]);

epsuz2 = sqrt(2)*epsu2./deltaz2;
disp(['\epsilon_{u_z2} : ', num2str(epsuz2)]);

epsn21 = sqrt(2)*epsrho./deltaz1;
disp(['\epsilon_{N^21} : ', num2str(epsn21)]);

epsn22 = sqrt(2)*epsrho./deltaz2;
disp(['\epsilon_{N^22} : ', num2str(epsn22)]);


%%
shvec = reshape(sqrt(dataset.deepadcp.sh2forward(:,1:12)), 5967*12, 1);
shmean = nanmean(shvec);
disp(['Mean Shear 0-100m:   ', num2str(shmean)]);

totalerror1 = 2*sqrt(shmean.^2.*epsuz1.^2 + 4*epsn21.^2);
totalerror2 = 2*sqrt(shmean.^2.*epsuz2.^2 + 4*epsn22.^2);

disp(['Total Error 0-35m:   ', num2str(totalerror1)]);
disp(['Total Error 35-100m:   ', num2str(totalerror2)]);



