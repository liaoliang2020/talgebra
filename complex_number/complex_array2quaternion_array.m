function result = complex_array2quaternion_array(complex_array)
	% this function updates a complex number to a quaternion array
	assert(~isreal(complex_array) );
	
	result = [real(complex_array(:)),  imag(complex_array(:)) ];
	result = [result, zeros(size(result))  ];
	result = quaternion(result);
	result = reshape(result, size(complex_array) );


end