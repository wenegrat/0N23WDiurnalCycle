% Script for Generating Diurnal Cycle Plots for JGR Manuscript
% AUTHOR: Jacob Wenegrat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
close all
clc

% Define the time range
trades = 1:2061;
calm = 2062:5373;
coldtongue = 5374:5757;
tiwwarm = 430:813; %Oct. 31 - Nov. 16th (16 days)
tiwcold = 46:429;
detail1 = tiwcold((13:(13+24+24*7))+(24*7));
detail2 = calm((13:(13+24+24*7))+(24*21));

% Define Variables
tempbins = -.5:.0125:.5; % Used for shear temperature anamoly colorscale
sst = dataset.density.fulldepth.temps(1,:)';

% Define Av variables
shu = (dataset.deepadcp.fullu(:,1) - dataset.deepadcp.fullu(:,6))./3.75;
shv = (dataset.deepadcp.fullv(:,1) - dataset.deepadcp.fullv(:,6))./3.75;
shmag = sqrt(shu.^2 + shv.^2);
avmag = dataset.measures.tauh./(1023*shmag);
% Calculate percentile
avcut = bootstrappercentile(avmag, .01, 1000);
av = avmag;
av(av>avcut) = NaN;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Section: Introduction/Methods
% 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% Figure 1 
% Map of PIRATA array and location of mooring
%==========================================================================
piratachart;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Section: Seasonal Cycle
%
% Long time series
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% Figure 2
% Long Time series of dSST and atmos variables
%==========================================================================
plot23Long(data23);


%==========================================================================
% Figure 3
% Climatology: Wind, SWR, dSST
%==========================================================================
plot23ClimSWR(data23)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Section: Enhanced Monitoring Period
%
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
loadBuoyancyFlux;
tri=triang(48-1)./24; %Following Kessler PDF
cmodDC = complex_demodulate_tri(sst, 1/24, tri);

%==========================================================================
% Figure 4
% Detailed overview panel.
%==========================================================================
Plot23wShortOver;

%==========================================================================
% Figure 5
% Detail plot of diurnal cycle
%==========================================================================
plotDetails(dataset, detail1);

%==========================================================================
% Figure 6
% Shear Plot: Trades
%==========================================================================
trange = trades;
makeShearPlot(dataset.variables.Emmpersec20mh, dataset.variables.Nmmpersec20mh, ...
    dataset.measures.uwndh, dataset.measures.vwndh, dataset.flux.netheat, ...
    dataset.density.fulldepth.fullmldh, av, dataset.deepadcp.riforwardreduce_sort, ...
    dataset, trange, tempbins);


%==========================================================================
% Figure 7
% Ri Plot: Trades
%==========================================================================
trange = trades;
limits = [0 .5];
figure
GradRI2_Stats;
set(gcf, 'Position', [0 0 656 352]);

%==========================================================================
% Figure 8
% Shear Plot: Variable
%==========================================================================

trange = calm;
makeShearPlot(dataset.variables.Emmpersec20mh, dataset.variables.Nmmpersec20mh, ...
    dataset.measures.uwndh, dataset.measures.vwndh, dataset.flux.netheat, ...
    dataset.density.fulldepth.fullmldh, av, dataset.deepadcp.riforwardreduce_sort, ...
    dataset, trange, tempbins);


%==========================================================================
% Figure 9
% Ri Plot: Variable
%==========================================================================
trange = calm;
limits = [0 .5];
figure
GradRI2_Stats;
set(gcf, 'Position', [0 0 656 352]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Section: EMP - TIW
%
% Brief focus on TIW
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% Figure 10
% Overview of TIW: V, Sh^2, N^2, Rsh^2, with density contours
%==========================================================================
plotTIWOver;

%==========================================================================
% Figure 11
% Ri plots (2x): N-S phases.
%==========================================================================

limits = [0 .7];

figure
gap = [.05 .1]; margh= .1; margw = .2;
subtightplot(2,1,1, gap, margh, margw)
trange = tiwcold;
GradRI2_Stats;
set(gca, 'XTickLabel','');
set(get(gca, 'Xlabel'), 'String', '');
subtightplot(2,1,2, gap, margh, margw)
trange = tiwwarm;
GradRI2_Stats;
set(get(gca, 'Title'),'String', '');
set(gcf, 'Position', [0 0 665 740]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Section: Marginal Instability
%
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%==========================================================================
% Figure 12
% MI Plot
%==========================================================================
plotMI;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Supplementary Information
%
% Error analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End Manuscript
