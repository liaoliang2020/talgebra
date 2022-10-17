function commplex_array = qarray2carray(qarray)
	% this function convert a quaternion array to a complex array 
	% by dropping the j and k parts of each quaternions

	assert(isequal(class(qarray), 'quaternion'));
	mysize = size(qarray);
	qarray = comapct(qarray);	
	qarray = qarray(:, 1) + sqrt(-1) * qarray(:, 2);
	commplex_array = reshape(qarray, mysize);
end