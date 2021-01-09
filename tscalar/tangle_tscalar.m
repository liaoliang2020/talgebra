function myresult = tangle_tscalar(tscalar)
	% this function compute the t-scalar angle of a t-scalar
	% created by liaoliang on 11-22-2018
	% checked 2018-12-03
	myresult = ifftn(angle(fftn(tscalar)));
end