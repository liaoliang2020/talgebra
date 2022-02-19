function matrix = complex_number2matrix_representation(complex_number)
	% this function returns the real matrix representation of a complex number

	assert(~isreal(complex_number) );
	assert(isequal(size(complex_number), [1 1] ));
	matrix = [real(complex_number), -1 * imag(complex_number); imag(complex_number), real(complex_number) ];

end