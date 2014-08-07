% Fairall 1996 Model
function F96(met)
%Inputs
swr = .97*met.sw(1:24);
q =  met.lw(1:24) + met.qlat(1:24) + met.qsens(1:24);  % Sum of sensibile, latent, and long wave fluxes (ie outgoing fluxes)
tau = .05*ones(24,1);%abs(met.tx(1:24));

%Params
% bulktemp =  26.75;          % Initiate to a predawn bulk mixed layer temp
Ri_cr = 0.65;               % F96 and PWP
dt_init = 19;               % F96 and Pyrtherch 2013

alpha       = 3.18e-4;      % Mean thermal expansion for entire record.
g			= 9.8;          %gravity (9.8 m/s^2)
Cp   		= 4000;       %specific heat of water (4183.3 J/kgC)
rho         = 1023;
dtime          = 3600;

maxlength = 8;             % num hours

% tarray = (0:24)*dtime;

%Integration
Dt(1) = dt_init;

%Find first
ind = find( (swr.*absorb(Dt(1)) - q) > 50, 1);
if (isempty(ind))
    display('Error')
    return
end
Dt(1:ind+1) = dt_init;
dSw(ind) = swr(ind).*absorb(Dt(ind));
It(ind) = tau(ind)*dtime;
Is(ind) = (dSw(ind)' - q(ind))*dtime;
ctd1=sqrt(2*Ri_cr*Cp/(alpha*g*rho));
ctd2=sqrt(2*alpha*g/(Ri_cr*rho))/(Cp^1.5);

for i=(ind+1):(ind+maxlength)
    It(i) = It(i-1) +  max(.002, tau(i))*dtime;
    Dt(i) = Dt(i-1);

    for j=1:5

    dSw(i) = swr(i).*absorb(Dt(i));
    
%     Is(i) = trapz(tarray(ind:i), dSw(ind:i)' - q(ind:i));  % Absorption of net heat flux over the layer (Eq. 20 in F96)
%     It(i) = trapz(tarray(ind:i), tau(ind:i)./rho);           % Absorption of wind stress  (Eq. 20 in F96).

    Is(i) = Is(i-1) + (dSw(i)' - q(i))*dtime;
    Dt(i) = min(40, ctd1 * It(i)/sqrt(Is(i))); % Update Dt for next time step
    end

%     Dt(i+1) = min(dt_init, (2*Ri_cr)^(1/2) * It(i) * (alpha*g*Is(i)/(Cp*rho))^-(1/2)); % Update Dt for next time step

end
dt_wrm =ctd2*(Is(:)).^1.5./It(:);
figure
plot(dt_wrm)
figure
plot(Dt)
end


function absrb = absorb(Dt)
%  Compute solar radiation absorption profile. 
% Based on parameters in F96 Eq (26)
n1 = 0.45 * 12.8 * (1 - exp(-Dt/12.8));
n2 = 0.27*.357*(1 - exp(-Dt/.357));
n3 = 0.28 * .014 * (1 - exp(-Dt/0.014));
absrb = (1 - (n1 + n2 + n3)/Dt)';
end % absorb