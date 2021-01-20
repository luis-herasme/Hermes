% %% createDataSet: Creates random binary dataset
% function [dataset] = createDataSet(tamano)
% 	dataset = randi([0, 1], 1, tamano);
% end

hamming_input_probabilities  = [0.4 0.2 0.1 0.05 0.01 0.005 0.001];
hamming_output_probabilities = hammingProbabilities(10**5, hamming_input_probabilities);

hamming_input_probabilities	 = flip(hamming_input_probabilities);
hamming_output_probabilities = flip(hamming_output_probabilities);

plot(hamming_input_probabilities, hamming_output_probabilities);
xlabel('Input Probabilities');
ylabel('Output Probabilities');
hold on;
