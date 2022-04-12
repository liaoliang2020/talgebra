function test001
	clear; close all; clc;
	M = 7;
	N = 5;
	D = 3;


	qmatrix1 = quaternion(randn(M * N, 4) );
	qmatrix2 = quaternion(randn(N * D, 4) );

	qmatrix1 = reshape(qmatrix1, [M, N]);
	qmatrix2 = reshape(qmatrix2, [N, D]);

	whos qmatrix1;
	whos qmatrix2;


	for i = 1: M
		for j = 1: D
			liaoliang1 = 0;
			liaoliang2 = 0;

			for k = 1: N 
				liaoliang1 = liaoliang1 + qmatrix1(i, k) * qmatrix2(k, j);
				liaoliang2 = liaoliang2 + qmatrix2(k, j) * qmatrix1(i, k);
			end	
		
			result1(i, j) = liaoliang1;
			result2(i, j) = liaoliang2;

		end
	end
	
	result3 = qmatrix_multiplication(qmatrix1, qmatrix2);

	assert(norm(compact(result1 - result2), 'fro') > 1e-3 );
	norm(compact(result1 - result2), 'fro')
	norm(compact(result1 - result3), 'fro')

end