function result = myfft(gtensor, tsize)
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(gtensor) - numel(tsize) >= 2);

	for i = 1: numel(tsize)
		gtensor = fft(gtensor, [], i);
	end
	
	result = gtensor;

end