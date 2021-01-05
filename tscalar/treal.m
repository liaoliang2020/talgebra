function mytreal = treal(tscalar)
	% checked
	% this function returns the real part of a t-scalar
	% this function is optimzied on 11-22-2018 by liaoliang
	% this function is optimzied on 11-22-2018 by liaoliang for the second time

	% mytreal = 0.5 * (tscalar + tconj(tscalar));

	mytreal = ifftn(real(fftn(tscalar)));
end


%-------------------------------------------------
% This following is an equivalent function of the above function, but more computational expensive 
% function mytreal = treal_proc(tscalar)
% 	% this function returns the real part of a t-scalar
% 	[mynorm, myangle] = tnorm_angle(tscalar);

% 	mytreal = tcos(myangle);
% 	mytreal = tproduct(mytreal, mynorm);
% end