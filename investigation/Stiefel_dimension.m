function Stiefel_dimension
	clear; close all; clc;
	row_num = 11;
	col_num = 3;

	X = orth(randn(row_num, col_num) + i * randn(row_num, col_num) );
	Z = randn(row_num, col_num) + i * randn(row_num, col_num);

	% dimension_manifold = 2 * row_num * col_num - col_num * col_num;
	% dimension_tangent_space = dimension_manifold
	% dimension_norm_space = col_num * col_num;
	dimension_norm_space = col_num * col_num;

	normal_vector_container = [];
	for index = 1: dimension_norm_space
		index

		based_vector = zeros(col_num);
		based_vector(index) = 1;


		%normal_vector = X * mysym(randn(col_num) + i * randn(col_num) );

		
		

		normal_vector = normal_vector(:);
		normal_vector_container = [normal_vector_container, normal_vector];
	end

	% whos normal_vector_container

	normal_vector_container = reshape(normal_vector_container, [], dimension_norm_space);
	%whos normal_vector_container
	normal_space   = orth(normal_vector_container) * ctranspose(orth(normal_vector_container)); 
	tangent_space  = eye(row_num * col_num) - normal_space


	myrank_normal  = rank(normal_space);
	myrank_tangent = rank(tangent_space);

	
	
	normal_vector =  normal_space * Z(:);
	tangent_vector = Z(:) - normal_vector;
	tangent_vector2 = tangent_space * Z(:);

	norm(tangent_vector(:) - tangent_vector2(:))	

	

	% normal_vector  = reshape(normal_vector, [], 2);
	% tangent_vector = reshape(tangent_vector, [], 2);

	% normal_vector  = normal_vector(:, 1)  + i * normal_vector(:, 2); 
	% tangent_vector = tangent_vector(:, 1) + i * tangent_vector(:, 2);

	% normal_vector  = reshape(normal_vector, 2 * row_num, col_num);
	% tangent_vector = reshape(tangent_vector, 2 * row_num, col_num);

	normal_vector  = reshape(normal_vector, row_num, col_num);
	tangent_vector = reshape(tangent_vector, row_num, col_num);
	% whos normal_vector;
	% whos tangent_vector;
	
	residual = normal_vector + tangent_vector - Z
	inner_product = trace(normal_vector' * tangent_vector)
	skew_residual = X' * tangent_vector + ctranspose(X' * tangent_vector)
	
	assert(norm(residual(:)) < 1e-6);
	assert(norm(inner_product(:)) < 1e-6);
	assert(norm(skew_residual(:)) < 1e-6);

	rank_value = [myrank_normal; myrank_tangent]


	
 
end

function result = mysym(A)
	result = (A + ctranspose(A) ) / 2;	 
end

function result = myskew(A)
	result = (A - ctranspose(A)) / 2;	
end