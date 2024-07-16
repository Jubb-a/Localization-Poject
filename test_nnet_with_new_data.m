function [indexguess, error, distance]= test_nnet_with_new_data(newMasks,TrueLocationNewMasks,NewMasksTrueIndex, AllPossibleMaskLocations)


if ~ischar(testdata)

    error('testdata input must be a string.');

end
if ~ischar(testlocation)

    error('testlocation input must be a string.');

end

% Load and treat network testing data 
Testmasks= csvread(newMasks);
Truelocation=csvread(TrueLocationNewMasks);
Trueindex=csvread(NewMasksTrueIndex);
Allpossiblemasklocations= csvread(AllPossibleMaskLocations)
testdata=mat2cell(newMasks);
sequences=testdata;


%% Network Test
%load network
load network.mat
networktest= network;

%Output predicted locations from network and convert them to numerical
%vector
[Y,scores]=classify(networktest,sequences);
indexguess=double(string(Y));

%Use indices from network output to find true location value and calculate
%mse and distance between two points
xhat=zeros(size(indexguess));
yhat=zeros(size(indexguess));
for i=1:length(indexguess)
    for j=1:length(Truelocation)
        if indexguess(i) == j
        xhat(i)= Truelocation(j,1);
        yhat(i)= Truelocation(j,2);
        end
    end
end
estimatedlocation=[xhat, yhat];
trueval=TrueLocationNewMasks;
error=mse(estimatedlocation,trueval);
[distance]=sqrt((((estimatedlocation(:,1)-trueval(:,1)).^2)+(((estimatedlocation(:,2)-trueval(:,2))).^2)));

%Plot true index vs predicted index and display mse
clf;
figure(1)
histogram(distance);
title('Histogram of Distance Between Predicted and Actual Locations for Noisy Data')
xlabel('Distance Between Coordinates')
ylabel('Frequency')