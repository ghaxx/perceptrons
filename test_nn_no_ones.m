function [R r E]= test_nn_no_ones(net, S, T)
	size_S = size(S);
	size_w = size(net.w);
	last = size(net.w{size_w(2)});
	R = zeros( last(2), size_S(2));
	r = 0;
	E = 0;
	for i=1 : size_S(2)
		size_w = size(net.w);
		V = S(:,i)';
		Y = S(:,i)';

		for j=1: size_w(2)
			V = Y * net.w{j};
			Y = logistic(V, net.alpha);
		end
		if(answer_real(Y') == T(:,  i))
			r = r + 1;
		end
		ek = T(:, i)' - Y;
		E = E + sum(ek .* ek) / 2;
%   		R(:, i) = answer_real(Y');
		R(:, i) = Y';
	end
	r = 1 - r / size_S(2);
	E = E / size_S(2);
end
%----------------------------------------------------