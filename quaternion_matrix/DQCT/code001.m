function code001
	clear; close all; clc;

	row_num = 7;
	col_num = 5;

	qmatrix = random_qmatrix(row_num, col_num);

	F1 = matrix2qmatrix(fourier_matrix(row_num) ) ;
	F2 = matrix2qmatrix(fourier_matrix(col_num)) ;

	for u = 1: row_num
		for v = 1: col_num

			%-----------------
			liaoliang = 0;
			liaoliang2 = 0;
			for m = 1: row_num
				for n = 1: col_num
					liaoliang = liaoliang + qmatrix(m, n) * F1(u, m) * F2(v, n); 
					liaoliang2 = liaoliang2 + F1(u, m) * F2(v, n) * qmatrix(m, n);
									
				end%for n = 1: col_num
			end%for m = 1: row_num

			% assert(norm(compact(liaoliang - liaoliang2), 'fro') < 1e-6 );
			

			qmatrix_CQDFT(u, v) =  liaoliang;
			qmatrix_CQDFT2(u, v) =  liaoliang2;

		end%for v = 1: col_num
	end%for u = 1: row_num
	
	qmatrix_CQDFT - qmatrix_CQDFT2	


	% assert(norm(compact(qmatrix_CQDFT - qmatrix_CQDFT2 ), 'fro') < 1e-6 );


	

	qmatrix_CQDFT3 = qtensormultiplication(F1, qmatrix, 1);
	qmatrix_CQDFT3 = qtensormultiplication(F2, qmatrix_CQDFT3, 2);


	% qmatrix_CQDFT4 = qmatrix_multiplication(F1, qmatrix);
	% qmatrix_CQDFT4 = qmatrix_multiplication(F2, permute(qmatrix_CQDFT4, [2 1]) );
	% qmatrix_CQDFT4 = permute(qmatrix_CQDFT4, [2 1]);

	f32 = qmatrix_CQDFT3 - qmatrix_CQDFT2;
	f31 = qmatrix_CQDFT3 - qmatrix_CQDFT;

	norm(compact(f32), 'fro')

	norm(compact(f31), 'fro')


end


function qmatrix = matrix2qmatrix(matrix)
	assert(ndims(matrix) == 2);

	row_num = size(matrix, 1);
	col_num = size(matrix, 2);

	qmatrix = quaternion([real(matrix(:)), imag(matrix(:)), zeros(row_num * col_num, 2)] );
	qmatrix = reshape(qmatrix, row_num, col_num); 
	

end