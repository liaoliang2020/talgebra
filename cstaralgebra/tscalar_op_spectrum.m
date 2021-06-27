function operator_spectrum = tscalar_op_spectrum(tscalar)
	operator_spectrum = fftn(tscalar);
	operator_spectrum = operator_spectrum(:);

end