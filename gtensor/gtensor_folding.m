function gtensor = gtensor_folding(tmatrix, mod_k, tsize, gsize)
	% this function is the inverse functio of FUNCTION gtensor_unfolding
	assert(isequal(tsize', tsize(:)));	 
	assert(isequal(msize', msize(:)));	 

	% msize_tmatrix = size(tmatrix);
	% msize_tmatrix = msize((numel(tsize) + 1): end  );
	% assert(~isempty(msize_tmatrix));

	% if numel(msize_tmatrix) == 1
	% 	msize_tmatrix = [msize_tmatrix, 1];
	% end

	% assert(prod(msize_tmatrix) == prod(gsize));

	% tmatrix = reshape(tmatrix, ); 


end