function code001_data_upgrade
	clear; close all; clc;

	row_num = 321;
	col_num = 481;
	fra_num = 3;
    neighborhood_size = [3, 3]; 

    current_dir = pwd;
	data_dir = sprintf('%s\\%s', current_dir, 'data');
    save_dir = sprintf('%s\\%s', current_dir, 'result');

    file_name_with_path = sprintf('%s\\%s', data_dir, 'testimg.jpg');
	test_img = double(imread(file_name_with_path));
	
	assert(isequal(size(test_img), [row_num, col_num, fra_num] ));
	assert(all(reshape(test_img >= 0, [], 1)));

	
	missing_entry_percentage = 0.7;
	p = 1 - missing_entry_percentage;	%sampling rate

	omega = find(rand(row_num * col_num * fra_num, 1) < p);
	M = ones(row_num, col_num, fra_num) * (-1);
	M(omega) = test_img(omega);
	
	%imshow(uint8(M));

	neighborhood = load_data(data_dir, 'row_num00321_col_num00481_central_neighorhood_layer001_single_index'); 
	assert(isequal(size(neighborhood), [1, prod([neighborhood_size, row_num, col_num])])); 

	M = reshape(M, [row_num * col_num, fra_num] );
    M_extended = [];
    
    for i = 1: fra_num 
        image_this_frame = M(:, i);
        image_this_frame = [image_this_frame(:); 0];
        image_this_frame = image_this_frame(neighborhood);
        M_extended = [M_extended, image_this_frame(:)];

    end

    assert(isequal(size(M_extended), [prod(neighborhood_size) * row_num * col_num, fra_num]  ));

    M_extended = permute(M_extended, [2, 1]);
    M_extended = reshape(M_extended, [fra_num, neighborhood_size, row_num, col_num]);

    save_data(data_dir, 'higher_order_testimg_with_missing_entries', 'M_extended');

end
