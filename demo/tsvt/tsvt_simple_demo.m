function tsvt_simple_demo
	clear; close all; clc;
	
	tsize = [3, 3]; 
	row_num = 256;
	col_num = 256;
	
	A = load('compound_img_layer001');
	A = struct2cell(A); 
	A = A{1}; 
	A = double(A);
	assert(isequal(size(A), [tsize, row_num, col_num]));
	
	
	tau = 2000 * E_T(tsize);
	approximation_A = tsvt(A, tau, tsize);
	PSNR_OF_Approximation = PSNR(A, approximation_A);
	
	fprintf('PSNR_OF_Approximation = %f \n', PSNR_OF_Approximation);

	A_slice = squeeze(A(1, 1, :, :));
	approximation_A = squeeze(approximation_A(1, 1, :, :));
	imshow([A_slice, approximation_A], []);
	
end
