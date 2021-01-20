%% createDataSet: Creates random binary dataset
function [dataset] = createDataSet(tamano)
	dataset = randi([0, 1], 1, tamano);
end