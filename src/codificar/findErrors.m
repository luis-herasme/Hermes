%% findErrors: Returns an array with ones where errors occured
function [error_array, error_lengths] = findErrors(input_vector, output_vector)
	error_array = (output_vector != input_vector);

    % indices where the pattern changes
    t1 = find(diff(error_array));

    % pattern lengths
	t2 = [t1 numel(error_array)] - [0 t1];

	error_lengths = [];

    % Then odd rows of t2 are non errors. drop them.
    if error_array(1) == 0
        % even elements
		error_lengths = t2'(2: 2: end, :)';
    else
        % odd elements
		error_lengths = t2'(1: 2: end, :)';
	end
end