function qsvd001
	clear; close all; clc;
	matrix_size = [5 5];

	qmatrix = quaternion(randn(prod(matrix_size), 4)  );
	qmatrix = reshape(qmatrix, matrix_size);
	whos qmatrix; 

end