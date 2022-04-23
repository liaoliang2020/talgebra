function  qarray_ffts = ffts(qarray, dumb_arg, mode)
	% this function generalizes the canonical MATLAB fft function
	% usage: result = ffts(qarray, [], i), which generalizes the 
	% canonica corresponding function

	assert(isequal(class(qarray), 'quaternion'));
	assert(ismember(mode, 1: ndims(qarray) ));
	assert(isempty(dumb_arg)); 

	qarray_ffts = qtensormultiplication(quaternionize(fourier_matrix(size(qarray, mode))), qarray, mode);
	
end