function double_array = quaternion_part(quaternion_array, part_index)
	assert(isequal(class(quaternion_array), 'quaternion'));
	assert(ismember(part_index, 1: 4));

	result = compact(quaternion_array);
	result = result(:, part_index);

	double_array = reshape(result, size(quaternion_array));
	
end