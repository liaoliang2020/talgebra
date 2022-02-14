function result = qarray_nullify(qmatrix, eps)
	
	assert(isequal(class(qmatrix), 'quaternion') );
	assert(isreal(eps));
	assert(eps < 0.1);



	result = qmatrix;
	result = compact(result); 

	result(abs(result) < eps) = 0;

	result = quaternion(result);
	result = reshape(result, size(qmatrix));

end