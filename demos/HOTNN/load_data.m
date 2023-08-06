function data = load_data(path, data_name)
	assert(ischar(path) & ischar(data_name));
	file_name_full = sprintf('%s\\%s', path, data_name);
	data = load(file_name_full);
	data = struct2cell(data);
	data = data{1};
	
end