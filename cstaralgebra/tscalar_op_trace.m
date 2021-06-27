function operator_det = tscalar_op_trace(tscalar)
	operator_spectrum = fftn(tscalar);
	operator_spectrum = operator_spectrum(:);

	operator_det = sum(operator_spectrum);

end