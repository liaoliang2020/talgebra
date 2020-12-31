function myresult = tpower(tsclar, p_value)
	% this function compute the square root of a t-scalar
	myresult =  ifftn(power(fftn(tsclar), p_value));

end