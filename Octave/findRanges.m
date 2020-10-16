function [maxMultRange, maxSumRange] =findRanges(trainedNetwork)
%This function searches for the biggest possible sum inside a neuron
%and the greatest single input multiplication from the network 
%Max input value is into the input of a neuron is 255.
%The found ranges are round up to next power of 2.
greatestMultValue=0;
greatestSumValue = 0;

for i=1:length(trainedNetwork)
    for j=1:size(trainedNetwork{i},1)
        %Sum up all positiv and negativ weights seperatly (Bias is ignored)
        positivValues=sum(trainedNetwork{i}(j,trainedNetwork{i}(j,1:end-1)>0));
        negativValues=sum(trainedNetwork{i}(j,trainedNetwork{i}(j,1:end-1)<0));
        
        %Find the biggest weight
        maxWeight = max(abs(trainedNetwork{i}(j,1:end-1)));
        if(maxWeight>greatestMultValue)
           greatestMultValue =  maxWeight;
        end
        
        tempMax = positivValues * 255;
        tempMin = negativValues * 255;
        if trainedNetwork{i}(j,end)>0
            tempMax = tempMax + trainedNetwork{i}(j,end);
        else
            tempMin = tempMin + trainedNetwork{i}(j,end);
        end
        
        %For the rare case that the positiv number is equal to n to the power of 2
        %increase the tempMax by one
        %Because integer range is -2^n:2^n-1
        if(tempMax == 2^nextpow2(tempMax))
           tempMax = tempMax+1; 
        end

        if tempMax > greatestSumValue
            greatestSumValue = tempMax;
        end
        
        if abs(tempMin) > greatestSumValue
            greatestSumValue = abs(tempMin);
        end
    end
end 

greatestMultValue = greatestMultValue*255;
%For the rare case that the number is equal to n to the power of 2
%increase the tempMax by one
%Because integer range is -2^n:2^n-1
if(greatestMultValue == 2^nextpow2(greatestMultValue))
    greatestMultValue = greatestMultValue+1; 
end

maxSumRange = 2^nextpow2(greatestSumValue);
maxMultRange = 2^nextpow2(greatestMultValue);

end

