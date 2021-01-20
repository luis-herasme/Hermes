%% hammingProbabilities: Returns output poe for hamming 7,4
function [poe] = hammingProbabilities(cantidad_de_datos, probabilities)
	poe = [];
	printf('\n');
	for probability = probabilities
		printf('Hamming (7,4). Input size = %d, probability of error = %f\n', cantidad_de_datos, probability);
		input_data         = createDataSet(cantidad_de_datos);
		transmitted_data   = sevenFourHammingEncode(input_data);
		received_data      = addErrors(transmitted_data, probability, cantidad_de_datos);
		decoded_data       = sevenFourHammingDecode(received_data);
		poe = [poe numberOfErrors(input_data, decoded_data) / cantidad_de_datos];
	end
end