function get_pixel_central_inception_neighborhood(row_num, col_num, mode, file_path, layer_num)
	% this function creates the pixel neighborhood table and store the table to sompelace specified by argument path

	if nargin == 4
		layer_num = 1;
	end  

	assert(isequal(mode, 'central') | isequal(mode, 'inception'));
	assert(ismember(layer_num, [1, 2, 3]));
	assert(isa(file_path, 'char') );
	
	save_dir =  file_path;

	if isequal(mode, 'central')
		% save_dir = sprintf('%s\\%s_%dx%d', pwd, 'central_neighorhood', row_num, col_num);
		delta_pool = [-1, 0, 1];
	else
		assert(isequal(mode, 'inception'));	
		% save_dir = sprintf('%s\\%s_%dx%d', pwd, 'inception_neighorhood', row_num, col_num);
		delta_pool = [0, 1, 2];
	end


	
	if ~exist(save_dir, 'dir')
		comand = sprintf('mkdir %s', save_dir);
		eval(comand);
		disp(comand);
    end
	
	

    tsize = [3, 3];
	


	neighorhood_layer001 = zeros(2, prod(tsize), prod([row_num, col_num]) );								neighorhood_layer001 = int64(neighorhood_layer001);
	neighorhood_layer002 = zeros(2, prod([tsize, tsize]), prod([row_num, col_num]) );						neighorhood_layer002 = int64(neighorhood_layer002);
	neighorhood_layer003 = zeros(2, prod([tsize, tsize, tsize]), prod([row_num, col_num]) );				neighorhood_layer003 = int64(neighorhood_layer003);

	neighorhood_layer001_single_index = zeros(1, prod(tsize) *  prod([row_num, col_num]) );					neighorhood_layer001_single_index = uint64(neighorhood_layer001_single_index);
	neighorhood_layer002_single_index = zeros(1, prod([tsize, tsize]) * prod([row_num, col_num]) );			neighorhood_layer002_single_index = uint64(neighorhood_layer002_single_index);
	neighorhood_layer003_single_index = zeros(1, prod([tsize, tsize, tsize]) * prod([row_num, col_num]) );	neighorhood_layer003_single_index = uint64(neighorhood_layer003_single_index);
	
	%----------------
	% first layer
	linear_index = 0;
	for i = 1: prod([row_num, col_num])
		
		
		fprintf('layer = %d \t index = %d \n', 1, i);

		[x, y] = ind2sub([row_num, col_num], i);
		index = 0;
		for delta2 = delta_pool
			for delta1 = delta_pool
				index = index + 1;
				neighorhood_layer001(:, index, i) = [x; y] + [delta1;  delta2];	
				
				%----------------------
				if ismember(neighorhood_layer001(1, index, i), 1: row_num) & ismember(neighorhood_layer001(2, index, i), 1: col_num) 
					ind = sub2ind([row_num, col_num], neighorhood_layer001(1, index, i), neighorhood_layer001(2, index, i)); 
				else
					ind =  row_num * col_num + 1;
				end

				linear_index = linear_index + 1;
				neighorhood_layer001_single_index(linear_index) = ind;



			end%for delta1 = delta_pool
		end%for delta2 = delta_pool
	end


	
	if isequal(mode, 'central')
		%save_data(save_dir, 'central_neighorhood_layer001', 'neighorhood_layer001');
		save_data(save_dir, 'central_neighorhood_layer001_single_index', 'neighorhood_layer001_single_index');
	else 
		assert(isequal(mode, 'inception'));
		%save_data(save_dir, 'inception_neighorhood_layer001', 'neighorhood_layer001');
		save_data(save_dir, 'inception_neighorhood_layer001_single_index', 'neighorhood_layer001_single_index');
	end

	if layer_num == 1
		return;
	end


	%--------------------
	% second layer
	neighorhood_layer001 = reshape(neighorhood_layer001, 2, []);
	neighorhood_layer002 = reshape(neighorhood_layer002, 2, []);
	index = 0;
	for i = 1: size(neighorhood_layer001, 2)
		% [x; y] = neighorhood_layer001(:, i)
		
		fprintf('layer = %d \t index = %d \n', 2, i);


		for delta2 = delta_pool
			for delta1 = delta_pool
				index = index + 1;
				neighorhood_layer002(:, index) = double(neighorhood_layer001(:, i)) + [delta1; delta2];	
				%----------------------
				if ismember(neighorhood_layer002(1, index), 1: row_num) & ismember(neighorhood_layer002(2, index), 1: col_num) 
					ind = sub2ind([row_num, col_num], neighorhood_layer002(1, index), neighorhood_layer002(2, index)); 
				else
					ind =  row_num * col_num + 1;
				end

				neighorhood_layer002_single_index(index) = ind;


			end
		end
	end

	neighorhood_layer002 = reshape(neighorhood_layer002, 2, prod([tsize, tsize]), prod([row_num, col_num]));
	
	if isequal(mode, 'central')
		%save_data(save_dir, 'central_neighorhood_layer002', 'neighorhood_layer002');
		save_data(save_dir, 'central_neighorhood_layer002_single_index', 'neighorhood_layer002_single_index');
	else 
		assert(isequal(mode, 'inception'));
		%save_data(save_dir, 'inception_neighorhood_layer002', 'neighorhood_layer002');
		save_data(save_dir, 'inception_neighorhood_layer002_single_index', 'neighorhood_layer002_single_index');
	end

	if layer_num == 2
		return;
	end


	%------------------
	% third layer	
	neighorhood_layer002 = reshape(neighorhood_layer002, 2, []);
	neighorhood_layer003 = reshape(neighorhood_layer003, 2, []);
	index = 0;
	for i = 1: size(neighorhood_layer002, 2)
		% [x; y] = neighorhood_layer002(:, i)
		

		fprintf('layer = %d \t index = %d \n', 3, i);
		for delta2 = [-1, 0, 1]
			for delta1 = [-1, 0, 1]
				index = index + 1;
				neighorhood_layer003(:, index) = double(neighorhood_layer002(:, i)) + [delta1; delta2];	

				%---------------------
				if ismember(neighorhood_layer003(1, index), 1: row_num) & ismember(neighorhood_layer003(2, index), 1: col_num) 
					ind = sub2ind([row_num, col_num], neighorhood_layer003(1, index), neighorhood_layer003(2, index)); 
				else
					ind =  row_num * col_num + 1;
				end

				neighorhood_layer003_single_index(index) = ind;
			

			end
		end
	end

	neighorhood_layer003 = reshape(neighorhood_layer003, 2, prod([tsize, tsize, tsize]), prod([row_num, col_num]));
	

	if isequal(mode, 'central')
		%save_data(save_dir, 'central_neighorhood_layer003', 'neighorhood_layer003');
		save_data(save_dir, 'central_neighorhood_layer003_single_index', 'neighorhood_layer003_single_index');	
	else 
		assert(isequal(mode, 'inception'));
		%save_data(save_dir, 'inception_neighorhood_layer003', 'neighorhood_layer003');
		save_data(save_dir, 'inception_neighorhood_layer003_single_index', 'neighorhood_layer003_single_index');
	end


end