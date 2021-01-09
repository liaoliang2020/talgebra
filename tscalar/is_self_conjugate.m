function bool_result = is_self_conjugate(tscalar)
	% checked
	% this function checks whether or not tscalar is a so-called real tscalar (i.e., self-conjugate tscalar)

	tscalar = fftn(tscalar);
	residual = norm(reshape(conj(tscalar) - tscalar, 1, []));

	if residual < 1e-8
		bool_result = true;
	else 
		bool_result = false;
	end 

end