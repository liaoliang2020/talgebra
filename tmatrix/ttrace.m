function tresult = ttrace(tmatrix, tsize)
	% checked	
	% this function generalizes the trace of a canonical matrix

	assert(isequal(tsize', tsize(:)) );	  
	assert(ndims(tmatrix) - numel(tsize) == 2 |  ndims(tmatrix) - numel(tsize) == 0);
	assert(size(tmatrix, numel(tsize) + 1) == size(tmatrix, numel(tsize) + 2));  %input t-matrix must be square. 

	assert(isequal(size(tmatrix), [tsize, size(tmatrix, numel(tsize) + 1), size(tmatrix, numel(tsize) + 2)]) | ...  
		%isequal(size(tmatrix), [tsize, size(tmatrix, numel(tsize) + 1) ]) | ... 
		isequal(size(tmatrix), tsize) ...
	); 
	

	
	tresult = tdiag(tmatrix, tsize);
	vector_length = size(tresult, ndims(tresult) );
	
	tresult = reshape(tresult, [], vector_length);
	tresult = sum(tresult, 2);

	tresult = reshape(tresult, tsize);


end