function t_identity_matrix = teye(row_col_num, tsize)
	% checked

	assert(isequal(tsize', tsize(:)));
	assert(row_col_num >= 1);

	t_identity_matrix = zeros([tsize, row_col_num, row_col_num]);
	t_identity_matrix = reshape(t_identity_matrix, prod(tsize), row_col_num, row_col_num);	

	for i = 1: prod(tsize)
		t_identity_matrix(i, :, :) = eye(row_col_num);
	end

	t_identity_matrix = reshape(t_identity_matrix, [tsize, row_col_num, row_col_num]);

	for i = 1: numel(tsize)
		t_identity_matrix = ifft(t_identity_matrix, [], i);				
	end


end