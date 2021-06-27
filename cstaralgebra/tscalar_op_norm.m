function operator_norm = tscalar_op_norm(tscalar)
	operator_spectrum = fftn(tscalar);
	operator_spectrum = operator_spectrum(:);

	operator_norm = max(abs(operator_spectrum));

end