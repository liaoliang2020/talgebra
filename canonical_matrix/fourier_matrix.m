function fourier_matrix_result = fourier_matrix(n)
	% this function computes the nxn Fourier matrix 
	assert(isscalar(n));
	assert(n > 0);
	
	
	fourier_matrix_result = fft(eye(n), [], 1);

	
	%---------------------------
	%the following code is correct, but not efficient.
	%
	%fourier_matrix_result = zeros(n, n);
    %
	%const = -2 * pi * sqrt(-1) / n;
	%for i = 1: n
	%	for j = 1: n
	%		liaoliang = const * (i - 1) * (j - 1);			
	%		fourier_matrix_result(i, j) = exp(liaoliang);			
	%	end
	%end
	
	
	%-------------------------
	
	
	

	
end