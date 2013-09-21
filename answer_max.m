function A = answer_max(X)
	size_X = size(X);
	max = 1;
	A = zeros(size_X(1), 1);
	for i=2 : size_X(1)
		if( X(i) > X(max) )
			max = i;
		end
	end
	A(max) = 1;
end