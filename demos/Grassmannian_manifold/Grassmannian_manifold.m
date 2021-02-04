function Grassmannian_manifold
	clear; close all; clc;
	row_num = 11;
	col_num = 3;

	X = orth(randn(row_num, col_num));
	Y = orth(randn(row_num, col_num));

	assert(isequal(size(X), [row_num, col_num]));
	assert(isequal(size(Y), [row_num, col_num]));
	

end