function fid = myfopen(path, file_name)
	assert(ischar(path) & ischar(file_name));
	file_name_full = sprintf('%s\\%s', path, file_name);
	fid = fopen(file_name_full, 'a+');

end