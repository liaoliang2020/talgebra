function  result = iffts(qarray, dumb_arg, mode)
	% this function generalizes the canonical MATLAB fft function
	% usage: result = iffts(qarray, []], i), which generalizes the 
	% canonica corresponding function

	assert(isequal(class(qarray), 'quaternion'));
	assert(ismember(mode, 1: ndims(qarray) ));
	assert(isempty(dumb_arg)); 

	result = qtensormultiplication(quaternionize(ifourier_matrix(size(qarray, mode))), qarray, mode);
	
end