function myreal = timag(tscalar)
	% this function compute the real part of a tscalar
	% checked
	% This function is optimzied by liaoliang on 11-22-2018
	% this function is optimized by liaoliang on 11-22-2018 for the second time.

	
	myreal = ifftn(real(fftn(tscalar)));

end