function result = tmean(gtensor, dimension_index, tsize)
	% This function generalizes the MATLAB function mean
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(gtensor) - numel(tsize) >= 0);

	msize = size(gtensor);
	msize = msize((numel(tsize) + 1): end  );
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
		slice = mean(slice, dimension_index);

		if i == 1
			slice_size = size(slice);	
			result = zeros(prod(tsize), numel(slice));
		end

		result(i, :) = reshape(slice, 1, []);
	end

	result = reshape(result, [tsize, slice_size]);

	for i = 1: numel(tsize)
		result = ifft(result, [], i);
	end

end