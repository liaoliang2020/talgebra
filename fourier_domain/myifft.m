function result = myifft(gtensor, tsize)
	assert(isequal(tsize', tsize(:)));	  
	assert(ndims(gtensor) - numel(tsize) >= 2);

	for i = 1: numel(tsize)
		gtensor = ifft(gtensor, [], i);
	end
	
	result = gtensor;
	


end