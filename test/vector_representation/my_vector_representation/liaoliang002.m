function liaoliang002
	clear; close all; clc;
	tsize = [3 1];
	K = prod(tsize);
	row_num = 5;
	col_num = 2;

	tmatrix = randn([tsize, row_num, col_num]) + sqrt(-1) * randn([tsize, row_num, col_num]);


	[TU, TS, TV] = tsvd(tmatrix, tsize);

	U = tmatrix2matrix_directsum(TU, tsize);
	S = tmatrix2matrix_directsum(TS, tsize);
	V = tmatrix2matrix_directsum(TV, tsize);

	assert(norm(U' * U - eye(size(U' * U)), 'fro') < 1e-6 );
	assert(norm(V' * V - eye(size(V' * V)), 'fro') < 1e-6 ); 

	%----------------------
	tmatrix_ds_matrix = tmatrix2matrix_directsum(tmatrix, tsize);
	[U2, S2, V2] = svd(tmatrix_ds_matrix, 'econ');
	
	assert(mod(size(U2, 1), K) == 0);
	assert(size(U2, 1) / K == row_num);

	U2_colum_order = [];
	for i = 1: size(U2, 2)
		temp = reshape(U2(:, i), [], K);		
		temp = abs(temp) .* abs(temp);
		norm_collection = sum(temp, 1);

		pos = find(norm_collection < 1e-6);
		pos = setdiff(1: K, pos);
		assert(numel(pos) == 1);
		
		U2_colum_order = [U2_colum_order; pos];
		
	end%for i = 1: size(U2, 2)	

	U2_colum_order = [reshape(1: (min(row_num, col_num) * K), [], 1), U2_colum_order, diag(S2)];

	U2_colum_order = sortrows(U2_colum_order, 2);
	U2_colum_order = U2_colum_order(:, 1);

	U2 = U2(:, U2_colum_order);
	V2 = V2(:, U2_colum_order);
	S2 = diag(S2); S2 = S2(U2_colum_order); S2 = diag(S2);

	TU2 = matrix2tmatrix_directsum(U2, tsize);
	TV2 = matrix2tmatrix_directsum(V2, tsize);
	TS2 = matrix2tmatrix_directsum(S2, tsize);

	assert(isequal(size(TU2), [tsize, row_num, min(row_num, col_num)])); 
	assert(isequal(size(TV2), [tsize, col_num, min(row_num, col_num)]));
	assert(isequal(size(TS2), [tsize, min(row_num, col_num), min(row_num, col_num)]));

	assert(norm(tmatrix2matrix_directsum(tmultiplication(tctranspose(TU2, tsize), ...
		TU2, tsize),  tsize) - eye(K * min(row_num, col_num)), 'fro') < 1e-6);
	
	assert(norm(tmatrix2matrix_directsum(tmultiplication(tctranspose(TV2, tsize), ...
		TV2, tsize),  tsize) - eye(K * min(row_num, col_num)), 'fro') < 1e-6);
		

	residual = tmultiplication_arg3(TU2, TS2, tctranspose(TV2, tsize), tsize) - tmatrix;

	assert(norm(residual(:)) < 1e-6);

	fprintf('---------done\n');	 



end
