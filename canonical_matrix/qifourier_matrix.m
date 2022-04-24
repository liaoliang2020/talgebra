function ifourier_matrix_result = iqfourier_matrix(n)
	% this function computes the nxn inverse Fourier matrix 
	% ifourier_matrix_result = conj(fourier_matrix(n)) / n; 

	ifourier_matrix_result = qmatrix_inv(qfourier_matrix(n));

end

%The following function is equivalent to the above function 
%but the above function is more efficient

%function ifourier_matrix_result = sub_ifourier_matrix2(n)
%	ifourier_matrix_result = inv(fourier_matrix(n));
%end