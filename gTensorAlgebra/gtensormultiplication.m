function gtensor_product = gtensormultiplication(tmatrix, gtensor, mod_k, tsize)
	% this function compute the generalized mode-k  multiplication of tmatrix and gtensor

	assert(isequal(tsize', tsize(:)));	 


	assert(isnumeric(tmatrix) & ~ismatrix(tmatrix)  );
	assert(isnumeric(gtensor) & ~ismatrix(gtensor)  );
	assert(ismember(mod_k, 1: (ndims(gtensor) - numel(tsize)) ));
	assert(size(tmatrix, numel(tsize) + 2) == size(gtensor, numel(tsize) + mod_k));


	for i = 1: numel(tsize)
		tmatrix = fft(tmatrix, [], i);
		gtensor = fft(gtensor, [], i);
	end


	%----------------
	row_num = size(tmatrix, numel(tsize) + 1);
	col_num = size(tmatrix, numel(tsize) + 2); 

	tmatrix = reshape(tmatrix, [prod(tsize),  prod([row_num, col_num]) ]);

	g_size = size(gtensor); 
	g_size(1: numel(tsize)) = [];
	gtensor = reshape(gtensor, [prod(tsize), prod(g_size)] );


	g_size_result = g_size;
	g_size_result(mod_k) = row_num;
	
	gtensor_product = zeros([prod(tsize), prod(g_size_result) ]);

	for i = 1: prod(tsize)
		slice_matrix = reshape(tmatrix(i, :), [row_num, col_num]);
		slice_tensor = reshape(gtensor(i, :), g_size);  
		slice_tensor_result = tensormultiplication(slice_matrix, slice_tensor, mod_k);
		gtensor_product(i, :) = slice_tensor_result(:);
	end

	gtensor_product = reshape(gtensor_product, [tsize, g_size_result]);


	for i = 1: numel(tsize)
		gtensor_product = ifft(gtensor_product, [], i);		
	end


end