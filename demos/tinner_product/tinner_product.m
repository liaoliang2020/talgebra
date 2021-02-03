function tinner_product
	clear; close all; clc;
	tsize = [3, 3];
	row_col_num = 7;

	A = randn([tsize, row_col_num, row_col_num]) + i * randn([tsize, row_col_num, row_col_num]);
	B = randn([tsize, row_col_num, row_col_num]) + i * randn([tsize, row_col_num, row_col_num]);

	generalized_innner_product001 = tmultiplication(A, tctranspose(B, tsize), tsize);
	generalized_innner_product001 = ttrace(generalized_innner_product001, tsize);
	generalized_innner_product001 = tconj(generalized_innner_product001, tsize);

	generalized_innner_product002 = tmultiplication(tctranspose(A, tsize), B, tsize);
	generalized_innner_product002 = ttrace(generalized_innner_product002, tsize);
		


	A = treshape(A, [1, row_col_num * row_col_num], tsize);
	B = treshape(B, [1, row_col_num * row_col_num], tsize);
	generalized_innner_product000 = tdot(A, B, tsize);
	
	assert(isequal(round(generalized_innner_product001, 4), round(generalized_innner_product000, 4)));
	assert(isequal(round(generalized_innner_product002, 4), round(generalized_innner_product000, 4)));

	fprintf('All asserts in this scripted are passed.\n');

	
end