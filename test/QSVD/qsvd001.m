function qsvd001
	clear; close all; clc;
	matrix_size = [5 5];

	qmatrix = quaternion(randn(prod(matrix_size), 4)  );
	qmatrix = reshape(qmatrix, matrix_size);

	matrix = qmatrix2matrix(qmatrix);
	[U, S, V] = svd(matrix, 'econ'); 
	S = diag(S);
	S = reshape(S, 2, []);
	S = S(1, :); 
	S = diag(S);

	QS = quaternion(S, zeros(size(S)), zeros(size(S)), zeros(size(S)) );
	
	U = U(:, 1:2:end);
	U1 = U(1: 5, :);
	U2 = U(6: end, :);
	U2 = conj(-1 * U2); 

	QU = quaternion(real(U1), imag(U1), real(U2), imag(U2) );
	
	V = V(:, 1:2:end);
	V1 = V(1:5, :);
	V2 = V(6:end, :);
	V2 = conj(-1 * V2);

	QV = quaternion(real(V1), imag(V1), real(V2), imag(V2) ); 

	liaoliang = qmatrix_multiplication(QU, QS);
	liaoliang = qmatrix_multiplication(liaoliang, qmatrix_ctranspose(QV) );

	norm(compact(liaoliang - qmatrix), 'fro')
		

end