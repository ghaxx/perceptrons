function division_plane(net, iteration, r, E, P, T, args, use_ones)
	if mod(iteration-1, args(1)) == 0
		t_size = args(2);
		p = zeros(2, t_size^2);
		Z = zeros(t_size, t_size);
		x_min = args(3);
		x_max = args(4);
		x = x_min:(x_max-x_min)/(t_size-1):x_max;
		y = x_min:(x_max-x_min)/(t_size-1):x_max;
		for iter_P1=1:size(x, 2)
			for iter_P2=1:size(y, 2)	
				p(1, (iter_P1-1)*t_size+iter_P2) = x(iter_P1);
				p(2, (iter_P1-1)*t_size+iter_P2) = x(iter_P2);
			end
		end
		if use_ones == 1
			[R a2 a3]= test_nn(net, p, p(1, :));
		else
			[R a2 a3]= test_nn_no_ones(net, p, p(1, :));
		end
		for iter_P1=1:t_size
			for iter_P2=1:t_size
				Z(iter_P1, iter_P2) = R((iter_P1-1)*t_size+iter_P2);
			end
		end
		mesh(x, y, Z);
		axis([min(x) max(x) min(y) max(y) 0 1]);
		drawnow;
	 	fprintf('%d: r = %.2f, E = %.5f\n', iteration, r, E);
	end
end