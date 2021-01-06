function random_tscalar = randn_tscalar(tsize, mode)
	assert(isequal(tsize', tsize(:)));

	
	if nargin == 1
		mode = 'complex';
	end

	assert(isequal(mode, 'complex') |  isequal(mode, 'real'));
	
	if isequal(mode, 'complex')
		random_tscalar = randn(tsize) + i * randn(tsize);
	else 
		assert(isequal(mode, 'real'));
		random_tscalar = randn(tsize);
	end
	
	
end