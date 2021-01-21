function tsvd_demo
	% The following code demonstrate the TSVD of a random t-matrix 
	
	clear; close all; clc;

	% The shape of t-scalars is set to $3*3*3$
	tsize = [3, 3]; 
	M1 = 5;
	M2 = 3;

	t_matrix = randn([tsize, M1, M2]); 
	[U, S, V] = tsvd(t_matrix, tsize);
	whos t_matrix;
	whos U;
	whos S;
	whos V;
	
	tmatrix_product_result = tmultiplication(U, S, tsize);
	tmatrix_product_result = tmultiplication(tmatrix_product_result, tctranspose(V, tsize), tsize); 
	whos tmatrix_product_result;

	residual = norm(tmatrix_product_result(:) - t_matrix(:));
	fprintf('residual = %f \n', residual);

end