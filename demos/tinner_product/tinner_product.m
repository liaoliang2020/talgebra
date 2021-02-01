function tinner_product
	tsize = [3, 3];
	row_col_num = 7;

	A = randn([tsize, row_col_num, row_col_num]) + i * randn([tsize, row_col_num, row_col_num]);
	B = randn([tsize, row_col_num, row_col_num]) + i * randn([tsize, row_col_num, row_col_num]);

	generalized_innner_product = tmultiplication(A, tctranspose(B, tsize), tsize);
	generalized_innner_product = ttrace(generalized_innner_product, tsize);

	generalized_innner_product = tconj(generalized_innner_product, tsize);

	A = treshape(A, [1, row_col_num * row_col_num], tsize);
	B = treshape(B, [1, row_col_num * row_col_num], tsize);
	

	generalized_innner_product2 = tdot(A, B, tsize);
	assert(isequal(round(generalized_innner_product, 4), round(generalized_innner_product2, 4)));



end