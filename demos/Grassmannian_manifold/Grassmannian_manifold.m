function Grassmannian_manifold
	clear; close all; clc;
	for index = 1: 9999999
		Grassmannian_manifold_sub(index);
	end
end


function Grassmannian_manifold_sub(index)
	index
	
	row_num = 11;
	col_num = 3;


	X = orth(randn(row_num, col_num) + i * randn(row_num, col_num) );
	Y = orth(randn(row_num, col_num) + i * randn(row_num, col_num) );
	Z = randn(row_num, col_num) + i * randn(row_num, col_num);


	assert(isequal(size(X), [row_num, col_num]));
	assert(isequal(size(Y), [row_num, col_num]));
	assert(isequal(round(dot(X(:), Y(:)), 4), round(trace(X' * Y), 4)) )

	PI1 = Y * mysym(ctranspose(Y) * Z);
	PI2 = Y * myskew(ctranspose(Y)  * Z) + (eye(row_num) - Y * ctranspose(Y)) * Z;

	liaoliang001 = trace(PI1' * PI2); 
	liaoliang002 = dot(PI1(:), PI2(:));

	assert(abs(liaoliang001) < 1e-8);
	assert(abs(liaoliang002) < 1e-8);

end

%---------------------------
function result = mysym(A)
	result = (A + transpose(A) ) / 2;	 
end

function result = myskew(A)
	result = (A - transpose(A)) / 2;	
end