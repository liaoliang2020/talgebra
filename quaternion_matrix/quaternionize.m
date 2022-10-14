function quaternion_array = quaternionize(numerical_array)
	% This function uplifts a complex array to a quaternion array

	assert(isequal(class(numerical_array), 'double') );
	quaternion_array = quaternion([real(numerical_array(:)), imag(numerical_array(:)), zeros(numel(numerical_array), 2) ]); 
	quaternion_array = reshape(quaternion_array, size(numerical_array));

end