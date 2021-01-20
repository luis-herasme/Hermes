%% numberOfErrors: Returns number of errors
function [number] = numberOfErrors(input_data, decoded_data)
	number = sum(input_data != decoded_data);
end