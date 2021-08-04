function [U, S, V] = svd_tmatrix(tmatrix, tsize)
	assert(isequal(tsize', tsize(:)));
	assert(ndims(tmatrix) - numel(tsize) == 2 |  ndims(tmatrix) - numel(tsize) == 1 | ndims(tmatrix) - numel(tsize) == 0);
	
	matrix = tmatrix2matrix(tmatrix, tsize);
	[U, S, V] = svd(matrix, 'econ');

	whos U
	whos S
	whos V


end