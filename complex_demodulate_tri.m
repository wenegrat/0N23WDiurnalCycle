function r = complex_demodulate_tri( ts, f, triangle)
% COMPLEX_DEMODULATE - complex demodulation using a TRIANGLE SMOOTH.
%
% Usage: res = complex_demodulate( time_series, frequency, triangle);
%
% frequency should be in the same units as time series (i.e. if time series
% is hourly, frequency should be in inverse hours).  frequency can also be a
% row vector with as many elements as columns in time_series, in which case
% a different frequency will be used for each column.  filt_func defaults to
% @filttappered.  If time_series is a matrix with many columns, then it
% operates over columns.
%
% This function won't work on time_series arrays with more than 2
% dimensions.
%
% res is a structure with the following components:
%
%   semimaj = amplitude of major axis
%   semimin = amplitude of minor axis ( if time_series is complex )
%   inc = inclination of major axis with respect to real no. line (if complex)
%   phase = phase of time series (in radians).
%
% NOTE: Calculation of the inclination is a hack and I am not sure if
% phase is correctly calculated.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 	$Id: complex_demodulate.m,v 1.2 2005-06-01 18:35:23 dmk Exp $	
%
% Copyright (C) 2005 David M. Kaplan
% Licence: GPL (Gnu Public License)
%

% MODIFIED: Jacob Wenegrat 2014
% Uses triangle smoother rather than filter.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if nargin < 5
%   filt_func = 'filttappered';
% end

f = f(:)';
s = size(ts);

f = exp( - 2 * pi * (0:s(1)-1)' * f * 1i );

rp = conv(f.*ts, triangle, 'same');
% rp = f.*ts;
rp(1:length(triangle)) = NaN;
rp(end-length(triangle):end) = NaN;
% rp = feval( filt_func, B, A, ts .* repmat( f, s ./ size(f) ), varargin{:} );
% rm = feval( filt_func, B, A, ts .* repmat( conj(f), s ./ size(f) ), varargin{:} ); 

r.semimaj = 2.*abs(rp);
r.phase = atan2(imag(rp), real(rp));
% r.semimin = abs(rp) - abs(rm);
% r.inc = mod((angle(rp) + angle(rm))/2,pi); 
% r.phase = (angle(rp) - angle(rm))/2; 
