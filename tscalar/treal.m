function real_part = treal(tscalar)
	% checked
	% this function returns the real part of a t-scalar
	% this function is optimzied on 11-22-2018 by liaoliang
	% this function is optimzied on 11-22-2018 by liaoliang for the second time

	% real_part = 0.5 * (tscalar + tconj(tscalar));

	real_part = ifftn(real(fftn(tscalar)));
end


%-------------------------------------------------
% This following is an equivalent function of the above function, but more computational expensive 
% function real_part = treal_proc(tscalar)
% 	% this function returns the real part of a t-scalar
% 	[mynorm, myangle] = tnorm_angle(tscalar);

% 	real_part = tcos(myangle);
% 	real_part = tproduct(real_part, mynorm);
% end