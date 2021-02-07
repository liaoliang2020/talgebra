function Stiefel_manifold
	disp('Stiefel_manifold goes');
	clear; close all; clc;
	row_num = 11;
	col_num = 3;

	X = orth(randn(row_num, col_num) + 0 * randn(row_num, col_num) );
	Z = randn(row_num, col_num) + 0 * randn(row_num, col_num);
	
	N = X * mycsym(ctranspose(X) * Z);
	T = X * mycskew(ctranspose(X)  * Z) + (eye(row_num) - X * ctranspose(X)) * Z;
	
	% N' * N
	% return;

	% using the euclidean metric on the tangent space at the point X
	inner_product = trace(N' * T)

	assert(isequal(round(N + T, 4), round(Z, 4)));
	assert(norm(X' * T + ctranspose(X' * T), 'fro') < 1e-8);	
	assert(abs(inner_product) < 1e-6);
	
end

% function result = mysym(A)
% 	result = (A + transpose(A) ) / 2;	 
% end

% function result = isskew(A)
% 	if  norm(A + transpose(A), 'fro') < 1e-6
% 		result = true;
% 	else 
% 		result = false;
% 	end
% end


% function result = myskew(A)
% 	result = (A - transpose(A)) / 2;	
% end


function result = mycsym(A)
	result = (A + ctranspose(A) ) / 2;	 
end

function result = mycskew(A)
	result = (A - ctranspose(A)) / 2;	
end

function result = iscskew(A)
	if  norm(A + ctranspose(A), 'fro') < 1e-6
		result = true;
	else 
		result = false;

	end
end