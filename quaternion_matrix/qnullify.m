function result = qnullify(qarray, eps)
	% this function nullifiies each quaternion entity whose norm is less than eps

	if nargin == 1
		eps = 1e-6;
	end
	
	assert(isequal(class(qarray), 'quaternion') );
	assert(isreal(eps));
	assert(eps < 0.001);


	result = qarray;
	result = compact(result); 

	result(abs(result) < eps) = 0;
	result = quaternion(result);
	result = reshape(result, size(qarray));

end