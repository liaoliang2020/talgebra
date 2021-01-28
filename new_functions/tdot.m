function result = tdot(A, B, tsize)
	% This function generates the MATLAB function dot(A, B)

	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(A) - numel(tsize) >= 0);

	assert(isequal(size(A), size(B) ));
	
	msize = size(A);
	msize = msize((numel(tsize) + 1): end  );
	assert(~isempty(msize));

	if numel(msize) == 1
		msize = [msize, 1];
	end
	
	for i = 1: numel(tsize)
		A = fft(A, [], i);
		B = fft(B, [], i);
	end

	A = reshape(A, [prod(tsize), prod(msize)]);
	B = reshape(B, [prod(tsize), prod(msize)]);

	for i = 1: prod(tsize)
		sliceA = A(i, :);
		sliceA = reshape(sliceA, msize);

		sliceB = B(i, :);
		sliceB = reshape(sliceB, msize);

		result_slice = dot(sliceA, sliceB);
		result_slice_size = size(result_slice);

		if i == 1
			result = zeros([ prod(tsize), prod(result_slice_size)  ]);
		end

		result(i, :) = reshape(result_slice, 1, []);
	end

	result = reshape(reshape, [tsize, result_slice_size]);

	for i = 1: numel(tsize)
		result = ifft(result, [], i);
	end

end