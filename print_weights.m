function print_weights(net, iteration, r, E, P, T, args, use_ones)
	if mod(iteration-1, args(1)) == 0
		fprintf('Network weights for energy %.7f:\n', E);
		fprintf('%.3f \t %.3f \t |%.3f \n%.3f \t %.3f \t |%.3f \n', net.w{1}(1, 1), net.w{1}(1, 2), net.w{2}(1, 1), net.w{1}(2, 1), net.w{1}(2, 2), net.w{2}(2, 1));
	end
end