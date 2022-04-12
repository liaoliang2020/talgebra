function dB = RSE(ground_truth_data, approximation_data)
	% this function computes the relative square error (RSE) of two numeric arrays of the same size

	assert(isnumeric(ground_truth_data));
	assert(isnumeric(approximation_data));

	assert(isequal(size(ground_truth_data), size(approximation_data) ) );
	dB = 10 * log10(norm(ground_truth_data(:) - approximation_data(:))  / norm(ground_truth_data(:) ) ); 

end