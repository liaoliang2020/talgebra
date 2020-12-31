function save_data(path, file_name, data_name)
	assert(ischar(path) & ischar(file_name) & ischar(data_name));
	
	
	if ~exist(path, 'dir')
		command = sprintf('mkdir %s', path);
        eval(command);
        disp(command);
	end
	
	
	file_name_full = sprintf('%s\\%s', path, file_name);
	command = sprintf('save %s %s -v7.3;', file_name_full, data_name);
	evalin('caller', command);
	disp(command);

end