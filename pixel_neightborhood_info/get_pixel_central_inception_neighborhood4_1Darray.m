function get_pixel_central_inception_neighborhood4_1Darray(mylength, mode, file_path, layer_num)
	% this function creates the pixel neighborhood table and store the table to sompelace specified by argument path


	
	if nargin == 3
		layer_num = 1;
	end  

	assert(mylength >= 1);
	assert(isequal(mode, 'central') | isequal(mode, 'inception'));
	assert(ismember(layer_num, [1, 2, 3]));
	assert(isa(file_path, 'char') );
	
	save_dir =  file_path;

	if isequal(mode, 'central')
		delta_pool = [-1, 0, 1];
	else
		assert(isequal(mode, 'inception'));	
		delta_pool = [0, 1, 2];
	end


	
	if ~exist(save_dir, 'dir')
		comand = sprintf('mkdir %s', save_dir);
		eval(comand);
		disp(comand);
    end
	
	

    tsize = [3];
	
	neighorhood_layer001 = zeros(1, prod(tsize), mylength );								neighorhood_layer001 = int64(neighorhood_layer001);
	neighorhood_layer002 = zeros(1, prod([tsize, tsize]), mylength );						neighorhood_layer002 = int64(neighorhood_layer002);
	neighorhood_layer003 = zeros(1, prod([tsize, tsize, tsize]), mylength );				neighorhood_layer003 = int64(neighorhood_layer003);

	neighorhood_layer001_single_index = zeros(1, prod(tsize) *  mylength );					neighorhood_layer001_single_index = uint64(neighorhood_layer001_single_index);
	neighorhood_layer002_single_index = zeros(1, prod([tsize, tsize]) * mylength );			neighorhood_layer002_single_index = uint64(neighorhood_layer002_single_index);
	neighorhood_layer003_single_index = zeros(1, prod([tsize, tsize, tsize]) * mylength );	neighorhood_layer003_single_index = uint64(neighorhood_layer003_single_index);
	
	%----------------
	% first layer
	
	linear_index = 0;
	for i = 1: mylength
		fprintf('layer = %d \t index = %d \n', 1, i);

		x = i;
		
		index = 0;		
		for delta1 = delta_pool
			index = index + 1;
			neighorhood_layer001(:, index, i) = [x] + [delta1];	
				
			%----------------------
			if ismember(neighorhood_layer001(:, index, i), 1: mylength)  
				ind = neighorhood_layer001(:, index, i); 
			else
				ind =  mylength + 1;
			end

			linear_index = linear_index + 1;
			neighorhood_layer001_single_index(linear_index) = ind;

		end%for delta1 = delta_pool
		
	end


	
	if isequal(mode, 'central')
		file_name = sprintf('mylength_%05d_central_neighorhood_layer001_single_index', mylength);
		save_data(save_dir, file_name, 'neighorhood_layer001_single_index');
	else 
		assert(isequal(mode, 'inception'));
		
		file_name = sprintf('mylength_%05d_inception_neighorhood_layer001_single_index', mylength);
		save_data(save_dir, file_name, 'neighorhood_layer001_single_index');
	end

	
	if layer_num == 1
		return;
	end

	
	%--------------------
	% second layer
	neighorhood_layer001 = reshape(neighorhood_layer001, 1, []);
	neighorhood_layer002 = reshape(neighorhood_layer002, 1, []);
	index = 0;
	for i = 1: size(neighorhood_layer001, 2)
		fprintf('layer = %d \t index = %d \n', 2, i);

		for delta1 = delta_pool
			index = index + 1;
			neighorhood_layer002(:, index) = double(neighorhood_layer001(:, i)) + [delta1];	
			%----------------------
			if ismember(neighorhood_layer002(:, index), 1: mylength) 
				ind = neighorhood_layer002(:, index); 
			else
				ind =  mylength + 1;
			end

			neighorhood_layer002_single_index(index) = ind;

		end%for delta1 = delta_pool
		
	end

	neighorhood_layer002 = reshape(neighorhood_layer002, 1, prod([tsize, tsize]), mylength);
	
	if isequal(mode, 'central')
		file_name = sprintf('mylength_%05d_central_neighorhood_layer002_single_index', mylength);
		save_data(save_dir, file_name, 'neighorhood_layer002_single_index');
	else 
		assert(isequal(mode, 'inception'));
		
		file_name = sprintf('mylength_%05d_inception_neighorhood_layer002_single_index', mylength);
		save_data(save_dir, file_name, 'neighorhood_layer002_single_index');
	end

	if layer_num == 2
		return;
	end


	%------------------
	% third layer	
	neighorhood_layer002 = reshape(neighorhood_layer002, 1, []);
	neighorhood_layer003 = reshape(neighorhood_layer003, 1, []);
	index = 0;
	for i = 1: size(neighorhood_layer002, 2)
		
		fprintf('layer = %d \t index = %d \n', 3, i);
		
		for delta1 = delta_pool
			index = index + 1;
			neighorhood_layer003(:, index) = double(neighorhood_layer002(:, i)) + [delta1];	

			%---------------------
			if ismember(neighorhood_layer003(1, index), 1: mylength) 
				ind = neighorhood_layer003(1, index); 
			else
				ind =  mylength + 1;
			end

			neighorhood_layer003_single_index(index) = ind;			

		end%for delta1 = delta_pool
		
	end

	neighorhood_layer003 = reshape(neighorhood_layer003, 1, prod([tsize, tsize, tsize]), mylength);
	

	if isequal(mode, 'central')
		file_name = sprintf('mylength_%05d_central_neighorhood_layer003_single_index', mylength);
		save_data(save_dir, file_name, 'neighorhood_layer003_single_index');	
	else 
		assert(isequal(mode, 'inception'));
		file_name = sprintf('mylength_%05d_inception_neighorhood_layer003_single_index', mylength);
		save_data(save_dir, file_name, 'neighorhood_layer003_single_index');
	end


end