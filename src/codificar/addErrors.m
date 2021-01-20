%% addErrors: Adds errors
function [output_vector, number_of_errors] = addErrors(input_vector, probability, input_size)
    number_of_errors = probability * input_size;
    % randperm to avoid repetitions
	error_locations = randperm(input_size, number_of_errors);
	output_vector = input_vector;
	output_vector(error_locations) = not(input_vector(error_locations));
end
