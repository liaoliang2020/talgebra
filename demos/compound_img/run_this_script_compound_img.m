function run_this_script_compound_img
	% This demo shows how to get higher-order compound image(s) from a legacy grey image
	% Let's take the "cameraman" image for example. 

	clear; close all; clc;
	
	row_num = 256;
	col_num = 256;

	basic_tsize = [3, 3];
	
	%-----------------------------
	% if there exist no pixel neighborhood information table, uncomment the following lines of code.
	%% mode = 'central';    %Get central neighborhood
	%mode = 'inception';	%Get inception neighborhood
	%file_path = pwd; 		%file path where neighborhood files are stored
	%layer_num = 2;			%number of neighorhood files. 
	%get_pixel_central_inception_neighborhood4_2Darray(row_num, col_num, mode, file_path, layer_num)
	

	canonical_img = imread('cameraman.tif');
	whos canonical_img;
	assert(isequal(size(canonical_img), [row_num, col_num]) );
	
	canonical_img_vectorized = [canonical_img(:); uint8(0)];
	
	file_path = pwd; 

	%----The shape of compound image is 3*3*256*256--------------------
	neighorhood_table = load_data(file_path, 'inception_neighorhood_layer001_single_index');
	% whos neighorhood_table;

	tsize = basic_tsize;
	assert(isequal(size(neighorhood_table), [1, prod([tsize, row_num, col_num]) ] ));

	compound_img_layer001 = canonical_img_vectorized(neighorhood_table);
	compound_img_layer001 = reshape(compound_img_layer001, [tsize, row_num, col_num]);
	whos compound_img_layer001;

	fprintf('\n The shape of compound image compound_img_layer001 is \n'), disp(size(compound_img_layer001) );

	save_data(pwd, 'compound_img_layer001', 'compound_img_layer001');

	%----The shape of a higher-order compound image is 3*3*3*3*256*256--------------------

	neighorhood_table = load_data(file_path, 'inception_neighorhood_layer002_single_index');
	% whos neighorhood_table;

	layer_num = 2;
	tsize = repmat(basic_tsize, 1, layer_num);
	assert(isequal(size(neighorhood_table), [1, prod([tsize, row_num, col_num]) ] ));

	compound_img_layer002 = canonical_img_vectorized(neighorhood_table);
	compound_img_layer002 = reshape(compound_img_layer002, [tsize, row_num, col_num]);
	whos compound_img_layer002;

	fprintf('\n The shape of compound image compound_img_layer002 is \n'), disp(size(compound_img_layer002) );

	save_data(pwd, 'compound_img_layer002', 'compound_img_layer002');

end