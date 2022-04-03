function test001
	clear; close all; clc;

	row_num = 2;
	col_num = 5;

	qmatrix1 = quaternion(randn(row_num * col_num, 4) );
	qmatrix1 = reshape(qmatrix1, [row_num, col_num]); 

	row_num2 = 5;
	col_num2 = 3;


	assert(col_num == row_num2);

	qmatrix2 = quaternion(randn(row_num2 * col_num2, 4) );
	qmatrix2 = reshape(qmatrix2, [row_num2, col_num2]); 


	whos qmatrix1
	whos qmatrix2

	assert(norm(qmatrix2matrix_another_version(qmatrix1) - qmatrix2matrix(qmatrix1)) > 1e-3);


	%------------------
	q1 = matrix2qmatrix_another_version(qmatrix2matrix_another_version(qmatrix1) * qmatrix2matrix_another_version(qmatrix2) );
	q2 = matrix2qmatrix(qmatrix2matrix(qmatrix1) * qmatrix2matrix(qmatrix2) );

	
	for i = 1: row_num
		for j = 1: col_num2
			q_mutiplication = quaternion(zeros(1, 4) );
			
			for k = 1: row_num2
				q_mutiplication = q_mutiplication + qmatrix1(i, k) * qmatrix2(k, j);

			end%for k = 1: row_num2
		
			q_mutiplication_result(i, j) = q_mutiplication;

		end%for j = 1: col_num2
	end%for i = 1: row_num

	%===
	for i = 1: row_num
		for j = 1: col_num2
			q_mutiplication = quaternion(zeros(1, 4) );
			
			for k = 1: row_num2
				q_mutiplication = q_mutiplication + qmatrix2(k, j) * qmatrix1(i, k);

			end%for k = 1: row_num2
		
			q_mutiplication_result2(i, j) = q_mutiplication;

		end%for j = 1: col_num2
	end%for i = 1: row_num
	

	assert(norm(compact(q1 - q2), 'fro') < 1e-6);
	assert(norm(compact(q1 - q_mutiplication_result), 'fro') < 1e-6 );   
	assert(norm(compact(q_mutiplication_result - q_mutiplication_result2), 'fro') > 1e-3 );

 	
	%----------------------
	q3 = matrix2qmatrix_another_version(pinv(qmatrix2matrix_another_version(qmatrix1)) );
	q4 = matrix2qmatrix(pinv(qmatrix2matrix(qmatrix1) ) );

	assert(norm(compact(q3 - q4)) < 1e-6 )




end