close all; clear; clc;

%% Initialization
addpath(genpath('./devkit'))
base_dir = '../data/2011_09_26/2011_09_26_drive_0046_sync';
calib_dir = '../data/2011_09_26';
 
%% Read and show images
cam = 2; % Color camera
imds = imageDatastore(sprintf('%s/image_%02d/data',base_dir,cam));

% Convert the images to grayscale.
images = cell(1, numel(imds.Files));
for i = 1:numel(imds.Files)
    I = readimage(imds, i);
    images{i} = rgb2gray(I);
end

% Load camera parameters
calib = loadCalibrationCamToCam(fullfile(calib_dir,'calib_cam_to_cam.txt'));

% Create a View Set Containing the First View

% Add the Rest of the Views

% Display Camera Poses

% Compute Dense Reconstruction

% Display Dense Reconstruction