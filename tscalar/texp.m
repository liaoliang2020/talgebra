function exp_result = texp(tsclar)
	% checked
	exp_result = ifftn(exp(fftn(tsclar))); 
end