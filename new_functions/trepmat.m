function result = trepmat(gtensor, r, tsize)
	assert(isequal(r', r(:)));	  
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(gtensor) - numel(tsize) >= 0);

	msize = size(gtensor);
	msize = msize((numel(tsize) + 1): end);
	assert(~isempty(msize));

	if numel(msize) == 1
		msize = [msize, 1];
	end

	for i = 1: numel(tsize)
		gtensor = fft(gtensor, [], i);
	end

	gtensor = reshape(gtensor, prod(tsize), []);

	result = [];
	for i = 1: prod(tsize)
		slice = gtensor(i, :);
		slice = reshape(slice, msize);

		slice_result = repmat(slice, r);

		if i == 1
			slice_result_size = size(slice_result);
			result = zeros([prod(tsize), prod(slice_result_size)]);
		end

		result(i, :) = reshape(slice_result, 1, []);
	end

	result = reshape(result, [tsize, slice_result_size]);

	for i = 1: numel(tsize)
		result = ifft(result, [], i);
	end

end