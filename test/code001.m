function code001
	clear; close all; clc;
	msize = [5 5];

	A = randn(msize) + i * randn(msize);
	B  = A + A';

	[Q, ddd] = jacobi_diagonalization(B);
	
	disp('-------------');
	ddd


	% B = Q' * B * Q







end