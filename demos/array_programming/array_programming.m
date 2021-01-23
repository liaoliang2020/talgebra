function array_programming
	clear; close all; clc;
	
	tsize = [3, 3];
	row_num = 7;
	col_num = 5;

	A = randn([tsize, row_num, col_num]);
	B = A;
	for i = 1: numel(tsize)
		B = fft(B, [], i);
	end

	C = B;
	C = reshape(C, prod(tsize), []);

	TU = zeros(prod(tsize), row_num, col_num);
	TS = zeros(prod(tsize), col_num, col_num);
	TV = zeros(prod(tsize), col_num, col_num);
	for i = 1: prod(tsize)
		slice = reshape(C(i, :), row_num, col_num);
		[U, S, V] = svd(slice, 'econ');
		TU(i, :, :) = U;
		TS(i, :, :) = S;
		TV(i, :, :) = V;
	end

	TU = reshape(TU, [tsize, size(TU, 2), size(TU, 3) ]);
	TS = reshape(TS, [tsize, size(TS, 2), size(TS, 3) ]);
	TV = reshape(TV, [tsize, size(TV, 2), size(TV, 3) ]);


	
	% -------------------------
	% Another method for the same computing 
	[TU2, TS2, TV2] = arrayfun(@(i)  svd(reshape(C(i, :), row_num, col_num), 'econ'), ... 		
		1: prod(tsize), 'UniformOutput', false);
	
	TU2 = cell2mat(TU2);  	
	TU2 = reshape(TU2, row_num, col_num, prod(tsize));
	TU2 = permute(TU2, [3, 1, 2]);

	TS2 = cell2mat(TS2);	
	TS2 = reshape(TS2, col_num, col_num, prod(tsize));
	TS2 = permute(TS2, [3, 1, 2]);


	TV2 = cell2mat(TV2);	
	TV2 = reshape(TV2, col_num, col_num, prod(tsize));
	TV2 = permute(TV2, [3, 1, 2]);

	TU2 = reshape(TU2, [tsize, size(TU2, 2), size(TU2, 3) ]);
	TS2 = reshape(TS2, [tsize, size(TS2, 2), size(TS2, 3) ]);
	TV2 = reshape(TV2, [tsize, size(TV2, 2), size(TV2, 3) ]);



	assert(norm(TU(:) - TU2(:)) < 1e-6 );
	assert(norm(TS(:) - TS2(:)) < 1e-6 );
	assert(norm(TV(:) - TV2(:)) < 1e-6 ); 

	for i = 1: numel(tsize)
		TU = ifft(TU, [], i);
		TS = ifft(TS, [], i);
		TV = ifft(TV, [], i);
	end

	TU2 = idempotent_base(tsize) * reshape(TU2, prod(tsize), []); 
	TU2 = reshape(TU2, [tsize, row_num, col_num]);

	TS2 = idempotent_base(tsize) * reshape(TS2, prod(tsize), []); 
	TS2 = reshape(TS2, [tsize, col_num, col_num]);

	TV2 = idempotent_base(tsize) * reshape(TV2, prod(tsize), []); 
	TV2 = reshape(TV2, [tsize, col_num, col_num]);


	assert(norm(TU(:) - TU2(:)) < 1e-6 );
	assert(norm(TS(:) - TS2(:)) < 1e-6 );
	assert(norm(TV(:) - TV2(:)) < 1e-6 ); 

	fprintf('Alll asserts in this script are passed.\n'); 

end

