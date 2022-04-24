function pure_quaternion_unit = qpure(ijk)
	assert(ijk == 'i' || ijk == 'j' || ijk == 'k');

	switch ijk
		case 'i'
			pure_quaternion_unit = quaternion([0 1 0 0]);
		case 'j'
			pure_quaternion_unit = quaternion([0 0 1 0]);
		case 'k'
			pure_quaternion_unit = quaternion([0 0 0 1]);
		otherwise
			assert(false);
	end

	
end