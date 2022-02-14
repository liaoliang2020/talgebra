function [QU, QS, QV] = qsvd(qmatrix)
	% this function computes the SVD of a quaternion matrix 

	assert(isequal(class(qmatrix), 'quaternion') );
	assert(numel(size(qmatrix)) == 2);

	row_num = size(qmatrix, 1);
	col_num = size(qmatrix, 2);

	[U, S, V] = svd(qmatrix2matrix(qmatrix), 'econ');

	S = diag(S); 
	S = S(1:2:end);
	S = diag(S);

	QS = quaternion(S, zeros(size(S)), zeros(size(S)), zeros(size(S)) );

	U = U(:, 1:2:end);
	U1 = U(1: row_num, :);
	U2 = U((row_num + 1): end, :);
	U2 = conj(-1 * U2);

	QU = quaternion(real(U1), imag(U1), real(U2), imag(U2)); 

	%----------------
	V = V(:, 1:2:end);
	V1 = V(1: col_num, :);
	V2 = V((col_num + 1): end, :);
	V2 = conj(-1 * V2);

	QV = quaternion(real(V1), imag(V1), real(V2), imag(V2)); 

end