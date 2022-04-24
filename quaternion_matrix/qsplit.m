function [q_positve, q_negative] = qsplit(quaternion_scalar)
	assert(isequal(class(quaternion_scalar), 'quaternion'));
	assert(numel(quaternion_scalar) == 1);

	second_part = qpure('i') * quaternion_scalar * qpure('i');
	q_positve =  0.5 * (quaternion_scalar + second_part);
	q_negative = 0.5 * (quaternion_scalar - second_part);

	% q_compact = compact(quaternion_scalar);
	% q_r = q_compact(1);
	% q_i = q_compact(2);
	% q_j = q_compact(3);
	% q_k = q_compact(4);

	% liaoliang1 = (q_r + q_k +  qpure('i') * (q_i - q_j)) * (1 + qpure('k')) * 0.5
	




end