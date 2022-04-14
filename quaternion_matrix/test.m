function test
	clear; close all; clc;
	M = 3;
	N = 5;
	D = 2;
	
	qmatrix1 = quaternion(randn(M * N, 4) );
	qmatrix1 = reshape(qmatrix1, [M N]);

	qmatrix2 = quaternion(randn(N * D, 4) );
	qmatrix2 = reshape(qmatrix2, [N D]); 

	result = qmatrix_multiplication(qmatrix1, qmatrix2);
	result_transpose_version = qmatrix_multiplication_transpose_version(qmatrix1, qmatrix2);

	residual = result - result_transpose_version;

	assert(norm(compact(residual), 'fro') > 1e-6);

	for m = 1: M 
		for d = 1: D 
			liaoliang = 0;
			for n = 1: N
				liaoliang = liaoliang + qmatrix1(m, n) * qmatrix2(n, d);
			end
			C(m, d) = liaoliang;
		end
	end

	assert(norm(compact(result - C), 'fro') < 1e-6);

	for m = 1: M 
		for d = 1: D 
			liaoliang = 0;
			for n = 1: N
				liaoliang = liaoliang + qmatrix2(n, d) * qmatrix1(m, n);
			end
			C2(m, d) = liaoliang;
		end
	end

	assert(norm(compact(result_transpose_version - C2)) < 1e-6);

end