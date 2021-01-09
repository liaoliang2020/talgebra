function bool_result = is_nonnegative(tscalar)
	% created by liaoliang 20190211
	% checked
	% this function checks whether or not tscalar is a so-called nonnegative tscalar 


	if ~istreal(tscalar)
		bool_result = false;
		return;
	end


	tscalar = fftn(tscalar);
	residual = norm(reshape(abs(tscalar) - tscalar, 1, []));

	if residual < 1e-8
		bool_result = true;
	else 
		bool_result = false;
	end 

end