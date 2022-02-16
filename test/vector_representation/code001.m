function code001
	clear; close all; clc;

	tsize = [97 17];
	tscalar = randn(tsize) + sqrt(-1) * randn(tsize);
	
	tscalar_transformed = fftn(tscalar);
	matrix_representation = diag(tscalar_transformed(:));

	[V, D] = eig(matrix_representation);

	D = diag(D);
	for i = 1: size(V, 2)
		i 
		eigen_tscalar = vector2tscalar(V(:, i), tsize); 
		liaoliang = tproduct(tscalar, eigen_tscalar) - D(i) * eigen_tscalar;
		assert(norm(liaoliang(:)) < 1e-6 );
	end

	fprintf('good \n')


end