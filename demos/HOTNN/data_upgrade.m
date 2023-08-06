
	clear; close all; clc;
	
    row_num = 321;
	col_num = 481;
	fra_num = 3;
    tsize = [3 3  ]; 
    
    current_dir = pwd;
	data_dir = sprintf('%s\\%s', current_dir, 'data');
    save_dir = sprintf('%s\\%s', current_dir, 'result');
    
    haixing = double(imread('testimg.jpg'));
    assert(isequal(size(haixing), [row_num, col_num, fra_num]));
    [n1,n2,n3] = size(haixing);
     
    p = 0.3;% sampling rate
    
    omega = find(rand(n1*n2*n3,1)<p);
    M = zeros(n1,n2,n3);
    M(omega) = haixing(omega);
    
    neighborhood = load_data(data_dir, 'row_num00321_col_num00481_central_neighorhood_layer001_single_index'); 
    assert(numel(neighborhood) == prod([tsize, row_num, col_num])); 

    M = reshape(M, [row_num * col_num, fra_num] );
    M_extended = [];
    
	for i = 1: fra_num 
        
 		%disp(i);
		image_this_frame = M(:, i);
        image_this_frame = [image_this_frame(:); 0];
        image_this_frame = image_this_frame(neighborhood);
        M_extended = [M_extended, image_this_frame(:)];
      
    end 
    
    assert(isequal(size(M_extended), [prod(tsize) * row_num * col_num , fra_num]  ));
    save_data(data_dir, 'testimg_extended_less', 'M_extended ');
     
