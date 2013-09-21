function energy_for_2D(net, iteration, r, E, P, T, args, use_ones) 
	hold on;
	min_x = args(1);
	max_x = args(2);
	t_size = args(3);
	if(iteration == 1)
		x = min_x:(max_x-min_x)/(t_size-1):max_x;
		y = min_x:(max_x-min_x)/(t_size-1):max_x;
		Z = zeros(size(x, 2), size(y, 2));
		for iter_P1=1:size(x, 2)
			for iter_P2=1:size(y, 2)	
				tmp_net = net;
				tmp_net.w{1} = [x(iter_P1) y(iter_P2)]';
				if use_ones == 1
					[a1 a2 a3]= test_nn(tmp_net, P, T);
				else
					[a1 a2 a3]= test_nn_no_ones(tmp_net, P, T);
				end
				Z(iter_P1, iter_P2) = a3;
			end
		end
		axis([min(x) max(x) min(y) max(y) 0 1]);
		mesh(x, y, Z);
	end
	plot3(net.w{1}(1, 1), net.w{1}(2, 1), E, '.-k');
	fprintf('%d: r = %.2f, E = %.5f\n', iteration, r, E);
	drawnow;
end