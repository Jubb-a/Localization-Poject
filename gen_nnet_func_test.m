%%%%%%%%% HOW TO CALL NETWORK BUILDING FUNCTION %%%%%%
% generalized_nnet_function('mask.csv', 'location.csv', numberofclusters)
% numberofclusters =1 for non-clustered datasets, otherwise enter the
% number of clusters for the clustered dataset
% mask and location files must be in csv format with no variable headers in
% the csv files. If file is not readable by the function check that your
% cells are formatted as numbers in the excel file before saving it as csv

%%%%%%%% HOW TO CALL NETWORK TEST FUNCTION %%%%%%%%%%
%[indexguess, error, distance]= test_nnet_with_new_data('newMasks.csv','TrueLocationNewMasks.csv','NewMasksTrueIndex.csv','location.csv')
% This function takes 4 csv files
% File 1) the new masks to be used to test the
% network 
% File 2) the true locations of the test masks
% File 3) the true index of the test masks (MAKE SURE THE INDECES OF THE
% NEW MASKS CORRELATE TO THEIR RESPECTIVE INDECES FROM THE TRAINING DATA)
% File 4) list of all possible locations (SAME FILE AS FROM TRAINING THE
% NETWORK)
% This function calls the trained neural network, obtains the estimated
% location from the neural network and then calculates the MSE and the
% error in distance between the guess and actual location. Output is the
% index guess from the neural network, the mse (error), the error in
% distance, additionally this code generates a histogram of how far off the
% network guess is from the 

%% Call network building function to build network
generalized_nnet_function()

%% Call network testing function 
[indexguess, error, distance]= test_nnet_with_new_data()