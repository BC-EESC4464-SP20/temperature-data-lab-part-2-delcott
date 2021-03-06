function [baseline_model, P, anomaly2] = StationModelProjections(station_number)

% StationModelProjections Analyze modeled future temperature projections at individual stations
%===================================================================
%
% USAGE:  [OUTPUTS] = StationModelProjections(INPUTS) <--update here
%
% DESCRIPTION:
%   **Add your description here**
%
% INPUT:
%    staton_number: Number of the station from which to analyze historical temperature data
%    **Describe any other inputs you choose to include**
%
% OUTPUT:
%    baseline_model: [mean annual temperature over baseline period
%       (2006-2025); standard deviation of temperature over baseline period]
%    P: slope and intercept for a linear fit to annual mean temperature
%       values over the full 21st century modeled period
%   **list any other outputs you choose to include**
%
% AUTHOR:   Scott Rasmussen and Delaney Vorwick
%
% REFERENCE:
%    Written for EESC 4464: Environmental Data Exploration and Analysis, Boston College
%    Data are from the a global climate model developed by the NOAA
%       Geophysical Fluid Dynamics Laboratory (GFDL) in Princeton, NJ - output
%       from the A2 scenario extracted by Sarah Purkey for the University of
%       Washington's Program on Climate Change
%==================================================================

%% Read and extract the data from your station from the csv file

filename = ['model' num2str(station_number) '.csv'];
%Extract the year and annual mean temperature data
%<--
stationdata2=readtable(filename);
yeara=stationdata2(:,1);
annualmeantemp=stationdata2(:,2);


%% Calculate the mean and standard deviation of the annual mean temperatures
%  over the baseline period over the first 20 years of the modeled 21st
%  century (2006-2025) - if you follow the template for output values I
%  provided above, you will want to combine these together into an array
%  with both values called baseline_model
 %<-- (this will take multiple lines of code - see the procedure you
 %followed in Part 1 for a reminder of how you can do this)
 
baselineyears=find(stationdata2.Year>2006 & stationdata2.Year<2025);
annualmeantemp=table2array(annualmeantemp);
baselinemean=mean(annualmeantemp(baselineyears));
baselinestd=std(annualmeantemp(baselineyears));
baseline_model=[baselinemean baselinestd];


%% Calculate the 5-year moving mean smoothed annual mean temperature anomaly over the modeled period
% Note that you could choose to provide these as an output if you want to
% have these values available to plot.
 %<-- anomaly
 anomaly2=annualmeantemp-baselinemean;
 
 %<-- smoothed anomaly
smoothedanomaly2=movmean(anomaly2,5);

%% Calculate the linear trend in temperature this station over the modeled 21st century period
 %<--
 yr=stationdata2.Year
 P = polyfit(yr, anomaly2, 1);



end