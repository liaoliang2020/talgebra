function TMATX2RankOneComponen_Non_direcsum_representation
	clear; close all; clc;
	
	tsize = [3 3];
	K = prod(tsize);
	row_num = 5;
	col_num = 2;

	tmatrix = randn([tsize, row_num, col_num]) + sqrt(-1) * randn([tsize, row_num, col_num]);

	original_tmatrix = tmatrix;

	tmatrix_non_ds_matrix = tmatrix2matrix(tmatrix, tsize);

	[U, S, V] = svd(tmatrix_non_ds_matrix, 'econ');

	
	assert(isequal(size(U), K * [row_num, min(row_num, col_num)] ));
	assert(isequal(size(V), K * [col_num, min(row_num, col_num)] ));
	assert(isequal(size(S), K * [min(row_num, col_num), min(row_num, col_num)] ));

	TU_rank_one_container = []; 
	for i = 1: size(U, 2)
		tvector_rankOne = vector2tvector(U(:, i), tsize);
		assert(isequal(size(tvector_rankOne), [tsize, row_num] ));
		TU_rank_one_container = [TU_rank_one_container, tvector_rankOne(:)];

	end%for i = 1: size(U, 2)

	assert(size(TU_rank_one_container, 2) == K * min(row_num, col_num)  );
	TU_rank_one_container = reshape(TU_rank_one_container, [prod(tsize), row_num, K * min(row_num, col_num)]);

	for i = 1: K * min(row_num, col_num)
		temp = TU_rank_one_container(:, :, i);
		tvector = reshape(temp, [tsize, row_num]);

		temp_matrix = tmatrix2matrix(tvector, tsize);
		temp_matrix =array_nullify(temp_matrix, 1e-6); 
		assert(rank(temp_matrix) == 1);  
		assert(abs(norm(temp_matrix, 'fro') - 1) < 1e-6 );	

	end%for i = 1: K * min(row_num, col_num) 

	for i = 1: K * min(row_num, col_num)
		for j = 1: K * min(row_num, col_num)
			tvector1 = TU_rank_one_container(:, :, i);
			tvector1 = reshape(tvector1, [tsize, row_num]);
			
			tvector2 = TU_rank_one_container(:, :, j);
			tvector2 = reshape(tvector2, [tsize, row_num]);	

			liaoliang = tmultiplication(tctranspose(tvector1, tsize), tvector2, tsize); 

			inner_product = trace_tscalar(liaoliang);

			if i == j
				assert(abs(inner_product - 1) < 1e-6)
			else 
				assert(abs(inner_product) < 1e-6)
			end			
			
		end%for j = 1: K * min(row_num, col_num)
	end%for i = 1: K * min(row_num, col_num)	

	%-----------------------------
	TV_rank_one_container = [];
	for i = 1: size(V, 2)
		tvector_rankOne = vector2tvector(V(:, i), tsize);
		assert(isequal(size(tvector_rankOne), [tsize, col_num] ));
		TV_rank_one_container = [TV_rank_one_container, tvector_rankOne(:)];
	end

	assert(size(TV_rank_one_container, 2) == K * min(row_num, col_num)  );

	TV_rank_one_container = reshape(TV_rank_one_container, [prod(tsize), col_num, K * min(row_num, col_num)]);

	for i = 1: K * min(row_num, col_num)
		temp = TV_rank_one_container(:, :, i);
		tvector = reshape(temp, [tsize, col_num]);

		temp_matrix = tmatrix2matrix(tvector, tsize);
		temp_matrix = array_nullify(temp_matrix, 1e-6);

		assert(rank(temp_matrix) == 1);  
		assert(abs(norm(temp_matrix, 'fro') - 1) < 1e-6 );
	
	end%for i = 1: K * min(row_num, col_num) 


	for i = 1: K * min(row_num, col_num)
		for j = 1: K * min(row_num, col_num)
			tvector1 = TV_rank_one_container(:, :, i);
			tvector1 = reshape(tvector1, [tsize, col_num]);

			tvector2 = TV_rank_one_container(:, :, j);
			tvector2 = reshape(tvector2, [tsize, col_num]);	

			liaoliang = tmultiplication(tctranspose(tvector1, tsize), tvector2, tsize); 

			inner_product = trace_tscalar(liaoliang);

			if i == j
				assert(abs(inner_product - 1) < 1e-6)
			else 
				assert(abs(inner_product) < 1e-6)
			end

		end%for j = 1: K * min(row_num, col_num)
	end%for i = 1: K * min(row_num, col_num)

	% TU_rank_one_container
	% TV_rank_one_container
	assert(isequal(size(TU_rank_one_container), [prod(tsize), row_num, K * min(row_num, col_num) ]));
	assert(isequal(size(TV_rank_one_container), [prod(tsize), col_num, K * min(row_num, col_num) ]));

	SVD_result = 0;
	for i = 1: K * min(row_num, col_num)
		tu_vector_rank_one = TU_rank_one_container(:, :, i);
		tu_vector_rank_one = reshape(tu_vector_rank_one, [tsize, row_num]);

		tv_vector_rank_one = TV_rank_one_container(:, :, i);
		tv_vector_rank_one = reshape(tv_vector_rank_one, [tsize, col_num]);

		tmatrix = tmultiplication(tu_vector_rank_one, tctranspose(tv_vector_rank_one, tsize), tsize);
		
		SVD_result = tmatrix * S(i, i) + SVD_result;


		temp = trank(tmatrix, tsize);
		rank_result = trace_tscalar(temp);
		assert(abs(rank_result - 1) < 1e-6);

		temp = tnorm(tmatrix, tsize);
		norm_result = trace_tscalar(tproduct(temp, temp));  

		assert(abs(norm_result - 1) < 1e-6); 

	end

	whos SVD_result;
	whos original_tmatrix;

	residual = SVD_result - original_tmatrix;
	assert(norm(residual(:)) < 1e-6 );

	fprintf('Non_directsum work-done\n');

end

%------------------
function result = array_nullify(array, eps)
	assert(isreal(eps));
	assert(eps < 0.1);
	
	array(abs(array(:)) < eps) = 0;
	result = array;

end
