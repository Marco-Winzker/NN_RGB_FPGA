%==========================================================================
%
%   Author: Thomas Florkowski
%   Version: 10.08.2020
%
%==========================================================================

function positions = generatePositionsMatrix(structure) 
%This function generates a String with the positions of the weights in the
%1D Array.
%It needs the Structure of the neural network


%Create matrix with positions.
    matrix = zeros(max(structure)+1,length(structure)-1);
    counter = 0;
    for i = 1 : size(matrix,2)
        for j = 1 : structure(i+1)+1
            matrix(j,i)= counter;
            if j<=structure(i+1)
            counter = counter + structure(i) +1;
            end
        end 
    end
    
    %Generate a string for the config file out of the matrix
    stringPositions = "";
    for i = 1 : size(matrix,1)
        temp = sprintf('%d,' , matrix(i,:));
        temp = temp(1:end-1);%Remove last comma
        
        %\t adds a tabular space for the optic
        stringPositions = sprintf('%s\t\t\t\t(%s),\n',stringPositions,temp);

        
    end
    %return string
    positions= stringPositions(1:end-2);
end
