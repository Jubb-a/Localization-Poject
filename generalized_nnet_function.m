%Neural network builder

%%%%%% PLEASE READ  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function returns a network object. Network object name is preset so
% either change the network name before running again 
% or complete all necessary analysis before running because the network 
% will be overwritten with each function call.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function network = generalized_nnet_function(testdata,testlocation, numberofcategories) 

if ~ischar(testdata)

    error('testdata input must be a string.');

end
if ~ischar(testlocation)

    error('testlocation input must be a string.');

end

maskdata=csvread(testdata);              % read mask data into variable
locationdata=csvread(testlocation);       % read mask location data into variable

numchannel = 1;                                       % set numchannels as number of inputs 
numObs = size(maskdata,1);                            % This will provide how many masks we have in the data set
Naz = size(maskdata,2);                               % Number of azimuthal angles

Ntrain = length(maskdata); 

te = cell(Ntrain,1);                                  % create empty cell object 
for tN=1:Ntrain                                       % for loop for converting azimuth array into cell object
    te{tN}=maskdata(tN,:);
end
XTrain=te;                                            % Assign cell object as training data for network training                                                     

% Assign training data labels
se = cell(Ntrain,1);                                  % create empty cell object
for i = 1:Ntrain                                      % for loop to convert training labels into cell object 
    se{i} = locationdata(i,:); 
end 

TTrain = categorical(string(se));                     % turn training labels into categories for network training

numHiddenUnits1 = round((2/3)*Naz);
numHiddenUnits2 = round((2/3)*numHiddenUnits1);     

% Set the number of classes for training
if numberofcategories==1
    numClasses = round(sqrt(length(A)));                              % This is correlated to the number of pixels we have

    else 
        numClasses=numberofcategories;
end
layers = [ ...                                                    % Network structure                                                  
    sequenceInputLayer(numchannel)                                
    lstmLayer(numHiddenUnits1,'OutputMode','sequence')
    dropoutLayer(0.2)
    lstmLayer(numHiddenUnits2,'OutputMode',"last")
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer]

options = trainingOptions("adam", ExecutionEnvironment="gpu", ...                            % Network training options
    MaxEpochs=11, ... 
    InitialLearnRate=0.01,...
    Shuffle="every-epoch", ...
    GradientThreshold=1, ...
    Verbose=false, ...
    Plots='training-progress');

network = trainNetwork(XTrain,TTrain,layers,options);        

save network
end
