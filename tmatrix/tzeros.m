function tmatrix = tzeros(row_num, col_num, tsize)
	% this function gives the generalized t-matrix with all t-scalar entities are equal to E_T

	assert(isequal(tsize', tsize(:)));	  
	assert(isequal(abs([row_num, col_num]), [row_num, col_num]) );

	tmatrix = zeros([tsize, row_num, col_num]);
end