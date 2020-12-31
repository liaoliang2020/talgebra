function bool_result = istpostive(tscalar)

	tscalar = fftn(tscalar);
	
	
	residual = norm(reshape(abs(tscalar) - tscalar, 1, []));

	if residual < 1e-8
		bool_result = true;
	else 
		bool_result = false;
	end 

end