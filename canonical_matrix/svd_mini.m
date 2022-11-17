function [U, S, V] = svd_min(matrix)
	assert(isequal(class(matrix), 'double'));
	assert(ndims(matrix) == 2);
	
	r = rank(matrix);
	if r == 0
		U = zeros(size(matrix, 1), 1);
		V = zeros(size(matrix, 2), 1); 
		S = 0; 
		return;
	end

	[U, S, V] = svd(matrix, 'econ');
	U = U(:, 1:r);
	V = V(:, 1:r);
	S = S(1:r, 1:r);

end