function myresult = tpower(tsclar, p_value)
	% this function can compute the p power of a t-scalar
	% this function computes the square root of a t-scalar when p_value is equal to 0.5
	assert(isnumeric(p_value));
	assert(numel(p_value) == 1);
	
	myresult =  ifftn(power(fftn(tsclar), p_value));

end