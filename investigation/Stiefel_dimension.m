function Stiefel_dimension
	clear; close all; clc;
	for index = 1:999999999999999
		%index
		Stiefel_dimension_sub;
	end
end

function Stiefel_dimension_sub
	row_num = 10;
	col_num = 2;

	X = randn(row_num, col_num) + i * randn(row_num, col_num);
	X = orth(X);
	Z = randn(row_num, col_num) + i * randn(row_num, col_num);

	dimension_norm_space = col_num * col_num;
	dimension_norm_space = 9999;

	normal_vector_container = [];
	for index = 1: dimension_norm_space
		normal_vector = X * mysym(randn(col_num) + i * randn(col_num) );
		normal_vector = normal_vector(:);
		normal_vector_container = [normal_vector_container, normal_vector];
	end

	normal_space   = orth(normal_vector_container) * ctranspose(orth(normal_vector_container)); 

	
	tangent_space  = eye(row_num * col_num) - normal_space;
	
		
	normal_vector =  normal_space * Z(:);
	tangent_vector = Z(:) - normal_vector;
	tangent_vector2 = tangent_space * Z(:);

	assert(norm(tangent_vector(:) - tangent_vector2(:)) < 1e-6);	

	

	normal_vector  = reshape(normal_vector, row_num, col_num);
	tangent_vector = reshape(tangent_vector, row_num, col_num);
	
	residual = normal_vector + tangent_vector - Z;
	inner_product = trace(normal_vector' * tangent_vector);
	skew_residual = ctranspose(X) * tangent_vector + ctranspose(ctranspose(X) * tangent_vector);
	
	assert(norm(residual(:)) < 1e-6);
	assert(norm(inner_product(:)) < 1e-6);
	assert(norm(skew_residual(:)) < 1e-6);
 
end

function result = mysym(A)
	result = (A + ctranspose(A) ) / 2;	 
end

function result = myskew(A)
	result = (A - ctranspose(A)) / 2;	
end