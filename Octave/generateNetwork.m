%==========================================================================
%
%   Author: Thomas Florkowski 
%   Version: 08.08.2020
%
%==========================================================================
%GENERATENETWORK Generates the weight matrices for the neural network and
%fills them with random numbers
%   A = GENERATENETWORK(structure) generates the matrices for the given
%   structure vector
%   %[3 3 1] means for example:
%   - Input layer has three neurons
%   - One hidden layer with 3 neurons
%   - The output layer has three neurons



function[network] = generateNetwork(structure)
    numberOfLayer = length(structure);
    numberOfThetas = numberOfLayer -1; %Number of matrices between the Layer
    offset = 1; %Add Bias/Offset
    
    theta{numberOfThetas} = {}; %Initialize the array for matrices that connect the Layer
    
    %Create and fill the weight matrices with Random numbers
    for i = 1:numberOfThetas
        %Add here Code to specifie the random  values for the weight
        %matrices Range:-0.5 to 0.5
        theta{i} = rand(structure(i+1)+offset,structure(i)+offset)-0.5;
    end
    
    %Remove the offset from the last (output) layer
    theta{numberOfThetas}(end,:) = []; 
    
    network = theta;
end