sdata = ncdfread('/Users/JacobWenegrat/Documents/Sentinel/PIRATADATA/Density Inputs/s0N23W_dy_long.cdf');

% depths = sdata.depths;
sals = squeeze(sdata.S_41)';
sals(sals>1e30) = NaN;
ms = isfinite(sals(:,1)) & isfinite(sals(:,3));
bl = regress(sals(ms,1), [sals(ms,3) ones(size(sals(ms,3)))]);


scatter(sals(ms,1), bl(1)*sals(ms,3) + bl(2))
onetoone


% scatter(sals(ms,1), sals(ms,1) - (bl(1)*sals(ms,3) + bl(2)))
corr(bl(1)*sals(ms,3) + bl(2), sals(ms,1))