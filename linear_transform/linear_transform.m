function linear_transform 
	clear; close all; clc;
	N  = 3;
	my_fourier_matrix001 = fourier_matrix(N)

	my_fourier_matrix002 = my_fourier_matrix001([2 1 3], [2 1 3])
	my_fourier_matrix003 = my_fourier_matrix001([3 1 2], [3 1 2])

	norm(my_fourier_matrix002(:) - my_fourier_matrix003(:))




	coe = my_fourier_matrix002 ./ my_fourier_matrix001


	liaoliang = randn(3, 1);
	% % liaoliang = zeros(3, 1);
	% % liaoliang(2) = 5;
	
	liao001 = fft(liaoliang)
	
	liao002 = my_fourier_matrix002 * liaoliang

	liao003 = fourier_matrix(N) * liaoliang([2 1 3]);
	liao003 = liao003([2 1 3])
	
	norm(liao002 - liao003)

end