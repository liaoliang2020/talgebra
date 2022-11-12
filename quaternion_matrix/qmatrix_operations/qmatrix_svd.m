function [QU, QS, QV] = qmatrix_svd(qmatrix, K)
	% this function computes the SVD of a quaternion matrix 

	assert(isequal(class(qmatrix), 'quaternion'));
	assert(ndims(qmatrix) == 2);
	
	row_num = size(qmatrix, 1);
	col_num = size(qmatrix, 2);
	
	
	if nargin == 2
		
		assert(is_direct_sum(qmatrix, K));	
		assert(mod(row_num, K) == 0);
		assert(mod(col_num, K) == 0);

		QU = quaternion();
		QS = quaternion();
		QV = quaternion();

		row_num_direct_summand = row_num / K;
		col_num_direct_summand = col_num / K;

		for k = 1: K
			block_row_begin = (k - 1) * row_num_direct_summand + 1;
			block_row_end   = block_row_begin + row_num_direct_summand - 1; 

			block_col_begin = (k - 1) * col_num_direct_summand + 1;
			block_col_end   = block_col_begin + col_num_direct_summand - 1;

			direct_summand = qmatrix(block_row_begin: block_row_end, block_col_begin: block_col_end);
			[QU_summand, QS_summand, QV_summand] = qmatrix_svd(direct_summand);

			QU = qmatrix_blkdiag(QU, QU_summand);
			QS = qmatrix_blkdiag(QS, QS_summand);
			QV = qmatrix_blkdiag(QV, QV_summand);
		end%for k = 1: K

		return;

	end%if nargin == 2

	



	[U, S, V] = svd(qmatrix2matrix(qmatrix), 'econ');

	S = S(1:2:end, 1:2:end);
	QS = quaternionize(S);

	row_num_U = size(U, 1);
	col_num_U = size(U, 2);

	assert(mod(row_num_U, 2) == 0);
	assert(mod(col_num_U, 2) == 0); 
	
	U = U(:, 1:2:end);
	assert(isequal(size(U), [row_num_U, col_num_U / 2] ));

	for row_index = 1: (row_num_U / 2)
		for col_index = 1: (col_num_U / 2)
			row_begin = (row_index - 1) * 2 + 1;
			row_end   = row_begin + 1;
			X = U(row_begin: row_end, col_index);
			x1 = X(1);
			x2 = X(2);
			x2 = -conj(x2);

			QU(row_index, col_index) = quaternion([real(x1), imag(x1), real(x2), imag(x2)]);

		end%for col_index = 1: col_num
	end%for row_index = 1: row_num

	%---------
	row_num_V = size(V, 1);
	col_num_V = size(V, 2);

	assert(mod(row_num_V, 2) == 0);
	assert(mod(col_num_V, 2) == 0); 
	
	V = V(:, 1:2:end);
	assert(isequal(size(V), [row_num_V, col_num_V / 2] ));

	for row_index = 1: (row_num_V / 2)
		for col_index = 1: (col_num_V / 2)
			row_begin = (row_index - 1) * 2 + 1;
			row_end   = row_begin + 1;
			X = V(row_begin: row_end, col_index);
			x1 = X(1);
			x2 = X(2);
			x2 = -conj(x2);

			QV(row_index, col_index) = quaternion([real(x1), imag(x1), real(x2), imag(x2)]);
		end%for col_index = 1: (col_num_V / 2)
	end%for row_index = 1: (row_num_V / 2)

	% QU = matrix2qmatrix(U);
	% QS = matrix2qmatrix(S);
	% QV = matrix2qmatrix(V);

	
end