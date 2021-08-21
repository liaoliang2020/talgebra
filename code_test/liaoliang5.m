function liaoliang5
	clear; close all; clc;

	row_num = 128;
	col_num = 128;
	load penny;
	
	assert(isequal(size(P), [row_num, col_num]));

	Q = dct(P, [], 1);
	R = dct(Q, [], 2);

	% dct_collection = []; 
	% for i = 1: col_num
	% 	p_column = P(:, i);
	% 	liaoliang = dct(p_column, 'Type', 1);
	% 	dct_collection = [dct_collection, liaoliang];
	% end

	% for i = 1: row_num
	% 	p = dct_collection(i, :);
	% 	liaoliang = dct(p, 'Type', 1);
	% 	dct_collection(i, :) = liaoliang;
	% end

	% norm(dct_collection - R, 'F')

	X = R(:);
	% [liaoliang, index] = sort(abs(X), 'descend');
	% save liaoliang liaoliang
	% save index index
	% save X X

	[~, ind] = sort(abs(R(:)),'descend');
	coeffs = 1;
	while norm(X(ind(1:coeffs)))/norm(X) < 0.999
   		coeffs = coeffs + 1;
	end
	fprintf('%3.1f%% of the coefficients are sufficient\n', coeffs /numel(R) * 100)

end