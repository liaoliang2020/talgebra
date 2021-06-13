function result = mykron(matrices_cell)
	assert(iscell(matrices_cell));
	assert(size(matrices_cell, 1) == 1 );

	result = matrices_cell{1};
	for i = 2: numel(matrices_cell)
		result = kron(matrices_cell{i}, result);
	end



end