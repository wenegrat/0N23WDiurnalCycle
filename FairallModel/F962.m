% Fairall 1996 Model
function [Dt U T] = F962(met, mld, dt_init)
%Inputs
del = .25;
rhoa = 1.22;
l = length(met.sw);
mld = interp1(1:l, mld, 1:del:l);
swr = interp1(1:l, met.sw, 1:del:l);
q =  interp1(1:l, met.lw + met.qlat + met.qsens, 1:del:l); % Sum of sensibile, latent, and long wave fluxes (ie outgoing fluxes)
tau = interp1(1:l, abs(met.tx), 1:del:l)/rhoa;

%Params
% bulktemp =  26.75;          % Initiate to a predawn bulk mixed layer temp
Ri_cr = 0.65;               % F96 and PWP
% dt_init = 19;               % F96 and Pyrtherch 2013

alpha       = 3.18e-4;      % Mean thermal expansion for entire record.
g			= 9.8;          %gravity (9.8 m/s^2)
Cp   		= 4000;       %specific heat of water (4183.3 J/kgC)
rho         = 1023;
dtime          = del*3600;


ctd1=sqrt(2*Ri_cr*Cp/(alpha*g*rho));
ctd2=sqrt(2*alpha*g/(Ri_cr*rho))/(Cp^1.5);
temp = NaN(size(mld));

I = NaN(size(mld)); %Index of integration starts

% tarray = (0:24)*dtime;
Dt = dt_init*ones(size(tau));
for i=2:length(tau) %doesn't work if i=1 is positive flux
    q_pwp = swr(i).*absorb(Dt(i)) - q(i);
    if (q_pwp>50)&&(i>2)
        It(i) = It(i-1) +  max(.002, tau(i))*dtime;
        Dt(i) = Dt(i-1);
        
        for j=1:5 % Iterate to converge depth
            dSw(i) = swr(i).*absorb(Dt(i));
            Is(i) = Is(i-1) + (dSw(i)' - q(i))*dtime;
            
            if (Is(i) > 0)
                Dt(i) = min(dt_init*3, ctd1 * It(i)/sqrt(Is(i))); % Update Dt for next time step
            else
                Dt(i) = dt_init;
            end
        end
   
    else % Reset to Initial vals
%         dt_init = mld(i);
        It(i) = 0;
        Is(i) = 0;
        Dt(i) = dt_init;
        temp(i) = dt_init;
    end 
end

Dt = double(~isfinite(temp)).*Dt;
Dt(Dt==0) = NaN;

T =ctd2*(Is(:)).^1.5./It(:);
U = 2*It./(Dt*rho);

dec = logical(repmat(eye(1/del, 1), l, 1));

T = T(dec);
Dt = Dt(dec);
U = U(dec);
% figure
% plot(Is)
% figure
% % plot(It)
% figure
% plot(T(dec))
% figure
% plot(Dt(dec))
end


function absrb = absorb(Dt)

% beta1   	= 0.6;          %longwave extinction coefficient (0.6 m)
% beta2   	= 20;           %shortwave extinction coefficient (20 m)
% 
% 
% rs1 = 0.6;
% rs2 = 1.0-rs1;
% 
% %absrb = zeros(nz,1);
% z1 = (0:nz-1)*dz;
% z2 = z1 + dz;
% z1b1 = z1/beta1;
% z2b1 = z2/beta1;
% z1b2 = z1/beta2;
% z2b2 = z2/beta2;
% absrb = (rs1*(exp(-z1b1)-exp(-z2b1))+rs2*(exp(-z1b2)-exp(-z2b2)))';
absrb = 1 - (0.6 * exp(-Dt/1) + .4*exp(-Dt/17));
%  Compute solar radiation absorption profile. 
% Based on parameters in F96 Eq (26)
n1 = 0.45 * 12.8 * (1 - exp(-Dt/12.8));
n2 = 0.27*.357*(1 - exp(-Dt/.357));
n3 = 0.28 * .014 * (1 - exp(-Dt/0.014));
absrb = (1 - (n1 + n2 + n3)/Dt)';

end % absorb