function conj_tscalar = tconj_tscalar(tscalar)
	% checked
	% this function compute the conjugate of a tscalar
	conj_tscalar = ifftn(conj(fftn(tscalar)));
end