function qtensor_product = qtensormultiplication(qmatrix, qtensor, mod_k)

	assert(isequal(class(qmatrix), 'quaternion') );
	assert(isequal(class(qtensor), 'quaternion') );
	
	assert(ndims(qmatrix) == 2);
	assert(ismember(mod_k, 1: ndims(qtensor) ));
	assert(size(qmatrix, 2) == size(qtensor, mod_k));


	order_num = ndims(qtensor);
	tensor_size = size(qtensor);

	tensor_size(mod_k) = size(qmatrix, 1);


	tensor_product = qmatrix * qtensorfactorkflattening(tensor, mod_k);



	



end