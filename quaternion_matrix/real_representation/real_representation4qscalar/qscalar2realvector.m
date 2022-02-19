function realvector = qscalar2realvector(quaternion_num)
	assert(isequal(class(quaternion_num), 'quaternion') );
	assert(isequal(size(quaternion_num), [1 1]));

	realvector = reshape(compact(quaternion_num), [], 1)
end