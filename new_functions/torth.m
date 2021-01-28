function result = torth(A, tsize)
	% this function generates the MATALB function orth(A)
	% the size of output {result} is same to input {A} 

	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(A) - numel(tsize) >= 0);
	assert(ndims(A) - numel(tsize) <= 2);

	msize = size(A);
	msize = msize((numel(tsize) + 1): end  );
	assert(~isempty(msize));

	if numel(msize) == 1
		msize = [msize, 1];
	end

	for i = 1: numel(tsize)
		A = fft(A, [], i);	
	end

	A = reshape(A, [prod(tszie), prod(msize)]);

	result  = zeros([prod(tsize), prod(msize)]);
	for i = 1: prod(tsize)
		slice = A(i, :);
		slice = reshape(slice, msize);
		slice = orth(slice);

		slice = [slice(:); zeros( prod(msize) - numel(slice), 1)];
		slice = reshape(slice, msize);

		result(i, :) = reshape(slice, 1, []);
	end

	result = reshape(result, [tsize, msize]);
	for i = 1: numel(tsize)
		result = ifft(result, [], i);
	end

end