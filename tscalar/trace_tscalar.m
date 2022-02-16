function result = trace_tscalar(tscalar)
	% this function computes the trace of a t-scalar
	result = sum(reshape(fftn(tscalar), [], 1));

end