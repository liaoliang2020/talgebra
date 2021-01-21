function dB = PSNR(data1, data2, mode)
	
    if nargin == 2
		mode = 'real';
    end
    
    assert(isequal(mode, 'real') | isequal(mode, 'complex'));
	assert(isequal(size(data1), size(data2)))
	
	
	
	
	if isequal(mode, 'real')
		MAX = 255;
	else
		MAX = abs(255 + i * 255);
	end
	
	
	dB = 20 * log10(MAX * sqrt(numel(data1)) / norm(data1(:) - data2(:)));
		
end