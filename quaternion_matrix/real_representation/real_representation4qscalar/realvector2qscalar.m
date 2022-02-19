function quaternion_number = realvector2qscalar(realvector)
	assert(isreal(realvector));
	assert(isequal(size(realvector), [4 1]) );
	
	quaternion_number = quaternion(reshape(realvector, 1, []) );	

end