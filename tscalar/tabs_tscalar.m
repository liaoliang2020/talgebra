function myresult = tabs_tscalar(tscalar)
	% this function compute the genneralized absolute value of a t-scalar
	% created by liaoliang on 11-22-2018
	% checked 2018-12-03
	myresult = ifftn(abs(fftn(tscalar)));
end