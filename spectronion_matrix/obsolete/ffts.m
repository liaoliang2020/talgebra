function  result = ffts(qarray, dumb_arg, mode, unit_quaternionic_square_roots)
	% this function generalizes the canonical MATLAB fft function
	% which generalizes the 
	% canonica corresponding function

	assert(isequal(class(qarray), 'quaternion'));
	assert(ismember(mode, 1: ndims(qarray) ));
	assert(isempty(dumb_arg)); 


	if nargin == 3
		unit_quaternionic_square_roots = quaternionize(i);
	end

	assert(isequal(class(unit_quaternionic_square_roots), 'quaternion' ));
	assert(size(unit_quaternionic_square_roots, 1) == 1);


	assert(norm(compact(unit_quaternionic_square_roots .* unit_quaternionic_square_roots ...
		-  quaternionize((-1) * ones(size(unit_quaternionic_square_roots)))), 'fro') < 1e-8); 


	qmatrix = quaternionic_fourier_matrix(size(qarray, mode), unit_quaternionic_square_roots);
	result = qtensormultiplication(qmatrix, qarray, mode);


	
end