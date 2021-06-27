function operator_det = tscalar_op_det(tscalar)
	operator_spectrum = fftn(tscalar);
	operator_spectrum = operator_spectrum(:);

	operator_det = prod(operator_spectrum);

	

end