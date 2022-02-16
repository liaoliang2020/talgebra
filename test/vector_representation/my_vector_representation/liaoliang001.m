function liaoliang001
	clear; close all; clc;

	tsize = [3 3];
	row_num = 7;
	col_num = 1;

	tvector = randn([tsize, row_num, col_num]);

	liaoliang  = tvector2vector(tvector, tsize);
	liaoliang = vector2tvector(liaoliang, tsize);

	assert(isequal(size(tvector), size(liaoliang)) );

	%---------------------
	M = 7; 
	N = 3;
	L = 11;

	tmatrix1 = randn([tsize, M, N]) + i * randn([tsize, M, N]);
	tmatrix2 = randn([tsize, N, L]) + i * randn([tsize, N, L]);  

	result = tmultiplication(tmatrix1, tmatrix2, tsize);
	result2 = tmatrix2matrix(tmatrix1, tsize) * tmatrix2matrix(tmatrix2, tsize);
	result2 = matrix2tmatrix(result2, tsize);


	assert(isequal(size(result), size(result2)));
	assert(norm(result(:) - result2(:)) < 1e-6);

	%---------------------
	M = 7; 
	N = 7;
	L = 7;

	tmatrix1 = randn([tsize, M, N]) + i * randn([tsize, M, N]);
	tmatrix2 = randn([tsize, N, L]) + i * randn([tsize, N, L]);  

	result = tmatrix1 + tmatrix2;
	result2 = tmatrix2matrix(tmatrix1, tsize) + tmatrix2matrix(tmatrix2, tsize);
	result2 = matrix2tmatrix(result2, tsize);

	assert(isequal(size(result), size(result2)));
	assert(norm(result(:) - result2(:)) < 1e-6);


	%---------------------
	fprintf('2222222------------\n')
	M = 7; 
	N = 5;
	L = 1;

	tmatrix1 = randn([tsize, M, N]) + i * randn([tsize, M, N]);
	tvector  = randn([tsize, N, L]) + i * randn([tsize, N, L]);

	result = tmultiplication(tmatrix1, tvector, tsize);
	result2 = tmatrix2matrix(tmatrix1, tsize) * tmatrix2matrix(tvector, tsize);
	result2 = matrix2tmatrix(result2, tsize);

	assert(isequal(size(result), size(result2)) );
	assert(norm(result(:) - result2(:) ) < 1e-6 );
	
	%--------
	fprintf('3333333------------\n')
	result3 = tmatrix2matrix(tmatrix1, tsize) * tvector2vector(tvector, tsize);
	result3 = vector2tvector(result3, tsize);

	assert(isequal(size(result), size(result3)) );
	assert(norm(result(:) - result3(:) ) < 1e-6 );

	%return;

	
	%--------
	fprintf('my SVD------------\n')
	M = 7;
	N = 5;
	tsize = [3 3];
	K = prod(tsize);
	
	liaoliang = randn([tsize, M, N]) + i * randn([tsize, M, N]);
	TMATRIX  = liaoliang;



	liaoliang_matrix = tmatrix2matrix_directsum(liaoliang, tsize);


	assert(isequal(size(liaoliang_matrix), [K * M, K * N] ));

	% whos liaoliang_matrix
	[U, S, V] = svd(liaoliang_matrix, 'econ');
	S = diag(S);

	numel_singuvalue_values = min(M, N);
 	assert(numel(S) / numel_singuvalue_values == K);


	TS = vector2tvector_directsum(S, tsize);		
	numel_singuvalue_values = size(TS, numel(tsize) + 1);
	assert(size(TS, numel(tsize) + 2) == 1);

	TS = reshape(TS, [prod(tsize), numel_singuvalue_values] );
	myTS = zeros([prod(tsize), numel_singuvalue_values, numel_singuvalue_values]);

	for k = 1: numel_singuvalue_values
		myTS(:, k, k) = TS(:, k);	
	end 
	myTS = reshape(myTS, [tsize, numel_singuvalue_values, numel_singuvalue_values]);

	
	%----------for TU------------------
	TU = zeros([prod(tsize) * M, numel_singuvalue_values]);
	
	for k = 1: numel_singuvalue_values
		subU = U(:, k: numel_singuvalue_values: end);


		assert(size(subU, 1) == M * K);
		assert(size(subU, 2) == K);

		matrix_directsum_collection = zeros((M * K) * (K), K);
		
		tvector = 0;
		for j = 1: K
			canonical_vector = subU(:, j);
			assert(isequal(size(canonical_vector), [M * K, 1] )); 
			
			my_tvector_rankOne = vector2tvector_directsum(canonical_vector, tsize); 
			assert(isequal(size(my_tvector_rankOne), [tsize, M] ));
			
			tvector = tvector + my_tvector_rankOne;

			matrix_directsum_rankOne = tmatrix2matrix_directsum(my_tvector_rankOne, tsize);	
			assert(isequal(size(matrix_directsum_rankOne), [K * M, K] ));
			
			
			assert(abs(norm(matrix_directsum_rankOne, 'fro') - 1) < 1e-6);
			assert(rank(matrix_directsum_rankOne) == 1);
			matrix_directsum_collection(:, j) = matrix_directsum_rankOne(:);

		end%for j = 1: K

		TU(:, k) = tvector(:);	

		% the following assertions are verified. corrected. 
		for m = 1: K
			for n = 1: K
				liaoliang = dot(matrix_directsum_collection(:, m), matrix_directsum_collection(:, n));
				if m == n
					assert(abs(liaoliang - 1) < 1e-6) 
				else 
					assert(abs(liaoliang) < 1e-6) 
				end
				
			end
		end

		%--------------------
		% the followinng statements are also verified. 
		% matrix_directsum_collection = zeros((M * K) * (K), K);	%initial definition
		matrix_directsum_collection = reshape(matrix_directsum_collection, [K * M, K, K]);
		for m = 1: K
			for n = 1: K
				liaoliang = trace(ctranspose(matrix_directsum_collection(:, :, m)) * matrix_directsum_collection(:, :, n));    
				
				if m == n
					assert(abs(liaoliang - 1) < 1e-6) 
				else 
					assert(abs(liaoliang) < 1e-6) 
				end
				
			end%for n = 1: K
		end%for m = 1: K


	end%for k = 1: numel_singuvalue_values
	TU = reshape(TU, [tsize, M, numel_singuvalue_values]);

	fprintf('----------------------1111-----\n');

	%----------for TV------------------
	TV = zeros([prod(tsize) * N, numel_singuvalue_values]);


	for singular_index = 1: numel_singuvalue_values
		% singular_index

		subV = V(:, k: numel_singuvalue_values: end);
		assert(size(subV, 1) == N * K);
		assert(size(subU, 2) == K);

		matrix_directsum_collection_tvector = zeros((N * K) * (K), K);

		tvector_V = 0;

		for slice_index = 1: K
			% slice_index
			canonical_vector = subV(:, slice_index);
			assert(isequal(size(canonical_vector), [N * K, 1] ));

			my_tvector_rankOne = vector2tvector_directsum(canonical_vector, tsize); 
			assert(isequal(size(my_tvector_rankOne), [tsize, N] ));

			tvector_V = tvector_V + my_tvector_rankOne;

			matrix_directsum_rankOne = tmatrix2matrix_directsum(my_tvector_rankOne, tsize);	
			assert(isequal(size(matrix_directsum_rankOne), [N * K , K] ));

			assert(abs(norm(matrix_directsum_rankOne, 'fro') - 1) < 1e-6);
			assert(rank(matrix_directsum_rankOne) == 1);

			matrix_directsum_collection_tvector(:, slice_index) = matrix_directsum_rankOne(:);
			
		end%for slice_index = 1: K

		TV(:, singular_index) = tvector_V(:);	

		for m = 1: K
			for n = 1: K
				% [m, n]
				liaoliang = dot(matrix_directsum_collection_tvector(:, m), matrix_directsum_collection_tvector(:, n));
				if m == n
					assert(abs(liaoliang - 1) < 1e-6) 
				else 
					assert(abs(liaoliang) < 1e-6) 
				end
			end
		end


		matrix_directsum_collection_tvector = reshape(matrix_directsum_collection_tvector, [K * N, K, K]);

		for m = 1: K
			for n = 1: K
				liaoliang = trace(ctranspose(matrix_directsum_collection_tvector(:, :, m)) * matrix_directsum_collection_tvector(:, :, n));    
				
				if m == n
					assert(abs(liaoliang - 1) < 1e-6) 
				else 
					assert(abs(liaoliang) < 1e-6) 
				end				

			end

		end%for m = 1: K

	

	end%for singular_index = 1: numel_singuvalue_values


	TV = reshape(TV, [tsize, N, numel_singuvalue_values]);

	whos TU
	whos TV
	whos myTS

	% TMATRIX_residual = tmultiplication_arg3(TU, myTS, tctranspose(TV, tsize), tsize) - TMATRIX;
	% norm(TMATRIX(:))
	% norm(TMATRIX_residual(:)) 

	% D = tmultiplication(tctranspose(TU, tsize), TU, tsize)
	% whos D;
	  
	V = tmultiplication(tctranspose(TV, tsize), TV, tsize)
	whos V;
	




	







end