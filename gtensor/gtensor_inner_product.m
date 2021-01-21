function tscalar_result = gtensor_inner_product(gtensor1, gtensor2, tsize)
	assert(isequal(tsize', tsize(:)));
	assert(isequal(size(gtensor1), size(gtensor2) ));

	gtensor_size = size(gtensor1);
	% gtensor_macro_size = gtensor_size(numel(tsize) + 1, end);
	assert(isequal(gtensor_size(1: numel(tsize) ), tsize));

	for i = 1: numel(tsize)
		gtensor1 = fft(gtensor1, [], i);
		gtensor2 = fft(gtensor2, [], i);
	end


	

	gtensor1 = reshape(gtensor1, prod(tsize), []);
	gtensor2 = reshape(gtensor2, prod(tsize), []);
	
	tscalar_result = zeros(tsize);

	for i = 1: prod(tsize)
		slice1 = reshape(gtensor1(i, :), [], 1);
		slice2 = reshape(gtensor2(i, :), [], 1);
		tscalar_result(i) = slice1' * slice2;
	end

	for i = 1: numel(tsize)
		tscalar_result = ifft(tscalar_result, [], i);
	end

end