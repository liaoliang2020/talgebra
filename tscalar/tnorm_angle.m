function [mynorm, myangle] = tnorm_angle(tscalar)
	% checked
	% this function compute the norm and angle of a t-scalar
	% this function is based on tsvd function

	[U, mynorm, ~] = tsvd(tscalar, size(tscalar));
	myangle = -i * ifftn(log(fftn(U)));
end





