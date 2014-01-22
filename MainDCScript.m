% Script for Generating Diurnal Cycle Plots for Ocean Sciences 2014 Poster
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

trange = tiwwarm;

% Define Variables

% Note Temp Bins need to be adjusted by time period
if isequal(trange, trades)
 tempbins = -.25:.0125:.25;
else
    tempbins = -.5:.0125:.5; % Works OK for entire time period.
end

sst = dataset.density.fulldepth.temps(1,:)';


%==========================================================================
% Overview Plot 
% Include: Wind Stress, Heat Flux, U, V, Density
%==========================================================================



%==========================================================================
% Overview of Diurnal Cycle Amplitude
% Complex Demodulation or Direct difference of max-min.
%==========================================================================
% tri=triang(48-1)./24; %Following Kessler PDF
% cmodDC = complex_demodulate_tri(sst, 1/24, tri);
% makeDCPlot(cmodDC, dataset);

%XXX - Consider adding wind stress here as well?
%XXX - Compare to Clayson parameterization?


%==========================================================================
% Shear Flow
% Surface Heat Flux at Top
% Temp, and Shear Flow
%==========================================================================
makeShearPlot(dataset.variables.Emmpersec20mh, dataset.variables.Nmmpersec20mh, ...
    dataset.measures.uwndh, dataset.measures.vwndh, dataset.flux.netheat, ...
    dataset.density.fulldepth.fullmld, dataset, trange, tempbins);


%==========================================================================
% Richardson Number
% Bulk and Gradient
%==========================================================================
makeGradRIPlot(dataset, trange, [ 0 5]);
makeBulkRIPlot(dataset, trange, [0 .5]);
