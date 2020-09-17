%==========================================================================
%
%   Author: Thomas Florkowski 
%   Version: 10.08.2020
%
%==========================================================================
%TRAINNETWORK Trains a network
%   @Input  
%   X: Data for training
%   y: Labels for X
%   network: Network that should be trained
%   varargin:
%       'epochs'    Number of epochs you want to train
%       'alpha'     Alpha you want to use for training
%       'validationData'        Validation dataset
%       'validationDataOutput'  Labels for the validation dataset
%
%
%   @Output
%   trainedNetwork:      
%   cost_log: Vector with the cost after each epoch
%   trainingSetAccuracy: Vector with the accuracy of the network after each epoch
%   validationSetAccuracy: Vector with the accuracy of the valdidation dataset (if given) after each epoch
%


function[trainedNetwork, cost_log, trainingSetAccuracy, validationSetAccuracy] = trainNetwork(X, y, network, varargin)
    %default parameter
    defaultEpochs=100;
    defaultAlpha=0.01;
    defaultValidationData=[];
    defaultValidationOutput=[];
    
    %Input Parser
    p = inputParser;
    p.FunctionName = 'trainNetwork';
    addParameter(p,'epochs',defaultEpochs,@(x)validateattributes_with_return_value(x,{'numeric'},{'nonempty'}));
    addParameter(p,'alpha',defaultAlpha,@(x)validateattributes_with_return_value(x,{'numeric'},{'nonempty'}));
    addParameter(p,'validationData',defaultValidationData);
    addParameter(p,'validationDataOutput',defaultValidationOutput);
    p.parse(varargin{:});
    
    %Assign parsed input to the variables
    epochs = p.Results.epochs;
    alpha = p.Results.alpha;
    validationData = p.Results.validationData;
    validationOutput = p.Results.validationDataOutput;
    
    %Only do a validation if the user inserts a validation dataset with the
    %expected results
    doValidation = ~isempty(validationData) && ~isempty(validationOutput);
    
    

    theta = network;
    
    %number of weight matrices and layers
    numberOfThetas = length(theta);
    numberOfLayers = numberOfThetas +1;
    
    %matrices for the Output of each Layer
    
    layer=cell(1,numberOfLayers);
    
    
    m=size(X,1);
    cost_log=zeros(epochs,1);
    trainingSetAccuracy=zeros(epochs,1);
    validationSetAccuracy=zeros(epochs,1);

    
    
    %assign the transposed input to the input layer
    layer{1} = X'; 
    %Add offset to the first layer (input layer)
    layer{1}=[layer{1}; ones(1,size(layer{1},2))];


    
    
    
    
    %loop the carry out gradient descent iter times
    for i=1:epochs
        fprintf("Epoch %d/%d\r",i,epochs);
        %forward propagation to calculate output using sigmoid function
        for j=1:numberOfThetas
            %By the forward calculation the offset neuron gets inserted into the activation function. This needs to be reveresed before the next layer is calculated
            layer{j}(end,:)=1; 
            layer{j+1} = sigmoid(theta{j} * layer{j});
        end

        
        
        %back propagation to calculate error
        error=cell(1,numberOfLayers);
        error{numberOfLayers} = layer{numberOfLayers} - y'; %The error for the last layer is calculated outside of the for loop
       
        for j=numberOfThetas: -1 :2
            error{j} = theta{j}' * error {j+1};
        end

        
        %Substract partial derivatives from theta
        for j=1:numberOfThetas
            theta{j} = theta{j} - alpha * ((error{j+1} .* layer{j+1} .* (1-layer{j+1})) * layer{j}');
        end

        %Calculate Mean Square Error for each iteration
        %Double sum because sum of a matrix creates a vektor and sum of a
        %vektor creates a double value.
        cost = 1/m * sum(sum(error{numberOfLayers}.^2));
        cost_log(i)=cost;
        
        %Calculate the accuracy of the trainings set
        trainingSetAccuracy(i)=calculateAccuracy(layer{numberOfLayers}, y');
        
        if(doValidation)
            prediction=networkPrediction(validationData, theta);
            validationSetAccuracy(i)=calculateAccuracy(prediction, validationOutput');
        end
        
    end
    
    trainedNetwork = theta;
end