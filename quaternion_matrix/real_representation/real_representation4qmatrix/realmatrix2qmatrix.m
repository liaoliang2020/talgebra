function qmatrix = realmatrix2qmatrix(realmatrix)
	assert(isreal(realmatrix)); 
	assert(numel(size(realmatrix)) == 2 );

	assert(mod(size(realmatrix, 1) , 4) == 0);
	assert(mod(size(realmatrix, 2) , 4) == 0);

	row_num = size(realmatrix, 1) / 4;
	col_num = size(realmatrix, 2) / 4;

	qmatrix = quaternion(zeros(row_num * col_num, 4 ) );
	qmatrix = reshape(qmatrix, row_num, col_num);

	for i = 1: row_num
		for j = 1: col_num
			row_index1 = (i - 1) * 4 + 1;
			row_index2 = row_index1 + 4 - 1;

			col_index1 = (j - 1) * 4 + 1;
			col_index2 = col_index1 + 4 - 1;

			sub_real_matrix = realmatrix(row_index1: row_index2, col_index1: col_index2);	

			r1 = sub_real_matrix(1, :) .* [1 -1 1 -1];
			%----
			r2 = sub_real_matrix(2, :);  
			r2 = r2([2 1 4 3]);  
			%----
			r3 = sub_real_matrix(3, :) .* [-1 -1 1 1];
			r3 = r3([3 4 1 2]);  
			%----
			r4 = sub_real_matrix(4, :) .* [1 -1 -1 1];
			r4 = r4([4 3 2 1]);

			assert(max([norm(r1 - r2), norm(r1 - r3), norm(r1 - r4)] ) < 1e-6);
			
			qmatrix(i, j) = quaternion(r1);

			% qmatrix(i, j) =  realmatrix2qscalar(realmatrix(row_index1: row_index2, col_index1: col_index2) );   
		end
	end

end%function qmatrix = realmatrix2qmatrix(realmatrix)
