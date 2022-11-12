function [U, S, V] = svd_min(matrix)
	assert(isequal(class(matrix), 'double'));
	assert(ndims(matrix) == 2);

	[U, S, V] = svd(matrix, 'econ');
	r = rank(matrix);
	U = U(:, 1:r);
	V = V(:, 1:r);
	S = S(1:r, 1:r);

end