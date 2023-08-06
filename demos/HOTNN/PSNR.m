function dB = PSNR(data1, data2, max_value, mode)
	if nargin == 2
		mode = 'real';
		max_value = 255;
    end
    
    if nargin == 3
		mode = 'real';
	end	


    assert(isequal(mode, 'real') | isequal(mode, 'complex'));
	assert(isequal(size(data1), size(data2)))
	
	
	if isequal(mode, 'real')
		MAX = max_value;
	else
		MAX = abs(max_value + i * max_value);
	end
	
	
	dB = 20 * log10(MAX * sqrt(numel(data1)) / norm(data1(:) - data2(:)));
		
end